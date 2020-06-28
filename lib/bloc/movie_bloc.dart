import 'dart:async';

import 'package:bloc/bloc.dart';

import 'bloc.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  @override
  MovieState get initialState => InitialMovieState();

  @override
  Stream<MovieState> mapEventToState(
    MovieEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
