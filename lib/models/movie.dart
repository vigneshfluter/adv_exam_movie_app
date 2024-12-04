class Movie {
  final String imdbID;
  final String title;
  final String poster;

  Movie({
    required this.imdbID,
    required this.title,
    required this.poster,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      imdbID: json['imdbID'] ?? '', // Provide a default empty string if null
      title: json['Title'] ?? 'No Title', // Handle missing or null values
      poster: json['Poster'] ?? 'https://via.placeholder.com/150', // Default image if null
    );
  }
}
