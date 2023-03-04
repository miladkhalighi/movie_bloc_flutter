import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
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
import 'package:flutter_movie/peresentation/screens/details_screen/components/cast_crew_card.dart';
import 'package:flutter_movie/peresentation/screens/details_screen/components/photo_card.dart';
import 'package:flutter_movie/peresentation/screens/video_screen/video_screen.dart';
import 'package:flutter_movie/data/services/movie_api_services.dart';
import 'package:flutter_movie/peresentation/shared_widgets/title_with_text_btn.dart';
import 'package:flutter_movie/logic/utils/utils.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
    //_fetchCast();
    //_fetchCrew();
    //_fetchPhotos();
    _fetchVideos();
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
    MovieApiServices api = MovieApiServices(dio: Dio());
    api.fetchMovieVideos(widget.movie.id);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: PageView(
          scrollDirection: Axis.vertical,
          //physics: const BouncingScrollPhysics(),
          children: [
            Page2(size),
            Page1(context, size),
          ],
        ),
      ),
    );
  }

  Widget Page1(BuildContext context, Size size) {
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
              child: const Image(
                image: AssetImage('assets/images/img1.png'),
                fit: BoxFit.cover,
              )),
        ),
      ),
      //make black filter bg
      FadeIn(
        duration: const Duration(milliseconds: 1000),
        delay: const Duration(milliseconds: 1000),
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
      Positioned(
          top: size.height / 8,
          left: 0,
          right: 0,
          child: FadeInDownBig(delay: Duration(seconds: 1), child: Body(size))),
    ]);
  }

  Widget Body(Size size) {
    return SizedBox(
      height: size.height,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: MyDimens.small),
            child: Text(
              widget.movie.title,
              style: MyTextStyles.titleSecondary,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: MyDimens.small,
          ),
          Text(
            '${millisToHourAndMin(widget.movie.runtime)} | R',
            style: MyTextStyles.subTitleSecondary,
          ),
          SizedBox(
            height: MyDimens.small,
          ),
          BlocBuilder<GenreMoviesCubit, GenreMoviesState>(
            builder: (BuildContext context, state) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: MyDimens.small),
                child: Text(
                  getGenreNames(widget.movie.genreIds, state.genres).join(', '),
                  style: MyTextStyles.subTitleSecondary,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              );
            },
          ),
          SizedBox(
            height: MyDimens.small,
          ),
          RatingBar(
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
          SizedBox(
            height: MyDimens.small,
          ),
          Text(
            widget.movie.releaseDate ?? "",
            style: MyTextStyles.subTitleSecondary,
          ),
          const SizedBox(
            height: 64,
          ),
          Padding(
            padding: EdgeInsets.only(left: MyDimens.small),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Overview',
                style: MyTextStyles.title,
              ),
            ),
          ),
          SizedBox(
            height: MyDimens.small,
          ),
          Padding(
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
          SizedBox(
            height: size.height / 5,
          ),
          TitleWithTextBtn(
            onPressed: () {},
            title: 'Cast & Crew',
          ),
          SizedBox(height: 70, child: CastAndCrewListWidget()),
          const SizedBox(
            height: 32,
          )
        ],
      ),
    );
  }

  Container Page2(Size size) {
    return Container(
      height: size.height,
      color: MyColors.bgColor,
      child: Column(
        children: [
          const SizedBox(
            height: 32,
          ),
          TitleWithTextBtn(
            onPressed: () {},
            title: 'Photos',
          ),
          FadeInDown(
            duration: const Duration(milliseconds: 1000),
            child: SizedBox(
              height: size.width / 3,
              child: const PhotoList(),
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          TitleWithTextBtn(
            onPressed: () {},
            title: 'Videos',
          ),
          FadeInDown(
            from: 300,
            duration: const Duration(milliseconds: 1000),
            delay: const Duration(microseconds: 2000),
            child: SizedBox(
              height: size.width / 3,
              child: ListView.builder(
                itemBuilder: ((context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 200,
                      height: 100,
                      child: VideoScreen(videoId: 'iLnmTe5Q2Qw'),
                    ),
                  );
                }),
                itemCount: 20,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
              ),
            ),
          ),
          
        ],
      ),
    );
  }
}

class PhotoList extends StatelessWidget {
  const PhotoList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhotosMovieCubit, PhotosMoviesStates>(
      builder: (context, state) {
        Widget widget = const SizedBox.shrink();
        if (state.status == PhotosStatus.initial) {
          widget = const SpinKitFadingFour(color: MyColors.primaryColor);
        } else if (state.status == PhotosStatus.loading) {
          widget = const SpinKitFadingFour(color: MyColors.primaryColor);
        } else if (state.status == PhotosStatus.error) {
          //TODO replace this text with another widget
          widget = const Text('ERROR');
        } else if (state.status == PhotosStatus.loaded) {
          widget = ListView.builder(
            itemBuilder: ((context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: PhotoCard(
                  imgUrl: state.photos[index],
                ),
              );
            }),
            itemCount: state.photos.length,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
          );
        }
        return widget;
      },
    );
  }
}

class CastAndCrewListWidget extends StatelessWidget {
  const CastAndCrewListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CastMoviesCubit, CastMoviesState>(
      builder: (context, castState) {
        return BlocBuilder<CrewMoviesCubit, CrewMoviesState>(
          builder: (context, crewState) {
            Widget widget = const SizedBox.shrink();
            if (castState.status == CastStatus.initial ||
                crewState.status == CrewStatus.initial) {
              //initial
              widget = const SpinKitFadingFour(
                color: MyColors.primaryColor,
              );
            } else if (castState.status == CastStatus.loading ||
                crewState.status == CrewStatus.loading) {
              //loading
              widget = const SpinKitFadingFour(
                color: MyColors.primaryColor,
              );
            } else if (castState.status == CastStatus.error &&
                crewState.status == CrewStatus.error) {
              //error
              widget = const Text('ERROR');
            } else if (castState.status == CastStatus.loaded ||
                crewState.status == CrewStatus.loaded) {
              //loaded
              widget = ListView.builder(
                itemBuilder: ((context, index) {
                  if (index < castState.cast.length) {
                    final member = castState.cast[index];
                    return Padding(
                      padding: EdgeInsets.fromLTRB(
                          index == 0 ? 16 : 4,
                          0,
                          index ==
                                  castState.cast.length +
                                      crewState.crew.length -
                                      1
                              ? 16
                              : 4,
                          0),
                      child: CastCrewCard(
                          title: member.name ?? "unkown",
                          subTitle: member.character ?? "unkown",
                          imgUrl: member.imageUrl),
                    );
                  } else {
                    final member =
                        crewState.crew[index - castState.cast.length];
                    return Padding(
                      padding: EdgeInsets.fromLTRB(
                          index == 0 ? 16 : 4,
                          0,
                          index ==
                                  castState.cast.length +
                                      crewState.crew.length -
                                      1
                              ? 16
                              : 4,
                          0),
                      child: CastCrewCard(
                          title: member.name ?? 'unkown',
                          subTitle: member.job ?? 'unkown',
                          imgUrl: member.imageUrl),
                    );
                  }
                }),
                itemCount: castState.cast.length + crewState.crew.length,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
              );
            }
            return widget;
          },
        );
      },
    );
  }
}
