import 'package:dio/dio.dart';
import 'package:flutter_movie/constants/movie_api_constants.dart';
import 'package:flutter_movie/models/cast.dart';
import 'package:flutter_movie/models/crew.dart';
import 'package:flutter_movie/models/genre.dart';
import 'package:flutter_movie/models/movie.dart';

class MovieApiServices {
  final Dio dio;
  MovieApiServices({
    required this.dio,
  });

  // Future<List<MovieItemModel>> getMoviesByTitle(String title) async {
  //   try {
  //     Response response = await dio.get("https://api.themoviedb.org/3/find/",
  //         queryParameters: {
  //           'api_key': MovieApiConstants.apiKey,
  //           'query': title,
  //           'external_source': 'imdb_id'
  //         },
  //         options: Options(method: "GET", responseType: ResponseType.json));
  //     if (response.statusCode == 200) {
  //       print(response.data.toString());
  //       List<MovieItemModel> movies = [];

  //       response.data['results']
  //           .forEach((e) => movies.add(MovieItemModel.fromJson(e)));

  //       // for (var i = 0; i < 19; i++) {
  //       //   if (jsonBody['results'][i] != null) {
  //       //     final MovieItemModel movie =
  //       //         MovieItemModel.fromJson(jsonBody['results'][i]);
  //       //     //print(movie);
  //       //     movies.add(movie);
  //       //   }
  //       // }
  //       return movies;
  //     } else {
  //       throw Exception(
  //           'Request failed\nStatus code:${response.statusCode}\nReason:${response.statusMessage}');
  //     }
  //   } catch (e) {
  //     print("catch err " + e.toString());
  //   }
  //   return [];
  // }

  Future<List<Movie>> getTrendingMovies() async {
    try {
      var response = await dio.get(
        'https://api.themoviedb.org/3/trending/all/week?api_key=${MovieApiConstants.apiKey}',
      );

      if (response.statusCode == 200) {
        print(response.data.toString());
        final json = response.data;
        final movies = List<Movie>.from(
            json['results'].map((movieJson) => Movie.fromJson(movieJson)));
        return movies;
      } else {
        throw Exception(
            'Request failed\nStatus code:${response.statusCode}\nReason:${response.statusMessage}');
      }
    } catch (e) {
      print("catch err " + e.toString());
    }
    return List<Movie>.empty();
  }

  // Future<MovieItemModel?> getMovieById(String id) async {
  //   try {
  //     // final uri = Uri(
  //     //     scheme: 'https',
  //     //     host: baseUrl,
  //     //     path: getMoviePath,
  //     //     queryParameters: {
  //     //       'api_key': apiKey,
  //     //       'language': 'en',
  //     //       'external_source': id,
  //     //     });
  //     var response = await dio.get(
  //         MovieApiConstants.baseUrl + MovieApiConstants.getMoviePath,
  //         queryParameters: {
  //           'api_key': MovieApiConstants.apiKey,
  //           'language': 'en',
  //           'external_source': id,
  //         });
  //     if (response.statusCode == 200) {
  //       print(response.data.toString());
  //       return MovieItemModel.fromJson(response.data);
  //     } else {
  //       String errMsg =
  //           'Request failed\nStatus code:${response.statusCode}\nReason:${response.statusMessage}';
  //       print(errMsg);
  //     }
  //   } catch (e) {
  //     e.toString();
  //     return null;
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
      print(e.toString());
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
      print(e.toString());
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
      print(e.toString());
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
      print(e.toString());
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
      print(e.toString());
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
      print(e.toString());
    }
    return List.empty();
  }
}
