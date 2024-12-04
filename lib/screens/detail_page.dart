import 'package:flutter/material.dart';
import '../models/movie.dart';

class DetailPage extends StatelessWidget {
  final Movie movie;

  const DetailPage({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(movie.title)),
      body: Column(
        children: [
          Image.network(
            movie.poster,
            errorBuilder: (context, error, stackTrace) {
              return Center(child: Icon(Icons.error));
            },
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              movie.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
