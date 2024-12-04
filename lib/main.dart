import 'package:flutter/material.dart';
import 'package:movies_app/screens/home_page.dart';
import 'package:movies_app/screens/liked_movies_page.dart';
import 'package:movies_app/screens/splash_screen.dart';


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
