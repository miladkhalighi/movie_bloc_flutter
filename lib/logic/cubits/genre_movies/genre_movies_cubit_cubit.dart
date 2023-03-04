import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_movie/data/models/genre.dart';
import 'package:flutter_movie/data/repository/movie_repository.dart';

part 'genre_movies_cubit_state.dart';

class GenreMoviesCubit extends Cubit<GenreMoviesState> {
  final MovieRepository movieRepository;
  GenreMoviesCubit({required this.movieRepository})
      : super(GenreMoviesState.initial());

  Future<void> fetchGenres() async {
    emit(state.copyWith(status: GenreStatus.initial));
    try {
      emit(state.copyWith(status: GenreStatus.loading));
      final List<Genre> genres = await movieRepository.fetchGenres();
      emit(state.copyWith(status: GenreStatus.loaded,genres: genres));
    } catch (e) {
      emit(state.copyWith(status: GenreStatus.error));
    }
  }
}
