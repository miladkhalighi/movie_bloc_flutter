// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'most_popular_movies_cubit_cubit.dart';

enum MostPupularMoviesStatus { initial, loading, loaded, error }

class MostPoularMoviesState {
  final MostPupularMoviesStatus status;
  final List<Movie> movies;

  MostPoularMoviesState({required this.status, required this.movies});

  factory MostPoularMoviesState.initial() => MostPoularMoviesState(
      status: MostPupularMoviesStatus.initial, movies: List.empty());

  @override
  bool operator ==(covariant MostPoularMoviesState other) {
    if (identical(this, other)) return true;

    return other.status == status && other.movies == movies;
  }

  @override
  int get hashCode => status.hashCode ^ movies.hashCode;

  @override
  String toString() => 'MostPoularMoviesState(status: $status, movie: $movies)';

  MostPoularMoviesState copyWith({
    MostPupularMoviesStatus? status,
    List<Movie>? movies,
  }) {
    return MostPoularMoviesState(
      status: status ?? this.status,
      movies: movies ?? this.movies,
    );
  }
}
