import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../utils/shared_preferences_helper.dart';

class DetailPage extends StatelessWidget {
  final Movie movie;

  DetailPage({required this.movie});

  void _likeMovie(BuildContext context) async {
    await SharedPreferencesHelper.saveLikedMovie(json.encode(movie.toJson()));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Movie liked!')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(movie.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(movie.poster),
            Text(movie.title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('Year: ${movie.year}'),
            SizedBox(height: 10),
            Text('Plot: ${movie.plot}'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _likeMovie(context),
              child: Text('Like this movie'),
            ),
          ],
        ),
      ),
    );
  }
}
