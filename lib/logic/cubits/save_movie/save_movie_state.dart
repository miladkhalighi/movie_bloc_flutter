// ignore_for_file: public_member_api_docs, sort_constructors_first



part of 'save_movie_cubit.dart';

enum SavedMovieStatus { saved, unsaved, unknown }

class SaveMovieState {
  final List<Movie> movies;
  final SavedMovieStatus status;
  const SaveMovieState({
    required this.movies,
    required this.status,
  });

  factory SaveMovieState.initial() => const SaveMovieState(movies: [],status: SavedMovieStatus.unknown);

  SaveMovieState copyWith({
    List<Movie>? movies,
    SavedMovieStatus? status,
  }) {
    return SaveMovieState(
      movies: movies ?? this.movies,
      status: status ?? this.status,
    );
  }

  @override
  String toString() => 'SaveMovieState(movies: $movies)';

  @override
  List<Object> get props => [movies, status];

  @override
  bool get stringify => true;

  @override
  bool operator ==(covariant SaveMovieState other) {
    if (identical(this, other)) return true;
  
    return 
      listEquals(other.movies, movies) &&
      other.status == status;
  }

  @override
  int get hashCode => movies.hashCode ^ status.hashCode;
}
