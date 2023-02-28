import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_movie/cubits/genre_movies/genre_movies_cubit_cubit.dart';
import 'package:flutter_movie/models/movie.dart';
import 'package:flutter_movie/repository/movie_repository.dart';

part 'most_popular_movies_cubit_state.dart';

class MostPopularMoviesCubit extends Cubit<MostPoularMoviesState> {
  final MovieRepository movieRepository;
  final GenreMoviesCubit genreMoviesCubit;
  late final StreamSubscription genreSubscription;
  MostPopularMoviesCubit(
      {required this.movieRepository, required this.genreMoviesCubit})
      : super(MostPoularMoviesState.initial()) {
    genreSubscription =
        genreMoviesCubit.stream.listen((GenreMoviesState genreState) {
      //Genre list must not be empty , becuase movies have to convert genres id to string
      if (genreState.status == GenreStatus.loaded &&
          genreState.genres.isEmpty) {
        emit(state.copyWith(status: MostPupularMoviesStatus.error));
      }
    });
  }

  Future<void> fetchMostPopularMovies() async {
    emit(state.copyWith(status: MostPupularMoviesStatus.loading));
    try {
      genreSubscription =
          genreMoviesCubit.stream.listen((GenreMoviesState genreState) async {
        //Genre list must not be empty , becuase movies have to convert genres id to string
        if (genreState.status == GenreStatus.loaded &&
            genreState.genres.isNotEmpty) {
          final List<Movie> movies =
              await movieRepository.fetchMostPoularMovies();
          emit(state.copyWith(
              status: MostPupularMoviesStatus.loaded, movies: movies));
        } else {
            emit(state.copyWith(status: MostPupularMoviesStatus.error));
        }
      });
    } catch (e) {
      emit(state.copyWith(status: MostPupularMoviesStatus.error));
    }
  }

  @override
  Future<void> close() {
    genreSubscription.cancel();
    return super.close();
  }
}
