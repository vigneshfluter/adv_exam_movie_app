import 'dart:convert';

import 'package:flutter/material.dart';
import '../helpers/helper.dart';

class LikedMoviesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Liked Movies')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: SharedPreferencesHelper.getLikedMovies(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final likedMovies = snapshot.data ?? [];
          return ListView.builder(
            itemCount: likedMovies.length,
            itemBuilder: (context, index) {
              final movie = likedMovies[index];
              return ListTile(
                title: Text(movie['title']),
                subtitle: Text(movie['year']),
                leading: Image.network(movie['poster']),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    await SharedPreferencesHelper.removeLikedMovie(json.encode(movie));
                    // Rebuild the list
                    (context as Element).markNeedsBuild();
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
