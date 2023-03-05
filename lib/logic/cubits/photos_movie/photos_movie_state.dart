// ignore_for_file: public_member_api_docs, sort_constructors_first


part of 'photos_movie_cubit.dart';

enum PhotosStatus { initial, loading, loaded, error }

class PhotosMoviesStates {
  final PhotosStatus status;
  final List<String> photos;
  final int selectedItem;
  PhotosMoviesStates({
    required this.status,
    required this.photos,
    required this.selectedItem,
  });

    factory PhotosMoviesStates.initial() =>
      PhotosMoviesStates(status: PhotosStatus.initial, photos: [], selectedItem: 0);

  @override
  bool operator ==(covariant PhotosMoviesStates other) {
    if (identical(this, other)) return true;
  
    return 
      other.status == status &&
      listEquals(other.photos, photos) &&
      other.selectedItem == selectedItem;
  }

  @override
  int get hashCode => status.hashCode ^ photos.hashCode ^ selectedItem.hashCode;

  PhotosMoviesStates copyWith({
    PhotosStatus? status,
    List<String>? photos,
    int? selectedItem,
  }) {
    return PhotosMoviesStates(
      status: status ?? this.status,
      photos: photos ?? this.photos,
      selectedItem: selectedItem ?? this.selectedItem,
    );
  }

  @override
  String toString() => 'PhotosMoviesStates(status: $status, photos: $photos, selectedItem: $selectedItem)';
}
