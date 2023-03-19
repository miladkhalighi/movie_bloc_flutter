
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie/constants/my_colors.dart';
import 'package:flutter_movie/constants/my_text_styles.dart';
import 'package:flutter_movie/logic/cubits/genre_movies/genre_movies_cubit_cubit.dart';
import 'package:flutter_movie/logic/cubits/save_movie/save_movie_cubit.dart';
import 'package:flutter_movie/logic/utils/utils.dart';
import 'package:flutter_movie/peresentation/screens/details_screen/details_screen.dart';
import 'package:flutter_movie/peresentation/screens/watch_list_screen/background_dismissible.dart';
import 'package:flutter_movie/peresentation/shared_widgets/movie_card_small.dart';
import 'package:lottie/lottie.dart';

class WatchListScreen extends StatelessWidget {
  const WatchListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocBuilder<SaveMovieCubit, SaveMovieState>(
        builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            '${state.movies.length} items found',
            style: MyTextStyles.title.copyWith(color: Colors.white70),
          ),
          centerTitle: true,
          backgroundColor: MyColors.bgColor,
          elevation: 0,
        ),
        backgroundColor: MyColors.bgColor,
        body: state.movies.isNotEmpty
            ? ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemBuilder: ((context, index) {
                  var currentItem = state.movies[index];
                  String joinedString = getGenreNames(currentItem.genreIds,
                          context.read<GenreMoviesCubit>().state.genres)
                      .join(', ');
                  String heroTag = '${UniqueKey()}${state.movies[index].id}';
                  return Dismissible(
                    key: ValueKey(currentItem.id),
                    background:
                        const BackgroundDismissible(alignIconLeft: true),
                    secondaryBackground:
                        const BackgroundDismissible(alignIconLeft: false),
                    onDismissed: (_) {
                      context.read<SaveMovieCubit>().removeMovie(currentItem);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      child: MovieCardSmall(
                        heroTag: heroTag,
                        img: currentItem.posterUrl,
                        title: currentItem.title,
                        category: joinedString,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailsScreen(
                                      movie: currentItem, heroTag: heroTag)));
                        },
                        expandWidth: true,
                      ),
                    ),
                  );
                }),
                itemCount: state.movies.length,
              )
            : Center(
                child: SizedBox(
                    width: size.width,
                    height: size.height / 2,
                    child: Lottie.asset('assets/lottie/astronaut.json',
                        fit: BoxFit.contain)),
              ),
      );
    });
  }
}


