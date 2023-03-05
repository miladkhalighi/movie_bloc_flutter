import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_movie/data/repository/movie_repository.dart';

part 'photos_movie_state.dart';

class PhotosMovieCubit extends Cubit<PhotosMoviesStates> {
  final MovieRepository repository;
  PhotosMovieCubit({required this.repository})
      : super(PhotosMoviesStates.initial());

  Future<void> fetchMoviePhotos(int movieId) async {
    try {
      emit(state.copyWith(status: PhotosStatus.loading));
      final photos = await repository.fetchMoviePhotos(movieId);
      emit(state.copyWith(status: PhotosStatus.loaded, photos: photos));
    } catch (e) {
      emit(state.copyWith(status: PhotosStatus.error));
    }
  }

  void setItemIndex(int index) {
    emit(state.copyWith(selectedItem: index));
  }
}
