// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'top_rated_movies_cubit.dart';

enum TopRatedStatus { initial, loading, loaded, error }

class TopRatedMoviesState {
  final TopRatedStatus status;
  final List<Movie> movies;
  TopRatedMoviesState({
    required this.status,
    required this.movies,
  });

  factory TopRatedMoviesState.intial() =>
      TopRatedMoviesState(status: TopRatedStatus.initial, movies: List.empty());

  @override
  bool operator ==(covariant TopRatedMoviesState other) {
    if (identical(this, other)) return true;

    return other.status == status && listEquals(other.movies, movies);
  }

  @override
  int get hashCode => status.hashCode ^ movies.hashCode;

  @override
  String toString() => 'TopRatedMoviesState(status: $status, movies: $movies)';

  TopRatedMoviesState copyWith({
    TopRatedStatus? status,
    List<Movie>? movies,
  }) {
    return TopRatedMoviesState(
      status: status ?? this.status,
      movies: movies ?? this.movies,
    );
  }
}
