import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_movie/data/models/movie.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'dart:convert';

part 'save_movie_state.dart';

class SaveMovieCubit extends Cubit<SaveMovieState> with HydratedMixin {
  SaveMovieCubit() : super(SaveMovieState.initial());

  Future<void> toggleMovie(Movie movie) async {
    contains(movie) ? removeMovie(movie) : addMovie(movie);
  }

  Future<void> addMovie(Movie movie) async {
    final newMovies = List<Movie>.from(state.movies)..add(movie);
    emit(state.copyWith(movies: newMovies, status: SavedMovieStatus.saved));
  }

  Future<void> removeMovie(Movie movie) async {
    final newMovies = List<Movie>.from(state.movies)..remove(movie);
    emit(state.copyWith(movies: newMovies, status: SavedMovieStatus.unsaved));
  }

  bool contains(Movie movie) {
    bool res = false;
    for (var i = 0; i < state.movies.length; i++) {
      if (state.movies[i].id == movie.id) {
        res = true;
      }
    }
    return res;
  }

  Future<void> fetchMove(Movie movie) async {
    emit(state.copyWith(status: SavedMovieStatus.unknown));
    if (contains(movie)) {
      emit(state.copyWith(status: SavedMovieStatus.saved));
    } else {
      emit(state.copyWith(status: SavedMovieStatus.unsaved));
    }
    print(state.status.toString());
    print(state.movies.toString());
  }

  @override
  SaveMovieState? fromJson(Map<String, dynamic> json) {
    //print('\nHydrated movies: $json');
    List<dynamic> moviesJson = json['movies'] ?? [];
    List<Movie> movies =
        moviesJson.map((json) => Movie.fromJson(json)).toList();
    //print('\nConverted movies: $movies');
    return SaveMovieState(movies: movies, status: state.status);
  }

  @override
  Map<String, dynamic>? toJson(SaveMovieState state) {
    //print('\nTO JSON CUBIT\n$state');
    return {'movies': state.movies.map((movie) => movie.toJson()).toList()};
  }
}
