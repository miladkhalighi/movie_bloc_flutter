import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie/constants/my_colors.dart';
import 'package:flutter_movie/constants/my_dimentions.dart';
import 'package:flutter_movie/constants/my_text_styles.dart';
import 'package:flutter_movie/data/models/movie.dart';
import 'package:flutter_movie/logic/cubits/cast_movies/cast_movies_cubit.dart';
import 'package:flutter_movie/logic/cubits/crew_movies/crew_movies_cubit.dart';
import 'package:flutter_movie/logic/cubits/genre_movies/genre_movies_cubit_cubit.dart';
import 'package:flutter_movie/logic/cubits/photos_movie/photos_movie_cubit.dart';
import 'package:flutter_movie/logic/cubits/save_movie/save_movie_cubit.dart';
import 'package:flutter_movie/logic/cubits/videos_movie/videos_movie_cubit.dart';
import 'package:flutter_movie/peresentation/screens/details_screen/components/cast_crew_list.dart';
import 'package:flutter_movie/peresentation/screens/details_screen/components/photo_list.dart';
import 'package:flutter_movie/peresentation/screens/details_screen/components/video_list.dart';
import 'package:flutter_movie/peresentation/shared_widgets/title_with_text_btn.dart';
import 'package:flutter_movie/logic/utils/utils.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';

class DetailsScreen extends StatefulWidget {
  final Movie movie;
  final String heroTag;
  const DetailsScreen({required this.movie, required this.heroTag, super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  void initState() {
    _fetchCast();
    _fetchCrew();
    _fetchPhotos();
    _fetchVideos();
    _fetchSavedMovie();
    super.initState();
  }

  void _fetchCast() async {
    context.read<CastMoviesCubit>().fetchCast(widget.movie.id);
  }

  void _fetchCrew() async {
    context.read<CrewMoviesCubit>().fetchCrew(widget.movie.id);
  }

  void _fetchPhotos() {
    context.read<PhotosMovieCubit>().fetchMoviePhotos(widget.movie.id);
  }

  void _fetchVideos() {
    context.read<VideosMovieCubit>().fetchYouTubeMovieIds(widget.movie.id);
  }

  void _fetchSavedMovie() {
    context.read<SaveMovieCubit>().fetchMove(widget.movie);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColors.bgColor,
        body: PageView(
          allowImplicitScrolling: true,
          scrollDirection: Axis.vertical,
          children: [
            _topPage(context, size),
            bottomPage(size),
          ],
        ),
      ),
    );
  }

