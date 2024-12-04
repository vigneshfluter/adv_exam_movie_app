class Movie {
  final String title;
  final String year;
  final String imdbID;
  final String poster;
  final String plot;

  Movie({this.title, this.year, this.imdbID, this.poster, this.plot});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['Title'],
      year: json['Year'],
      imdbID: json['imdbID'],
      poster: json['Poster'],
      plot: json['Plot'],
    );
  }
}
