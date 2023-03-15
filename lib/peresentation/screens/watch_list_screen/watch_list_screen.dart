import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie/constants/my_colors.dart';
import 'package:flutter_movie/constants/my_dimentions.dart';
import 'package:flutter_movie/logic/cubits/genre_movies/genre_movies_cubit_cubit.dart';
import 'package:flutter_movie/logic/cubits/save_movie/save_movie_cubit.dart';
import 'package:flutter_movie/logic/utils/utils.dart';
import 'package:flutter_movie/peresentation/screens/details_screen/details_screen.dart';
import 'package:flutter_movie/peresentation/shared_widgets/movie_card_small.dart';
import 'package:lottie/lottie.dart';

class WatchListScreen extends StatelessWidget {
  const WatchListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: MyColors.bgColor,
        body: BlocBuilder<SaveMovieCubit, SaveMovieState>(
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.all(MyDimens.medium),
              child: state.movies.isNotEmpty
                  ? ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: ((context, index) {
                        var currentItem = state.movies[index];
                        String joinedString = getGenreNames(
                                currentItem.genreIds,
                                context.read<GenreMoviesCubit>().state.genres)
                            .join(', ');
                        String heroTag =
                            '${UniqueKey()}${state.movies[index].id}';
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
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
                                          movie: currentItem,
                                          heroTag: heroTag)));
                            },
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
          },
        ));
  }
}
