import 'dart:developer';
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
      log("\nMOST POPULAR MOVIES\n$movies");
      return movies;
    } catch (e) {
      e.toString();
      return List.empty();
    }
  }

  Future<List<Movie>> fetchTopRatedMovies() async {
    try {
      List<Movie> movies = await movieApiServices.getTopRatedMovies();
      log("\nTOP RATED MOVIES\n$movies");
      return movies;
    } catch (e) {
      e.toString();
      return List.empty();
    }
  }

  Future<List<Movie>> fetchUpCommingMovies() async {
    try {
      List<Movie> movies = await movieApiServices.getUpComingMovies();
      log("\nUP COMMING MOVIES\n$movies");
      return movies;
    } catch (e) {
      e.toString();
      return List.empty();
    }
  }

  Future<List<Genre>> fetchGenres() async {
    try {
      List<Genre> genres = await movieApiServices.getGenres();
      log("\nGENRES\n$genres");
      return genres;
    } catch (e) {
      e.toString();
      return List.empty();
    }
  }

  Future<List<Cast>> fetchCast(int movieId) async {
    try {
      var cast = await movieApiServices.getCast(movieId);
      log("\nCAST\n$cast");
      return cast;
    } catch (e) {
      log(e.toString());
      return List.empty();
    }
  }

  Future<List<Crew>> fetchCrew(int movieId) async {
    try {
      var crew = await movieApiServices.getCrew(movieId);
      log("\nCREW\n$crew");
      return crew;
    } catch (e) {
      log(e.toString());
      return List.empty();
    }
  }

  Future<List<String>> fetchMoviePhotos(int movieId) async {
    try {
      final photos = await movieApiServices.fetchMovieImages(movieId);
      log("\nPHOTOS\n$photos");
      return photos;
    } catch (e) {}
    return List.empty();
  }

  Future<List<String>> fetchMovieVideos(int movieId) async {
    try {
      final videos = await movieApiServices.fetchMovieVideos(movieId);
      log("\nVIDEOS\n$videos");
      return videos;
    } catch (e) {}
    return List.empty();
  }

  Future<List<Movie>> fetchMoviesByTitle(String title) async {
    try {
      final movies = await movieApiServices.getMoviesByTitle(title);
      log("\nMOVIES SEARCH BY TITLE\n$movies");
      return movies;
    } catch (e) {}
    return List.empty();
  }
}