  Widget _topPage(BuildContext context, Size size) {
    return Stack(children: [
      //bg img
      Hero(
        tag: widget.heroTag,
        child: CachedNetworkImage(
          width: size.width,
          height: size.height,
          imageUrl: widget.movie.posterUrl,
          fit: BoxFit.cover,
          placeholder: (context, url) => const SpinKitFadingFour(
            color: MyColors.primaryColor,
          ),
          errorWidget: (context, url, error) => ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Container(
                color: MyColors.bgColor,
              )),
        ),
      ),
      //make black filter bg
      FadeIn(
        duration: const Duration(milliseconds: 1000),
        delay: const Duration(milliseconds: 500),
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Colors.black.withOpacity(0.65),
              Colors.black.withOpacity(0.65),
              MyColors.bgColor
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
        ),
      ),
      //back btn
      Positioned(
          top: 0,
          left: 0,
          child: Container(
              margin: EdgeInsets.all(MyDimens.medium),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(50)),
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_rounded,
                    color: Colors.white,
                  )))),
      Positioned(top: 0, left: 0, right: 0, child: _bodyTopPage(size)),
      Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: FadeInUp(
              delay: const Duration(milliseconds: 2000),
              child: Lottie.asset('assets/lottie/swipe-up.json', height: 84)))
    ]);
  }

  Widget _bodyTopPage(Size size) {
    return SizedBox(
      height: size.height,
      child: Column(
        children: [
          SizedBox(
            height: size.height / 7,
          ),
          FadeInDown(
            delay: const Duration(milliseconds: 1000),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: MyDimens.small),
              child: Text(
                widget.movie.title,
                style: MyTextStyles.titleSecondary,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(
            height: MyDimens.small,
          ),
          FadeInDown(
            delay: const Duration(milliseconds: 1100),
            child: Text(
              '${millisToHourAndMin(widget.movie.runtime)} | R',
              style: MyTextStyles.subTitleSecondary,
            ),
          ),
          SizedBox(
            height: MyDimens.small,
          ),
          BlocBuilder<GenreMoviesCubit, GenreMoviesState>(
            builder: (BuildContext context, state) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: MyDimens.small),
                child: FadeInDown(
                  delay: const Duration(milliseconds: 1200),
                  child: Text(
                    getGenreNames(widget.movie.genreIds, state.genres)
                        .join(', '),
                    style: MyTextStyles.subTitleSecondary,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              );
            },
          ),
          SizedBox(
            height: MyDimens.small,
          ),
          FadeInDown(
            delay: const Duration(milliseconds: 1300),
            child: RatingBar(
                itemSize: 20,
                initialRating: widget.movie.voteAverage! / 2,
                minRating: 0,
                maxRating: 10,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                //unratedColor: MyColors.primaryColor,
                glowColor: MyColors.primaryColor,
                //unratedColor: MyColors.cardBgColor,
                ratingWidget: RatingWidget(
                  full: const Icon(
                    Icons.star,
                    color: MyColors.primaryColor,
                  ),
                  half: const Icon(
                    Icons.star_half_outlined,
                    color: MyColors.primaryColor,
                  ),
                  empty: const Icon(
                    Icons.star_border_outlined,
                    color: MyColors.primaryColor,
                  ),
                ),
                onRatingUpdate: (_) {}),
          ),
          SizedBox(
            height: MyDimens.small,
          ),
          FadeInDown(
            delay: const Duration(milliseconds: 1400),
            child: Text(
              widget.movie.releaseDate ?? "",
              style: MyTextStyles.subTitleSecondary,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          //btn
          FadeInDown(
            delay: const Duration(milliseconds: 1400),
            child: SizedBox(
              height: 48,
              child: BlocBuilder<SaveMovieCubit, SaveMovieState>(
                builder: (context, state) {
                  return ElevatedButton.icon(
                      onPressed: () {
                        context
                            .read<SaveMovieCubit>()
                            .toggleMovie(widget.movie);
                        log('\nFINAL LIST ${state.movies}');
                      },
                      icon: Icon(
                        state.status == SavedMovieStatus.saved
                            ? EvaIcons.bookmark
                            : EvaIcons.bookmarkOutline,
                        color: Colors.black54,
                      ),
                      label: Text(
                        state.status == SavedMovieStatus.saved
                            ? 'Remove from watch list'
                            : 'Add to watch list',
                        style: MyTextStyles.botton,
                      ));
                },
              ),
            ),
          ),
          const Spacer(),
          FadeInDown(
            delay: const Duration(milliseconds: 1500),
            child: Padding(
              padding: EdgeInsets.only(left: MyDimens.small),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Overview',
                  style: MyTextStyles.title,
                ),
              ),
            ),
          ),
          SizedBox(
            height: MyDimens.small,
          ),
          FadeInDown(
            delay: const Duration(milliseconds: 1600),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: MyDimens.medium),
              child: Align(
                alignment: Alignment.centerLeft,
                child: ExpandableText(
                  widget.movie.overview,
                  expandText: 'show more',
                  collapseText: 'show less',
                  maxLines: 3,
                  linkEllipsis: false,
                  linkColor: MyColors.primaryColor,
                  linkStyle: MyTextStyles.title.copyWith(fontSize: 15),
                  style: MyTextStyles.body
                      .copyWith(color: Colors.white.withOpacity(0.8)),
                ),
              ),
            ),
          ),
          const Spacer(),
          FadeInUp(
            delay: const Duration(milliseconds: 2000),
            child: TitleWithTextBtn(
              onPressed: () {},
              title: 'Cast & Crew',
            ),
          ),
          SizedBox(
              height: size.height / 10,
              child: FadeInUp(
                  delay: const Duration(milliseconds: 2100),
                  child: const CastAndCrewListWidget())),
          SizedBox(
            height: size.height / 6,
          )
        ],
      ),
    );
  }

  Widget bottomPage(Size size) {
    return Container(
      height: size.height,
      color: MyColors.bgColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TitleWithTextBtn(
            onPressed: () {},
            title: 'Photos',
          ),
          SizedBox(
            height: size.width / 2,
            child: const PhotoList(),
          ),
          const SizedBox(
            height: 32,
          ),
          TitleWithTextBtn(
            onPressed: () {},
            title: 'Videos',
          ),
          SizedBox(height: size.width / 2, child: const VideosListWidget()),
        ],
      ),
    );
  }
}
