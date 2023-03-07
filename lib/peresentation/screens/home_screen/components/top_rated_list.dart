import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie/constants/my_colors.dart';
import 'package:flutter_movie/logic/cubits/genre_movies/genre_movies_cubit_cubit.dart';
import 'package:flutter_movie/logic/cubits/top_rated_movies/top_rated_movies_cubit.dart';
import 'package:flutter_movie/logic/utils/utils.dart';
import 'package:flutter_movie/peresentation/screens/details_screen/details_screen.dart';
import 'package:flutter_movie/peresentation/shared_widgets/movie_card_small.dart';
import 'package:flutter_movie/peresentation/shared_widgets/page_not_found.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class TopRatedList extends StatelessWidget {
  const TopRatedList({super.key});

  @override
  Widget build(BuildContext context) {
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
            case TopRatedStatus.loading:
              return const SpinKitFadingFour(
                color: MyColors.primaryColor,
              );
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
            case TopRatedStatus.error:
              return const PageNotFound();
          }
        },
      ),
    );
  }
}