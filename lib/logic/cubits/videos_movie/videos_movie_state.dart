// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'videos_movie_cubit.dart';

enum VideosStatus { initial, loading, loaded, error }

class VideosMovieState {
  final VideosStatus status;
  final List<String> movieIds;
  VideosMovieState({
    required this.status,
    required this.movieIds,
  });

  factory VideosMovieState.initial() =>
      VideosMovieState(status: VideosStatus.initial, movieIds: []);

  @override
  bool operator ==(covariant VideosMovieState other) {
    if (identical(this, other)) return true;

    return other.status == status && listEquals(other.movieIds, movieIds);
  }

  @override
  int get hashCode => status.hashCode ^ movieIds.hashCode;

  VideosMovieState copyWith({
    VideosStatus? status,
    List<String>? movieIds,
  }) {
    return VideosMovieState(
      status: status ?? this.status,
      movieIds: movieIds ?? this.movieIds,
    );
  }

  @override
  String toString() =>
      'VideosMovieStates(status: $status, movieIds: $movieIds)';
}
