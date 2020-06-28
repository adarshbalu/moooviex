import 'package:equatable/equatable.dart';
import 'package:moooviex/models/movie.dart';

abstract class MovieState extends Equatable {
  const MovieState();
}

class MovieInitial extends MovieState {
  @override
  List<Object> get props => [];
}

class MovieLoading extends MovieState {
  const MovieLoading();
  @override
  List<Object> get props => [];
}

class MovieLoaded extends MovieState {
  final List<Movie> moviesFound;
  final Movie movie;
  const MovieLoaded({this.moviesFound, this.movie});
  @override
  List<Object> get props => [moviesFound];
}

class MovieError extends MovieState {
  final String message;
  const MovieError(this.message);
  @override
  List<Object> get props => [message];
}
