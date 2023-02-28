// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'cast_movies_cubit.dart';

enum CastStatus { initial, loading, loaded, error }

class CastMoviesState {
  final CastStatus status;
  final Cast cast;
  CastMoviesState({
    required this.status,
    required this.cast,
  });

  factory CastMoviesState.initial() =>
      CastMoviesState(status: CastStatus.initial, cast: Cast.initial());

  @override
  bool operator ==(covariant CastMoviesState other) {
    if (identical(this, other)) return true;

    return other.status == status && other.cast == cast;
  }

  @override
  int get hashCode => status.hashCode ^ cast.hashCode;

  @override
  String toString() => 'CastMoviesState(status: $status, cast: $cast)';

  CastMoviesState copyWith({
    CastStatus? status,
    Cast? cast,
  }) {
    return CastMoviesState(
      status: status ?? this.status,
      cast: cast ?? this.cast,
    );
  }
}
