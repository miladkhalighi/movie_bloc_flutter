// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'genre_movies_cubit_cubit.dart';

enum GenreStatus { initial, loading, loaded, error }

class GenreMoviesState {
  final GenreStatus status;
  final List<Genre> genres;
  GenreMoviesState({
    required this.status,
    required this.genres,
  });

  factory GenreMoviesState.initial() =>
      GenreMoviesState(status: GenreStatus.initial, genres: List.empty());

  @override
  String toString() => 'GenreMoviesState(status: $status, genres: $genres)';

  GenreMoviesState copyWith({
    GenreStatus? status,
    List<Genre>? genres,
  }) {
    return GenreMoviesState(
      status: status ?? this.status,
      genres: genres ?? this.genres,
    );
  }

  @override
  bool operator ==(covariant GenreMoviesState other) {
    if (identical(this, other)) return true;

    return other.status == status && listEquals(other.genres, genres);
  }

  @override
  int get hashCode => status.hashCode ^ genres.hashCode;
}
