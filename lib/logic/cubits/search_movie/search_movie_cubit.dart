import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_movie/data/models/movie.dart';
import 'package:flutter_movie/data/repository/movie_repository.dart';

part 'search_movie_state.dart';

class SearchMovieCubit extends Cubit<SearchMovieState> {
  final MovieRepository repository;
  SearchMovieCubit({required this.repository})
      : super(SearchMovieState.initial());

  searchItemByTitle(String title) async {
    emit(state.copyWith(title: title));
    if (title.length > 2) {
      emit(state.copyWith(status: SearchStatus.loading));
      try {
        List<Movie> movies = await repository.fetchMoviesByTitle(title);
        emit(state.copyWith(movies: movies, status: SearchStatus.loaded));
      } catch (e) {
        emit(state.copyWith(status: SearchStatus.error));
      }
    }
  }

  updateAppbarHeight(double height) {
    emit(state.copyWith(appBarHeight: height));
  }

  showAppbar(bool show) {
    emit(state.copyWith(showAppbar: show));
  }
}
