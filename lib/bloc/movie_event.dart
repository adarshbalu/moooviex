import 'package:equatable/equatable.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();
}

class GetMovie extends MovieEvent {
  final String title, type, year;
  final int page;
  const GetMovie({this.title, this.type, this.year, this.page});

  @override
  List<Object> get props => [title, type, year, page];
}

class GetMovieDetails extends MovieEvent {
  final String imdbID, title, type, year;
  const GetMovieDetails({this.year, this.type, this.title, this.imdbID});

  @override
  List<Object> get props => [year, type, title, imdbID];
}
