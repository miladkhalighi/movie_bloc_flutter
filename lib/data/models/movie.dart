// ignore_for_file: public_member_api_docs, sort_constructors_first


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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'overview': overview,
      'releaseDate': releaseDate,
      'voteAverage': voteAverage,
      'posterPath': posterPath,
      'backdropPath': backdropPath,
      'genreIds': genreIds,
      'adult': adult,
      'runtime': runtime,
      'originalLanguage': originalLanguage,
      'originalTitle': originalTitle,
      'status': status,
    };
  }

  Map<String, dynamic> toJson() {
  return <String, dynamic>{
    'id': id,
    'title': title,
    'overview': overview,
    'release_date': releaseDate,
    'vote_average': voteAverage,
    'poster_path': posterPath,
    'backdrop_path': backdropPath,
    'genre_ids': genreIds,
    'adult': adult,
    'runtime': runtime,
    'original_language': originalLanguage,
    'original_title': originalTitle,
    'status': status,
  };
}

}
