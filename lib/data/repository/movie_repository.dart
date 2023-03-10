import 'package:flutter_movie/data/models/cast.dart';
import 'package:flutter_movie/data/models/crew.dart';
import 'package:flutter_movie/data/models/genre.dart';
import 'package:flutter_movie/data/models/movie.dart';
import 'package:flutter_movie/data/services/movie_api_services.dart';

class MovieRepository {
  final MovieApiServices movieApiServices;

  MovieRepository({required this.movieApiServices});

  Future<List<Movie>> fetchMostPoularMovies() async {
    try {
      List<Movie> movies = await movieApiServices.getMostPopularMovies();
      print("\nMOST POPULAR MOVIES\n" + movies.toString());
      return movies;
    } catch (e) {
      e.toString();
      return List.empty();
    }
  }

  Future<List<Movie>> fetchTopRatedMovies() async {
    try {
      List<Movie> movies = await movieApiServices.getTopRatedMovies();
      print("\nTOP RATED MOVIES\n" + movies.toString());
      return movies;
    } catch (e) {
      e.toString();
      return List.empty();
    }
  }

  Future<List<Movie>> fetchUpCommingMovies() async {
    try {
      List<Movie> movies = await movieApiServices.getUpComingMovies();
      print("\nUP COMMING MOVIES\n" + movies.toString());
      return movies;
    } catch (e) {
      e.toString();
      return List.empty();
    }
  }

  Future<List<Genre>> fetchGenres() async {
    try {
      List<Genre> genres = await movieApiServices.getGenres();
      print("\nGENRES\n" + genres.toString());
      return genres;
    } catch (e) {
      e.toString();
      return List.empty();
    }
  }

  Future<List<Cast>> fetchCast(int movieId) async {
    try {
      var cast = await movieApiServices.getCast(movieId);
      print("\nCAST\n" + cast.toString());
      return cast;
    } catch (e) {
      print(e.toString());
      return List.empty();
    }
  }

  Future<List<Crew>> fetchCrew(int movieId) async {
    try {
      var crew = await movieApiServices.getCrew(movieId);
      print("\nCREW\n" + crew.toString());
      return crew;
    } catch (e) {
      print(e.toString());
      return List.empty();
    }
  }

  Future<List<String>> fetchMoviePhotos(int movieId) async {
    try {
      final photos = await movieApiServices.fetchMovieImages(movieId);
      print("\nPHOTOS\n" + photos.toString());
      return photos;
    } catch (e) {}
    return List.empty();
  }

    Future<List<String>> fetchMovieVideos(int movieId) async {
    try {
      final videos = await movieApiServices.fetchMovieVideos(movieId);
      print("\nVIDEOS\n" + videos.toString());
      return videos;
    } catch (e) {}
    return List.empty();
  }
}
