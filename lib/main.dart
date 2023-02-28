import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie/cubits/genre_movies/genre_movies_cubit_cubit.dart';
import 'package:flutter_movie/cubits/most_popular_movies/most_popular_movies_cubit_cubit.dart';
import 'package:flutter_movie/cubits/top_rated_movies/top_rated_movies_cubit.dart';
import 'package:flutter_movie/cubits/up_comming_movies/up_comming_movies_cubit.dart';
import 'package:flutter_movie/models/movie.dart';
import 'package:flutter_movie/repository/movie_repository.dart';
import 'package:flutter_movie/screens/details_screen/details_screen.dart';
import 'package:flutter_movie/screens/home_screen.dart';
import 'package:flutter_movie/services/movie_api_services.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<MovieRepository>(
      create: (context) =>
          MovieRepository(movieApiServices: MovieApiServices(dio: Dio())),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<GenreMoviesCubit>(
            create: ((context) => GenreMoviesCubit(
                  movieRepository: context.read<MovieRepository>(),
                )),
          ),
          BlocProvider<MostPopularMoviesCubit>(
            create: (context) => MostPopularMoviesCubit(
              movieRepository: context.read<MovieRepository>(),
              genreMoviesCubit: context.read<GenreMoviesCubit>(),
            ),
          ),
          BlocProvider(
            create: (context) => TopRatedMoviesCubit(
                repository: context.read<MovieRepository>(),
                genreMoviesCubit: context.read<GenreMoviesCubit>()),
          ),
          BlocProvider(
            create: (context) => UpCommingMoviesCubit(
              repository: context.read<MovieRepository>(),
              genreMoviesCubit: context.read<GenreMoviesCubit>(),
            ),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.yellow,
            fontFamily: GoogleFonts.aclonica().fontFamily,
          ),
          home: const HomeScreen(),
        ),
      ),
    );
  }
}
