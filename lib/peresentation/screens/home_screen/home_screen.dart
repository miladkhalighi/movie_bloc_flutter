import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie/constants/my_colors.dart';
import 'package:flutter_movie/constants/my_dimentions.dart';
import 'package:flutter_movie/logic/cubits/genre_movies/genre_movies_cubit_cubit.dart';
import 'package:flutter_movie/logic/cubits/most_popular_movies/most_popular_movies_cubit_cubit.dart';
import 'package:flutter_movie/logic/cubits/top_rated_movies/top_rated_movies_cubit.dart';
import 'package:flutter_movie/logic/cubits/up_comming_movies/up_comming_movies_cubit.dart';
import 'package:flutter_movie/peresentation/screens/details_screen/details_screen.dart';
import 'package:flutter_movie/peresentation/screens/home_screen/components/most_popular_list.dart';
import 'package:flutter_movie/peresentation/shared_widgets/movie_card_small.dart';
import 'package:flutter_movie/peresentation/shared_widgets/most_popular_card.dart';
import 'package:flutter_movie/peresentation/shared_widgets/title_with_text_btn.dart';
import 'package:flutter_movie/logic/utils/utils.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
                  const SizedBox(
                    height: 24,
                  ),
                  TitleWithTextBtn(onPressed: () {}, title: "Most popular"),
                  const MostPopularList(),
                  const SizedBox(
                    height: 48,
                  ),
                  TitleWithTextBtn(onPressed: () {}, title: "Top Rated"),
                  SizedBox(
                    height: MyDimens.small,
                  ),
                  TopRatedSelection(context),
                  const SizedBox(
                    height: 24,
                  ),
                  TitleWithTextBtn(onPressed: () {}, title: "Up Comming"),
                  SizedBox(
                    height: MyDimens.small,
                  ),
                  UpCommingSelection(context),
                  const SizedBox(
                    height: 24,
                  ),
                ],
              ),
            ),
          )),
    );
  }

  Widget TopRatedSelection(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      height: (size.height / 7.25) + 16,
      child: BlocBuilder<TopRatedMoviesCubit, TopRatedMoviesState>(
        builder: (context, state) {
          switch (state.status) {
            case TopRatedStatus.initial:
              return const SpinKitFadingFour(
                color: MyColors.primaryColor,
              );
              break;
            case TopRatedStatus.loading:
              return const SpinKitFadingFour(
                color: MyColors.primaryColor,
              );
              break;
            case TopRatedStatus.loaded:
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemBuilder: ((context, index) {
                  var item = state.movies[index];
                  String joinedString = getGenreNames(item.genreIds,
                          context.read<GenreMoviesCubit>().state.genres)
                      .join(', ');
                  String heroTag = '${UniqueKey()}${state.movies[index].id}';

                  return Padding(
                    padding: EdgeInsets.fromLTRB(index == 0 ? 16 : 10, 8,
                        index == state.movies.length - 1 ? 16 : 10, 8),
                    child: MovieCardSmall(
                      img: item.posterUrl,
                      title: item.title,
                      category: joinedString,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => DetailsScreen(
                                      movie: item,
                                      heroTag: heroTag,
                                    ))));
                      },
                      heroTag: heroTag,
                    ),
                  );
                }),
                itemCount: state.movies.length,
              );
              break;
            case TopRatedStatus.error:
              return Text('ERROR');
              break;
          }
        },
      ),
    );
  }

  Widget UpCommingSelection(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      height: (size.height / 7.25) + 16,
      child: BlocBuilder<UpCommingMoviesCubit, UpCommingMoviesState>(
        builder: (context, state) {
          switch (state.status) {
            case UpCommingStatus.initial:
              return const SpinKitFadingFour(
                color: MyColors.primaryColor,
              );
              break;
            case UpCommingStatus.loading:
              return const SpinKitFadingFour(
                color: MyColors.primaryColor,
              );
              break;
            case UpCommingStatus.loaded:
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemBuilder: ((context, index) {
                  var item = state.movies[index];
                  String joinedString = getGenreNames(item.genreIds,
                          context.read<GenreMoviesCubit>().state.genres)
                      .join(', ');
                  String heroTag = '${UniqueKey()}${state.movies[index].id}';

                  return Padding(
                    padding: EdgeInsets.fromLTRB(index == 0 ? 16 : 10, 8,
                        index == state.movies.length - 1 ? 16 : 10, 8),
                    child: MovieCardSmall(
                      img: item.posterUrl,
                      title: item.title,
                      category: joinedString,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => DetailsScreen(
                                      movie: item,
                                      heroTag: heroTag,
                                    ))));
                      },
                      heroTag: heroTag,
                    ),
                  );
                }),
                itemCount: state.movies.length,
              );
              break;
            case UpCommingStatus.error:
              return Text('ERROR');
              break;
          }
        },
      ),
    );
  }
}


