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
    if (event is SearchMovies) {
      try {
        final List<Movie> moviesFound =
            await abstractMovieRepository.searchMovie(
                title: event.title,
                page: event.page,
                year: event.year,
                type: event.type);
        yield MovieSearched(moviesFound: moviesFound);
      } on NetworkError {
        yield MovieError("Couldn't fetch Movies. Is the device online?");
      }
    } else if (event is GetMovieDetails) {
      try {
        final movie = await abstractMovieRepository.getMovieDetails(
            imdbID: event.imdbID,
            type: event.type,
            title: event.title,
            year: event.year,
            posterURL: event.posterURL);
        yield MovieLoaded(movie);
      } on NetworkError {
        yield MovieError("Couldn't fetch Details. Is the device online?");
      }
    } else
      yield MovieError("Couldn't fetch Movie. Is the device online?");
  }
}
