import 'package:moooviex/bloc/bloc.dart';
import 'package:moooviex/models/movie.dart';
import 'package:moooviex/services/network.dart';
import 'package:moooviex/utits/constants.dart';

abstract class AbstractMovieRepository {
  Future<List<Movie>> searchMovie(
      {String title, String type, String year, int page});
  Future<Movie> getMovieDetails(
      {String imdbID,
      String title,
      String type,
      String year,
      String posterURL});
}

class MovieRepository implements AbstractMovieRepository {
  @override
  Future<Movie> getMovieDetails(
      {String imdbID,
      String title,
      String type,
      String year,
      String posterURL}) async {
    final String _apiUrl = 'http://www.omdbapi.com/?apikey=$kApiKey';
    String finalURL = _apiUrl;
    finalURL = finalURL + '&i=$imdbID';
    NetworkHelper networkHelper = NetworkHelper(finalURL);
    var data = await networkHelper.getData();
    bool resultsFound = data['Response'] == 'True';
    if (resultsFound) {
      return Movie(
          title: data['Title'],
          year: data['Year'],
          rated: data['Rated'],
          released: data['Released'],
          runTime: data['Runtime'],
          genre: data['Genre'],
          director: data['Director'],
          writer: data['Writer'],
          actors: data['Actors'],
          plot: data['Plot'],
          language: data['Language'],
          country: data['Country'],
          awards: data['Awards'],
          ratings: data['Ratings'],
          metaScore: data['Metascore'],
          imdbRating: data['imdbRating'],
          imdbVotes: data['imdbVotes'],
          imdbID: data['imdbID'],
          type: data['Type'],
          dvd: data['DVD'],
          boxOffice: data['BoxOffice'],
          production: data['Production'],
          website: data['Website'],
          response: data['Response'],
          posterURL: data['Poster']);
    } else
      throw MovieError('Movie Not found');
  }

  @override
  Future<List<Movie>> searchMovie(
      {String title, String type, String year, int page}) async {
    final String _apiUrl = 'http://www.omdbapi.com/?apikey=$kApiKey';
    String finalURL = _apiUrl;
    if (title.isNotEmpty) {
      finalURL = finalURL + '&s=$title';
    }
    if (year.isNotEmpty && year != '') {
      int yearNumber = int.parse(year);
      if (yearNumber > 1900 && yearNumber < DateTime.now().year - 1) {
        finalURL = finalURL + '&y=$yearNumber';
      }
    }
    if (type.isNotEmpty && type != '') {
      if (type != 'all') finalURL = finalURL + '&type=$type';
    }

    if (page > 0 && page < 100) {
      finalURL = finalURL + '&page=$page';
    }
    NetworkHelper networkHelper = NetworkHelper(finalURL);
    var data = await networkHelper.getData();
    bool resultsFound = data['Response'] == 'True';
    int totalResults = int.parse(data['totalResults']);
    List<Movie> moviesFound = [];
    if (resultsFound && totalResults >= 1) {
      List movieList = data['Search'];
      for (var m in movieList) {
        moviesFound.add(Movie(
            title: m['Title'],
            year: m['Year'],
            imdbID: m['imdbID'],
            type: m['Type'],
            posterURL: m['Poster']));
      }

      return moviesFound;
    } else
      throw MovieError('Movie Not found');
  }
}

class NetworkError extends Error {}
