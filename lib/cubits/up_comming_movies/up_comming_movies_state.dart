// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'up_comming_movies_cubit.dart';

enum UpCommingStatus { initial, loading, loaded, error }

class UpCommingMoviesState {
  final UpCommingStatus status;
  final List<Movie> movies;
  UpCommingMoviesState({
    required this.status,
    required this.movies,
  });

  factory UpCommingMoviesState.intial() => UpCommingMoviesState(
      status: UpCommingStatus.initial, movies: List.empty());

  @override
  bool operator ==(covariant UpCommingMoviesState other) {
    if (identical(this, other)) return true;

    return other.status == status && listEquals(other.movies, movies);
  }

  @override
  int get hashCode => status.hashCode ^ movies.hashCode;

  @override
  String toString() => 'UpCommingMoviesState(status: $status, movies: $movies)';

  UpCommingMoviesState copyWith({
    UpCommingStatus? status,
    List<Movie>? movies,
  }) {
    return UpCommingMoviesState(
      status: status ?? this.status,
      movies: movies ?? this.movies,
    );
  }
}
