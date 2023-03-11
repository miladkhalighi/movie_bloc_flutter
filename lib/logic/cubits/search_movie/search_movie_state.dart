// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'search_movie_cubit.dart';

enum SearchStatus { initial, loading, loaded, error }

class SearchMovieState {
  final SearchStatus status;
  final String title;
  final double appBarHeight;
  final bool showAppbar;
  final List<Movie> movies;
  SearchMovieState({
    required this.status,
    required this.title,
    required this.appBarHeight,
    required this.showAppbar,
    required this.movies,
  });

  factory SearchMovieState.initial() => SearchMovieState(
      status: SearchStatus.initial,
      title: '',
      appBarHeight: 84.0,
      showAppbar: true,
      movies: []
      );

  @override
  bool operator ==(covariant SearchMovieState other) {
    if (identical(this, other)) return true;
  
    return 
      other.status == status &&
      other.title == title &&
      other.appBarHeight == appBarHeight &&
      other.showAppbar == showAppbar &&
      listEquals(other.movies, movies);
  }

  @override
  int get hashCode {
    return status.hashCode ^
      title.hashCode ^
      appBarHeight.hashCode ^
      showAppbar.hashCode ^
      movies.hashCode;
  }

  SearchMovieState copyWith({
    SearchStatus? status,
    String? title,
    double? appBarHeight,
    bool? showAppbar,
    List<Movie>? movies,
  }) {
    return SearchMovieState(
      status: status ?? this.status,
      title: title ?? this.title,
      appBarHeight: appBarHeight ?? this.appBarHeight,
      showAppbar: showAppbar ?? this.showAppbar,
      movies: movies ?? this.movies,
    );
  }

  @override
  String toString() {
    return 'SearchMovieState(status: $status, title: $title, appBarHeight: $appBarHeight, showAppbar: $showAppbar, movies: $movies)';
  }
}
