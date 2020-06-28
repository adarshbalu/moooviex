import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:moooviex/models/movie.dart';
import 'package:moooviex/services/repository.dart';

import 'bloc.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final AbstractMovieRepository abstractMovieRepository;
  MovieBloc(this.abstractMovieRepository);
  @override
  MovieState get initialState => MovieInitial();

  @override
  Stream<MovieState> mapEventToState(
    MovieEvent event,
  ) async* {
    yield MovieLoading();
    if (event is GetMovie) {
      try {
        final List<Movie> moviesFound =
            await abstractMovieRepository.searchMovie(
                title: event.title,
                page: event.page,
                year: event.year,
                type: event.type);
        yield MovieLoaded(moviesFound: moviesFound);
      } on NetworkError {
        yield MovieError("Couldn't fetch weather. Is the device online?");
      }
    } else if (event is GetMovieDetails) {
      try {
        final movie = await abstractMovieRepository.getMovieDetails();
        yield MovieLoaded(movie: movie);
      } on NetworkError {
        yield MovieError("Couldn't fetch weather. Is the device online?");
      }
    }
  }
}
