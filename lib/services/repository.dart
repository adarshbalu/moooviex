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
    finalURL = finalURL + '&plot=long';
    NetworkHelper networkHelper = NetworkHelper(finalURL);
    var data = await networkHelper.getData();
    bool resultsFound = data['Response'] == 'True';
    if (resultsFound) {
      return Movie(
          title: data['Title'] ?? 'N/A',
          year: data['Year'] ?? 'N/A',
          rated: data['Rated'] ?? 'N/A',
          released: data['Released'] ?? '',
          runTime: data['Runtime'] ?? 'N/A',
          genre: data['Genre'] ?? 'N/A',
          director: data['Director'] ?? 'N/A',
          writer: data['Writer'] ?? 'N/A',
          actors: data['Actors'] ?? 'N/A',
          plot: data['Plot'] ?? 'N/A',
          language: data['Language'] ?? 'N/A',
          country: data['Country'] ?? 'N/A',
          awards: data['Awards'] ?? 'N/A',
          ratings: data['Ratings'] ?? 'N/A',
          metaScore: data['Metascore'] ?? 'N/A',
          imdbRating: data['imdbRating'] ?? 'N/A',
          imdbVotes: data['imdbVotes'] ?? 'N/A',
          imdbID: data['imdbID'] ?? 'N/A',
          type: data['Type'] ?? 'N/A',
          dvd: data['DVD'] ?? 'N/A',
          boxOffice: data['BoxOffice'] ?? 'N/A',
          production: data['Production'] ?? 'N/A',
          website: data['Website'] ?? 'N/A',
          response: data['Response'],
          posterURL: data['Poster'] ?? '');
    } else
      throw NetworkError();
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

//      finalURL = finalURL + '&page=$page';

    NetworkHelper networkHelper = NetworkHelper(finalURL);
    var data = await networkHelper.getData();
    bool resultsFound = data['Response'] == 'True';
    int totalResults =
        int.tryParse(data['totalResults']) ?? (resultsFound ? 1 : 0);
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
      throw NetworkError();

    //return [Movie()];
  }
}

class NetworkError extends Error {}
