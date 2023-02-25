class Movie {
  final int id;
  final String title;
  final String overview;
  final String? releaseDate;
  final double? voteAverage;
  final String? posterPath;
  final String? backdropPath;
  final List<int>? genreIds;
  final bool? adult;
  final int? runtime;
  final String? originalLanguage;
  final String? originalTitle;
  final String? status;

  Movie({
    required this.id,
    required this.title,
    required this.overview,
    this.releaseDate,
    this.voteAverage,
    this.posterPath,
    this.backdropPath,
    this.genreIds,
    this.adult,
    this.runtime,
    this.originalLanguage,
    this.originalTitle,
    this.status,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      overview: json['overview'],
      releaseDate: json['release_date'],
      voteAverage: json['vote_average']?.toDouble(),
      posterPath: json['poster_path'],
      backdropPath: json['backdrop_path'],
      genreIds:
          json['genre_ids'] != null ? List<int>.from(json['genre_ids']) : null,
      adult: json['adult'],
      runtime: json['runtime'],
      originalLanguage: json['original_language'],
      originalTitle: json['original_title'],
      status: json['status'],
    );
  }

  factory Movie.initial() => Movie(id: -1, title: 'title', overview: 'overview');

  String get posterUrl => 'https://image.tmdb.org/t/p/w500/$posterPath';

  String get backdropUrl => 'https://image.tmdb.org/t/p/w780/$backdropPath';
}
