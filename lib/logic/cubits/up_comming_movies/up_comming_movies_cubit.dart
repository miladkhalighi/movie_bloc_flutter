// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_movie/data/models/movie.dart';
import 'package:flutter_movie/data/repository/movie_repository.dart';
import 'package:flutter_movie/logic/cubits/genre_movies/genre_movies_cubit_cubit.dart';

part 'up_comming_movies_state.dart';

class UpCommingMoviesCubit extends Cubit<UpCommingMoviesState> {
  final MovieRepository repository;
  final GenreMoviesCubit genreMoviesCubit;
  late final StreamSubscription streamSubscription;
  UpCommingMoviesCubit({
    required this.repository,
    required this.genreMoviesCubit,
  }) : super(UpCommingMoviesState.intial()) {
    streamSubscription =
        genreMoviesCubit.stream.listen((GenreMoviesState genreState) async {
      //Genre list must not be empty , becuase movies have to convert genres id to string
      if (genreState.status == GenreStatus.loaded &&
          genreState.genres.isEmpty) {
        emit(state.copyWith(status: UpCommingStatus.error));
      }
    });
  }

  Future<void> fetchUpCommingMovies() async {
    emit(state.copyWith(status: UpCommingStatus.loading));
    try {
      streamSubscription =
          genreMoviesCubit.stream.listen((GenreMoviesState genreState) async {
        if (genreState.status == GenreStatus.loaded &&
            genreState.genres.isNotEmpty) {
          final List<Movie> movies = await repository.fetchUpCommingMovies();
          emit(state.copyWith(status: UpCommingStatus.loaded, movies: movies));
        } else {
          emit(state.copyWith(status: UpCommingStatus.error));
        }
      });
    } catch (e) {
      emit(state.copyWith(status: UpCommingStatus.error));
    }
  }
}
