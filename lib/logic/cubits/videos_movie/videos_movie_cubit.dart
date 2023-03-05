import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_movie/data/repository/movie_repository.dart';

part 'videos_movie_state.dart';

class VideosMovieCubit extends Cubit<VideosMovieState> {
  final MovieRepository repository;
  VideosMovieCubit({required this.repository})
      : super(VideosMovieState.initial());

  Future<void> fetchYouTubeMovieIds(int movieId) async {
    try {
      emit(state.copyWith(status: VideosStatus.loading));
      List<String> youtubeIds = await repository.fetchMovieVideos(movieId);
      emit(state.copyWith(status: VideosStatus.loaded,movieIds: youtubeIds));
    } catch (e) {
      emit(state.copyWith(status: VideosStatus.error));
    }
  }
}
