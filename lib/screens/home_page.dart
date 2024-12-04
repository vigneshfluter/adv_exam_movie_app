import 'package:flutter/material.dart';
import '../helpers/api_service.dart';
import '../models/movie.dart';
import 'detail_page.dart';
import 'liked_movies_page.dart';
import 'liked_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  List<Movie> _movies = [];
  List<Movie> _likedMovies = []; // List to store liked movies
  String? _errorMessage;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadInitialMovies();
  }

  void _loadInitialMovies() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final movies = await ApiService().searchMovies('Avengers'); // Default query
      setState(() {
        _movies = movies;
      });
    } catch (error) {
      setState(() {
        _errorMessage = error.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _searchMovies() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final query = _controller.text.trim();
    if (query.isNotEmpty) {
      try {
        final movies = await ApiService().searchMovies(query);
        setState(() {
          _movies = movies;
        });
      } catch (error) {
        setState(() {
          _errorMessage = error.toString();
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _toggleLike(Movie movie) {
    setState(() {
      if (_likedMovies.contains(movie)) {
        _likedMovies.remove(movie);
      } else {
        _likedMovies.add(movie);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Browser'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LikedPage(likedMovies: _likedMovies),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Search for a movie',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              onSubmitted: (_) => _searchMovies(),
            ),
          ),
          if (_isLoading)
            Center(child: CircularProgressIndicator())
          else if (_errorMessage != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _errorMessage!,
                style: TextStyle(color: Colors.red),
              ),
            )
          else
            Expanded(
              child: _movies.isEmpty
                  ? Center(child: Text('No movies found!'))
                  : GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.65,
                ),
                itemCount: _movies.length,
                itemBuilder: (context, index) {
                  final movie = _movies[index];
                  final isLiked = _likedMovies.contains(movie);
                  return MovieCard(
                    movie: movie,
                    isLiked: isLiked,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(movie: movie),
                      ),
                    ),
                    onLike: () => _toggleLike(movie),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

class MovieCard extends StatelessWidget {
  final Movie movie;
  final bool isLiked;
  final VoidCallback onTap;
  final VoidCallback onLike;

  const MovieCard({
    Key? key,
    required this.movie,
    required this.isLiked,
    required this.onTap,
    required this.onLike,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                child: Image.network(
                  movie.poster,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Center(child: Icon(Icons.error, size: 50));
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      movie.title,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      isLiked ? Icons.favorite : Icons.favorite_border,
                      color: isLiked ? Colors.red : Colors.grey,
                    ),
                    onPressed: onLike,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}