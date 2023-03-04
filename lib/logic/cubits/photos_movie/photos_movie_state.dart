// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'photos_movie_cubit.dart';

enum PhotosStatus { initial, loading, loaded, error }

class PhotosMoviesStates {
  final PhotosStatus status;
  final List<String> photos;
  PhotosMoviesStates({
    required this.status,
    required this.photos,
  });

  factory PhotosMoviesStates.initial() =>
      PhotosMoviesStates(status: PhotosStatus.initial, photos: []);

  @override
  bool operator ==(covariant PhotosMoviesStates other) {
    if (identical(this, other)) return true;

    return other.status == status && listEquals(other.photos, photos);
  }

  @override
  int get hashCode => status.hashCode ^ photos.hashCode;

  PhotosMoviesStates copyWith({
    PhotosStatus? status,
    List<String>? photos,
  }) {
    return PhotosMoviesStates(
      status: status ?? this.status,
      photos: photos ?? this.photos,
    );
  }

  @override
  String toString() => 'PhotosMoviesStates(status: $status, photos: $photos)';
}
