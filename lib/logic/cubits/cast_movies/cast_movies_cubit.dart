import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_movie/data/models/cast.dart';
import 'package:flutter_movie/data/repository/movie_repository.dart';

part 'cast_movies_state.dart';

class CastMoviesCubit extends Cubit<CastMoviesState> {
  final MovieRepository repository;
  CastMoviesCubit({required this.repository})
      : super(CastMoviesState.initial());

  Future<void> fetchCast(int movieId) async {
    try {
      emit(state.copyWith(status: CastStatus.loading));
      List<Cast> cast = await repository.fetchCast(movieId);
      emit(state.copyWith(status: CastStatus.loaded, cast: cast));
    } catch (e) {
      emit(state.copyWith(status: CastStatus.error));
    }
  }
}
