import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie/constants/my_colors.dart';
import 'package:flutter_movie/logic/cubits/genre_movies/genre_movies_cubit_cubit.dart';
import 'package:flutter_movie/logic/cubits/most_popular_movies/most_popular_movies_cubit_cubit.dart';
import 'package:flutter_movie/logic/utils/utils.dart';
import 'package:flutter_movie/peresentation/screens/details_screen/details_screen.dart';
import 'package:flutter_movie/peresentation/shared_widgets/most_popular_card.dart';
import 'package:flutter_movie/peresentation/shared_widgets/page_not_found.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

  class MostPopularList extends StatelessWidget {
    const MostPopularList({super.key});
  
    @override
    Widget build(BuildContext context) {
          var size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height / 2.236,
      child: BlocBuilder<MostPopularMoviesCubit, MostPoularMoviesState>(
        builder: (context, state) {
          if (state.status == MostPupularMoviesStatus.initial) {
            return const SpinKitFadingFour(
              color: MyColors.primaryColor,
            );
          } else if (state.status == MostPupularMoviesStatus.loading) {
            return const SpinKitFadingFour(
              color: MyColors.primaryColor,
            );
          } else if (state.status == MostPupularMoviesStatus.loaded) {
            return CarouselSlider.builder(
              //carouselController: carouselController,
              itemCount: state.movies.length,
              itemBuilder: ((context, index, realIndex) {
                var genreIds = state.movies[index].genreIds;
                String joinedString = getGenreNames(
                        genreIds, context.read<GenreMoviesCubit>().state.genres)
                    .join(', ');
                String heroTag = '${UniqueKey()}${state.movies[index].id}';

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MostPopularCard(
                    heroTag: heroTag,
                    img: state.movies[index].posterUrl,
                    title: state.movies[index].title,
                    category: joinedString,
                    rate: state.movies[index].voteAverage! / 2,
                    selected: index == state.selectedItem ? true : false,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailsScreen(
                                    movie: state.movies[index],
                                    heroTag: heroTag,
                                  )));
                    },
                  ),
                );
              }),
              options: CarouselOptions(
                height: size.height / 2.236,
                //aspectRatio: 16 / 9,
                viewportFraction: 0.6,
                initialPage: state.selectedItem,
                enableInfiniteScroll: true,
                reverse: false,
                enlargeCenterPage: true,
                enlargeFactor: 0.3,
                onPageChanged: (int index, _) {
                  context.read<MostPopularMoviesCubit>().setItemIndex(index);
                },
                scrollDirection: Axis.horizontal,
              ),
            );
          } else if (state.status == MostPupularMoviesStatus.error) {
            return const PageNotFound();
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
    }
  }