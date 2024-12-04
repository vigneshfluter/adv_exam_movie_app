import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie.dart';

class ApiService {
  Future<List<Movie>> searchMovies(String query) async {
    final url = Uri.parse('https://www.omdbapi.com/?s=$query&apikey=12f651aa');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['Response'] == 'True') {
        final List movies = data['Search'];
        return movies.map((movie) => Movie.fromJson(movie)).toList();
      } else {
        throw Exception(data['Error'] ?? 'Unknown error occurred');
      }
    } else {
      throw Exception('Failed to fetch movies');
    }
  }
}
