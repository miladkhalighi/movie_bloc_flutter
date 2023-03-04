import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_movie/data/models/crew.dart';
import 'package:flutter_movie/data/repository/movie_repository.dart';

part 'crew_movies_state.dart';

class CrewMoviesCubit extends Cubit<CrewMoviesState> {
  final MovieRepository repository;
  CrewMoviesCubit({required this.repository})
      : super(CrewMoviesState.initial());

  Future<void> fetchCrew(int movieId) async {
    try {
      emit(state.copyWith(status: CrewStatus.loading));
      var crew = await repository.fetchCrew(movieId);
      emit(state.copyWith(status: CrewStatus.loaded,crew: crew));
    } catch (e) {
      emit(state.copyWith(status: CrewStatus.error));
    }
  }
}
