import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie/data/repository/movie_repository.dart';
import 'package:flutter_movie/logic/cubits/cast_movies/cast_movies_cubit.dart';
import 'package:flutter_movie/logic/cubits/crew_movies/crew_movies_cubit.dart';
import 'package:flutter_movie/logic/cubits/genre_movies/genre_movies_cubit_cubit.dart';
import 'package:flutter_movie/logic/cubits/most_popular_movies/most_popular_movies_cubit_cubit.dart';
import 'package:flutter_movie/logic/cubits/photos_movie/photos_movie_cubit.dart';
import 'package:flutter_movie/logic/cubits/top_rated_movies/top_rated_movies_cubit.dart';
import 'package:flutter_movie/logic/cubits/up_comming_movies/up_comming_movies_cubit.dart';
import 'package:flutter_movie/logic/cubits/videos_movie/videos_movie_cubit.dart';
import 'package:flutter_movie/peresentation/screens/home_screen/home_screen.dart';
import 'package:flutter_movie/data/services/movie_api_services.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
          BlocProvider(
            create: (context) =>
                CastMoviesCubit(repository: context.read<MovieRepository>()),
          ),
          BlocProvider(
            create: (context) =>
                CrewMoviesCubit(repository: context.read<MovieRepository>()),
          ),
          BlocProvider(
            create: (context) =>
                PhotosMovieCubit(repository: context.read<MovieRepository>()),
          ),
          BlocProvider(
            create: ((context) =>
                VideosMovieCubit(repository: context.read<MovieRepository>())),
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
