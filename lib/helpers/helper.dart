import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SharedPreferencesHelper {
  static Future<void> saveLikedMovie(String movieJson) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> likedMovies = prefs.getStringList('likedMovies') ?? [];
    likedMovies.add(movieJson);
    await prefs.setStringList('likedMovies', likedMovies);
  }

  static Future<List<Map<String, dynamic>>> getLikedMovies() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> likedMovies = prefs.getStringList('likedMovies') ?? [];
    return likedMovies.map((movie) => json.decode(movie) as Map<String, dynamic>).toList();
  }

  static Future<void> removeLikedMovie(String movieJson) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> likedMovies = prefs.getStringList('likedMovies') ?? [];
    likedMovies.remove(movieJson);
    await prefs.setStringList('likedMovies', likedMovies);
  }
}
