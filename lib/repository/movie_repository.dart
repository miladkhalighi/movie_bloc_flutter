import 'package:flutter_movie/models/genre.dart';
import 'package:flutter_movie/models/movie.dart';
import 'package:flutter_movie/services/movie_api_services.dart';

class MovieRepository {
  final MovieApiServices movieApiServices;

  MovieRepository({required this.movieApiServices});

  Future<List<Movie>> fetchMostPoularMovies() async {
    try {
      List<Movie> movies = await movieApiServices.getMostPopularMovies();
      print(movies.toString());
      return movies;
    } catch (e) {
      e.toString();
      return List.empty();
    }
  }

  Future<List<Movie>> fetchTopRatedMovies() async {
    try {
      List<Movie> movies = await movieApiServices.getTopRatedMovies();
      return movies;
    } catch (e) {
      e.toString();
      return List.empty();
    }
  }

  Future<List<Movie>> fetchUpCommingMovies() async {
    try {
      List<Movie> movies = await movieApiServices.getUpComingMovies();
      return movies;
    } catch (e) {
      e.toString();
      return List.empty();
    }
  }

  Future<List<Genre>> fetchGenres() async {
    try {
      List<Genre> genres = await movieApiServices.getGenres();
      print(genres.toString());
      return genres;
    } catch (e) {
      e.toString();
      return List.empty();
    }
  }
}
