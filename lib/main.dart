import 'package:flutter/material.dart';
import 'package:movies_app/screens/home_page.dart';
import 'package:movies_app/screens/liked_movies_page.dart';
import 'package:movies_app/screens/splash_screen.dart';
import 'package:movies_app/models/movie.dart';

void main() {
  runApp(MovieBrowserApp());
}

class MovieBrowserApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie Browser',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SplashScreen(),
      onGenerateRoute: (settings) {
        // Dynamically handle routes
        switch (settings.name) {
          case '/home':
            return MaterialPageRoute(builder: (_) => HomePage());
          case '/liked':
            final args = settings.arguments as List<Movie>?; // Get liked movies
            if (args == null) {
              return MaterialPageRoute(
                builder: (_) => Scaffold(
                  body: Center(child: Text('Error: No liked movies provided.')),
                ),
              );
            }
            return MaterialPageRoute(
              builder: (_) => LikedPage(likedMovies: args),
            );
          default:
            return MaterialPageRoute(
              builder: (_) => Scaffold(
                body: Center(child: Text('Error: Unknown route.')),
              ),
            );
        }
      },
    );
  }
}
