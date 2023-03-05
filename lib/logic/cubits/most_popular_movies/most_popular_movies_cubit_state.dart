// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'most_popular_movies_cubit_cubit.dart';

enum MostPupularMoviesStatus { initial, loading, loaded, error }

class MostPoularMoviesState {
  final MostPupularMoviesStatus status;
  final List<Movie> movies;
  final int selectedItem;

  MostPoularMoviesState({
    required this.status,
    required this.movies,
    required this.selectedItem,
  });

  factory MostPoularMoviesState.initial() => MostPoularMoviesState(
      status: MostPupularMoviesStatus.initial, movies: List.empty(), selectedItem: 0);

  @override
  bool operator ==(covariant MostPoularMoviesState other) {
    if (identical(this, other)) return true;
  
    return 
      other.status == status &&
      listEquals(other.movies, movies) &&
      other.selectedItem == selectedItem;
  }

  @override
  int get hashCode => status.hashCode ^ movies.hashCode ^ selectedItem.hashCode;

  @override
  String toString() => 'MostPoularMoviesState(status: $status, movies: $movies, selectedItem: $selectedItem)';

  MostPoularMoviesState copyWith({
    MostPupularMoviesStatus? status,
    List<Movie>? movies,
    int? selectedItem,
  }) {
    return MostPoularMoviesState(
      status: status ?? this.status,
      movies: movies ?? this.movies,
      selectedItem: selectedItem ?? this.selectedItem,
    );
  }
}
