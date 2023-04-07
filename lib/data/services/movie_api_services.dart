import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_movie/constants/movie_api_constants.dart';
import 'package:flutter_movie/data/models/cast.dart';
import 'package:flutter_movie/data/models/crew.dart';
import 'package:flutter_movie/data/models/genre.dart';
import 'package:flutter_movie/data/models/movie.dart';

class MovieApiServices {
  final Dio dio;
  MovieApiServices({
    required this.dio,
  });

  Future<List<Movie>> getMoviesByTitle(String title) async {
    String url = MovieApiConstants.searchMovies;
    try {
      Response response = await dio.get(url,
          queryParameters: {
            'api_key': MovieApiConstants.apiKey,
            'query': title,
            //'external_source': 'imdb_id'
          },
          options: Options(method: "GET", responseType: ResponseType.json));
      if (response.statusCode == 200) {
        var jsonMovies = response.data['results'];
        List<Movie> movies =
            List.from(jsonMovies.map((e) => Movie.fromJson(e)));
        return movies;
      } else {
        throw Exception(
            'Request failed\nStatus code:${response.statusCode}\nReason:${response.statusMessage}');
      }
    } catch (e) {
      log("catch err $e");
    }
    return [];
  }

  Future<List<Movie>> getTrendingMovies() async {
    try {
      var response = await dio.get(
        'https://api.themoviedb.org/3/trending/all/week?api_key=${MovieApiConstants.apiKey}',
      );

      if (response.statusCode == 200) {
        log(response.data.toString());
        final json = response.data;
        final movies = List<Movie>.from(
            json['results'].map((movieJson) => Movie.fromJson(movieJson)));
        return movies;
      } else {
        throw Exception(
            'Request failed\nStatus code:${response.statusCode}\nReason:${response.statusMessage}');
      }
    } catch (e) {
      log("catch err $e");
    }
    return List<Movie>.empty();
  }

  // Future<List<Movie>> getMovieById(int movieId) async {
  //   //https://api.themoviedb.org/3/movie/$movieId?api_key=$apiKey
  //   try {
  //     var response = await dio.get(
  //         MovieApiConstants.baseUrl + MovieApiConstants.getMoviePath,
  //         queryParameters: {
  //           'api_key': MovieApiConstants.apiKey,
  //           'language': 'en',
  //           'external_source': movieId,
  //         });
  //     if (response.statusCode == 200) {
  //       var response = response.data;
  //       var movies = List.from();
  //       return MovieItemModel.fromJson(response.data);
  //     } else {
  //       String errMsg =
  //           'Request failed\nStatus code:${response.statusCode}\nReason:${response.statusMessage}';
  //       print(errMsg);
  //     }
  //   } catch (e) {
  //     e.toString();
  //   }
  // }

  Future<List<Movie>> getMostPopularMovies() async {
    final dio = Dio();
    //'https://api.themoviedb.org/3/movie/popular'
    String url = MovieApiConstants.baseUrl + MovieApiConstants.mostPopularPath;
    try {
      final response = await dio.get(
        url,
        queryParameters: {
          'api_key': MovieApiConstants.apiKey,
        },
      );
      if (response.statusCode == 200) {
        final json = response.data;
        final movies = List<Movie>.from(
          json['results'].map((movieJson) => Movie.fromJson(movieJson)),
        );
        return movies;
      } else {
        throw Exception('Failed to load movies');
      }
    } catch (e) {
      log(e.toString());
    }
    return List.empty();
  }

  Future<List<Movie>> getTopRatedMovies() async {
    final dio = Dio();
    //https://api.themoviedb.org/3/movie/top_rated?api_key=API_KEY
    String url = MovieApiConstants.baseUrl + MovieApiConstants.topRatedPath;
    try {
      final response = await dio.get(
        url,
        queryParameters: {
          'api_key': MovieApiConstants.apiKey,
        },
      );
      if (response.statusCode == 200) {
        final json = response.data;
        final movies = List<Movie>.from(
          json['results'].map((movieJson) => Movie.fromJson(movieJson)),
        );
        return movies;
      } else {
        throw Exception('Failed to load movies');
      }
    } catch (e) {
      log(e.toString());
    }
    return List.empty();
  }

