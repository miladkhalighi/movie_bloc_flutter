// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'crew_movies_cubit.dart';

enum CrewStatus { initial, loading, loaded, error }

class CrewMoviesState {
  final CrewStatus status;
  final Crew crew;
  CrewMoviesState({
    required this.status,
    required this.crew,
  });

  factory CrewMoviesState.initial() => CrewMoviesState(status: CrewStatus.initial, crew: Crew.initial());

  @override
  bool operator ==(covariant CrewMoviesState other) {
    if (identical(this, other)) return true;

    return other.status == status && other.crew == crew;
  }

  @override
  int get hashCode => status.hashCode ^ crew.hashCode;

  @override
  String toString() => 'CrewMoviesState(status: $status, crew: $crew)';

  CrewMoviesState copyWith({
    CrewStatus? status,
    Crew? crew,
  }) {
    return CrewMoviesState(
      status: status ?? this.status,
      crew: crew ?? this.crew,
    );
  }
}
