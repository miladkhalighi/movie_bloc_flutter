import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie/constants/my_colors.dart';
import 'package:flutter_movie/constants/my_text_styles.dart';
import 'package:flutter_movie/data/models/movie.dart';
import 'package:flutter_movie/logic/cubits/genre_movies/genre_movies_cubit_cubit.dart';
import 'package:flutter_movie/logic/utils/utils.dart';
import 'package:flutter_movie/peresentation/screens/details_screen/details_screen.dart';
import 'package:flutter_movie/peresentation/shared_widgets/movie_card_small.dart';

class SeeAll extends StatelessWidget {
  final List<Movie> movies;
  const SeeAll({required this.movies, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.bgColor,
      appBar: AppBar(
        title: Text(
          '${movies.length} items found',
          style: MyTextStyles.title.copyWith(color: Colors.white70),
        ),
        centerTitle: true,
        backgroundColor: MyColors.bgColor,
        elevation: 0,
        leading: IconButton(onPressed: ()=> Navigator.pop(context), icon: const Icon(EvaIcons.arrowIosBackOutline,color: Colors.white70,)),
      ),
      body: ListView.builder(
        itemBuilder: ((context, index) {
          var currentItem = movies[index];
          String joinedString = getGenreNames(currentItem.genreIds,
                  context.read<GenreMoviesCubit>().state.genres)
              .join(', ');
          String heroTag = '${UniqueKey()}${movies[index].id}';
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 16),
            child: MovieCardSmall(
              heroTag: heroTag,
              img: currentItem.posterUrl,
              title: currentItem.title,
              category: joinedString,
              onPressed: (() => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          DetailsScreen(movie: currentItem, heroTag: heroTag)))),
            ),
          );
        }),
        itemCount: movies.length,
        physics: const BouncingScrollPhysics(),
      ),
    );
  }
}