  Future<List<Movie>> getUpComingMovies() async {
    final dio = Dio();
    //https://api.themoviedb.org/3/movie/upcoming?api_key=API_KEY
    String url = MovieApiConstants.baseUrl + MovieApiConstants.nowUpComingPath;
    try {
      final response = await dio.get(
        url,
        queryParameters: {
          'api_key': MovieApiConstants.apiKey,
        },
      );
      if (response.statusCode == 200) {
        final json = response.data;
        final movies = List<Movie>.from(
          json['results'].map((movieJson) => Movie.fromJson(movieJson)),
        );
        return movies;
      } else {
        throw Exception('Failed to load movies');
      }
    } catch (e) {
      log(e.toString());
    }
    return List.empty();
  }

  Future<List<Genre>> getGenres() async {
    try {
      var response = await dio.get(
          'https://api.themoviedb.org/3/genre/movie/list?api_key=${MovieApiConstants.apiKey}&language=en-US');
      if (response.statusCode == 200) {
        var genres = response.data['genres'];

        var genreList = List<Genre>.from(
            genres.map((genreJson) => Genre.fromJson(genreJson)));

        return genreList;
      } else {
        throw Exception('get request to fetch genres failed');
      }
    } catch (e) {
      log(e.toString());
    }
    return List.empty();
  }

  Future<List<Cast>> getCast(int id) async {
    //https://api.themoviedb.org/3/movie/{movie_id}/credits?api_key={api_key}
    String url = '${MovieApiConstants.baseUrl}/3/movie/$id/credits';
    try {
      var response = await dio
          .get(url, queryParameters: {'api_key': MovieApiConstants.apiKey});
      if (response.statusCode == 200) {
        final castJson = response.data['cast'];

        var cast = List<Cast>.from(castJson.map((json) => Cast.fromJson(json)));

        //final List<Map<String, dynamic>> castAndCrew = [...castJson, ...crewJson];

        return cast;
      } else {
        throw Exception('get request to fetch cast failed');
      }
    } catch (e) {
      log(e.toString());
    }
    return List.empty();
  }

  Future<List<Crew>> getCrew(int id) async {
    //https://api.themoviedb.org/3/movie/{movie_id}/credits?api_key={api_key}
    String url = '${MovieApiConstants.baseUrl}/3/movie/$id/credits';
    try {
      var response = await dio
          .get(url, queryParameters: {'api_key': MovieApiConstants.apiKey});
      if (response.statusCode == 200) {
        final crewJson = response.data['crew'];
        var crew = List<Crew>.from(crewJson.map((json) => Crew.fromJson(json)));

        //final List<Map<String, dynamic>> castAndCrew = [...castJson, ...crewJson];

        return crew;
      } else {
        throw Exception('get request to fetch crew failed');
      }
    } catch (e) {
      log(e.toString());
    }
    return List.empty();
  }

  Future<List<String>> fetchMovieImages(int movieId) async {
    //'https://api.themoviedb.org/3/movie/$movieId/images?api_key=$API_KEY'
    String path = '${MovieApiConstants.moviePhotos}$movieId/images';
    try {
      final response = await dio
          .get(path, queryParameters: {'api_key': MovieApiConstants.apiKey});

      if (response.statusCode == 200) {
        var jsonBackDrops = response.data['backdrops'];
        List<String> photos =
            List<String>.from(jsonBackDrops.map((json) => json['file_path']));
        List<String> photosUrl =
            photos.map((e) => '${MovieApiConstants.imagePrefixOrg}$e').toList();
        //print(photosUrl);
        return photosUrl;
      } else {
        throw Exception('Failed to fetch movie images');
      }
      // ignore: empty_catches
    } catch (e) {}
    return List.empty();
  }

  Future<List<String>> fetchMovieVideos(int movieId) async {
    String path = '${MovieApiConstants.movieVideos}$movieId/videos';
    try {
      final response = await dio
          .get(path, queryParameters: {'api_key': MovieApiConstants.apiKey});

      if (response.statusCode == 200) {
        final List<dynamic> videos = response.data['results'];
        log('\nVIDEOS\n$videos');
        List<String> videoIds = List<String>.from(videos.map((e) => e['key']));
        log('\nIDS\n$videoIds');
        return videoIds;
      } else {
        throw Exception('Failed to fetch movie videos');
      }
    } catch (e) {
      log(e.toString());
    }
    return List.empty();
  }
}
