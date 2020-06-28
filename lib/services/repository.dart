import 'package:moooviex/models/movie.dart';

abstract class AbstractMovieRepository {
  Future<Movie> searchMovie({String title, String type, String year, int page});
  Future<Movie> getMovieDetails(
      {String imdbID, String title, String type, String year, String plot});
}

class MovieRepository implements AbstractMovieRepository {
  @override
  Future<Movie> getMovieDetails(
      {String imdbID, String title, String type, String year, String plot}) {
    // TODO: implement getMovieDetails
    throw UnimplementedError();
  }

  @override
  Future<Movie> searchMovie(
      {String title, String type, String year, int page}) {
    // TODO: implement searchMovie
    throw UnimplementedError();
  }
}

class NetworkError extends Error {}
