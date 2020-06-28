import 'package:equatable/equatable.dart';

abstract class MovieState extends Equatable {
  const MovieState();
}

class InitialMovieState extends MovieState {
  @override
  List<Object> get props => [];
}
