import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie/constants/my_colors.dart';
import 'package:flutter_movie/constants/my_dimentions.dart';
import 'package:flutter_movie/logic/cubits/genre_movies/genre_movies_cubit_cubit.dart';
import 'package:flutter_movie/logic/cubits/most_popular_movies/most_popular_movies_cubit_cubit.dart';
import 'package:flutter_movie/logic/cubits/top_rated_movies/top_rated_movies_cubit.dart';
import 'package:flutter_movie/logic/cubits/up_comming_movies/up_comming_movies_cubit.dart';
import 'package:flutter_movie/peresentation/screens/home_screen/components/most_popular_list.dart';
import 'package:flutter_movie/peresentation/screens/home_screen/components/see_all_list.dart';
import 'package:flutter_movie/peresentation/screens/home_screen/components/top_rated_list.dart';
import 'package:flutter_movie/peresentation/screens/home_screen/components/up_comming_list.dart';
import 'package:flutter_movie/peresentation/shared_widgets/title_with_text_btn.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _fetchGenres();
    _fetchMostPopual();
    _fetchTopRated();
    _fetchUpComming();
  }

  void _fetchGenres() async {
    context.read<GenreMoviesCubit>().fetchGenres();
  }

  void _fetchMostPopual() async {
    context.read<MostPopularMoviesCubit>().fetchMostPopularMovies();
  }

  void _fetchTopRated() async {
    context.read<TopRatedMoviesCubit>().fetchTopRatedMovies();
  }

  void _fetchUpComming() async {
    context.read<UpCommingMoviesCubit>().fetchUpCommingMovies();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
          backgroundColor: MyColors.bgColor,
          body: SizedBox(
            width: size.width,
            height: size.height,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  TitleWithTextBtn(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SeeAll(
                                    movies: context
                                        .watch<MostPopularMoviesCubit>()
                                        .state
                                        .movies)));
                      },
                      title: "Most popular"),
                  const MostPopularList(),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  TitleWithTextBtn(onPressed: () {
                                            Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SeeAll(
                                    movies: context
                                        .watch<TopRatedMoviesCubit>()
                                        .state
                                        .movies)));
                  }, title: "Top Rated"),
                  SizedBox(
                    height: MyDimens.small,
                  ),
                  const TopRatedList(),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  TitleWithTextBtn(onPressed: () {
                                            Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SeeAll(
                                    movies: context
                                        .watch<UpCommingMoviesCubit>()
                                        .state
                                        .movies)));
                  }, title: "Up Comming"),
                  SizedBox(
                    height: MyDimens.small,
                  ),
                  const UpCommingList(),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
