import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/liked_movies_page.dart';
import 'pages/splash_screen.dart';

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
      routes: {
        '/home': (context) => HomePage(),
        '/liked': (context) => LikedMoviesPage(),
      },
    );
  }
}
