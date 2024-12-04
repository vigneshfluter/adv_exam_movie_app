import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie.dart';

class ApiService {
  final String apiKey = '12f651aa'; // Your OMDb API key

  Future<List<Movie>> searchMovies(String query) async {
    final url = 'https://www.omdbapi.com/?s=$query&apikey=$apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<Movie> movies = [];
      if (data['Search'] != null) {
        for (var movie in data['Search']) {
          movies.add(Movie.fromJson(movie));
        }
      }
      return movies;
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<Movie> getMovieDetail(String imdbID) async {
    final url = 'https://www.omdbapi.com/?i=$imdbID&apikey=$apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Movie.fromJson(data);
    } else {
      throw Exception('Failed to load movie details');
    }
  }
}
