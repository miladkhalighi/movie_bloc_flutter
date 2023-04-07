import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie/constants/my_colors.dart';
import 'package:flutter_movie/constants/my_text_styles.dart';
import 'package:flutter_movie/data/repository/movie_repository.dart';
import 'package:flutter_movie/logic/cubits/bottom_navigation/bottom_navigation_cubit.dart';
import 'package:flutter_movie/logic/cubits/cast_movies/cast_movies_cubit.dart';
import 'package:flutter_movie/logic/cubits/crew_movies/crew_movies_cubit.dart';
import 'package:flutter_movie/logic/cubits/genre_movies/genre_movies_cubit_cubit.dart';
import 'package:flutter_movie/logic/cubits/most_popular_movies/most_popular_movies_cubit_cubit.dart';
import 'package:flutter_movie/logic/cubits/photos_movie/photos_movie_cubit.dart';
import 'package:flutter_movie/logic/cubits/save_movie/save_movie_cubit.dart';
import 'package:flutter_movie/logic/cubits/search_movie/search_movie_cubit.dart';
import 'package:flutter_movie/logic/cubits/top_rated_movies/top_rated_movies_cubit.dart';
import 'package:flutter_movie/logic/cubits/up_comming_movies/up_comming_movies_cubit.dart';
import 'package:flutter_movie/logic/cubits/videos_movie/videos_movie_cubit.dart';
import 'package:flutter_movie/data/services/movie_api_services.dart';
import 'package:flutter_movie/root_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());

  HydratedBloc.storage = storage;
  runApp(const MyApp());
}
//! /////////////////////////////////
//! FOLLOW ME ON
//! github.com/miladkhalighi
//! ////////////////////////////////

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
          BlocProvider(
            create: (context) => BottomNavigationCubit(),
          ),
          BlocProvider(
            create: ((context) =>
                SearchMovieCubit(repository: context.read<MovieRepository>())),
          ),
          BlocProvider(create: (context) {
            return SaveMovieCubit();
          })
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    backgroundColor: MyColors.primaryColor)),
            inputDecorationTheme: InputDecorationTheme(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              hintStyle: MyTextStyles.title,
              labelStyle: MyTextStyles.title
                  .copyWith(color: Colors.white.withOpacity(0.85)),
            ),
            backgroundColor: MyColors.bgColor,
            primarySwatch: Colors.yellow,
            fontFamily: GoogleFonts.aclonica().fontFamily,
          ),
          home: const RootScreen(),
        ),
      ),
    );
  }
}
