// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'cast_movies_cubit.dart';

enum CastStatus { initial, loading, loaded, error }

class CastMoviesState {
  final CastStatus status;
  final List<Cast> cast;
  CastMoviesState({
    required this.status,
    required this.cast,
  });

  factory CastMoviesState.initial() =>
      CastMoviesState(status: CastStatus.initial, cast: []);



  @override
  bool operator ==(covariant CastMoviesState other) {
    if (identical(this, other)) return true;
  
    return 
      other.status == status &&
      listEquals(other.cast, cast);
  }

  @override
  int get hashCode => status.hashCode ^ cast.hashCode;

  CastMoviesState copyWith({
    CastStatus? status,
    List<Cast>? cast,
  }) {
    return CastMoviesState(
      status: status ?? this.status,
      cast: cast ?? this.cast,
    );
  }

  @override
  String toString() => 'CastMoviesState(status: $status, cast: $cast)';
}
