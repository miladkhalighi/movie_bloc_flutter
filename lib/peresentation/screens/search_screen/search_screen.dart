import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie/constants/my_colors.dart';
import 'package:flutter_movie/constants/my_dimentions.dart';
import 'package:flutter_movie/constants/my_text_styles.dart';
import 'package:flutter_movie/logic/cubits/genre_movies/genre_movies_cubit_cubit.dart';
import 'package:flutter_movie/logic/cubits/search_movie/search_movie_cubit.dart';
import 'package:flutter_movie/logic/utils/utils.dart';
import 'package:flutter_movie/peresentation/screens/details_screen/details_screen.dart';
import 'package:flutter_movie/peresentation/shared_widgets/movie_card_large.dart';
import 'package:flutter_movie/peresentation/shared_widgets/page_not_found.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController _textCtr;
  late ScrollController _scrollController;
  double _appBarHeight = 84.0;
  late FocusNode _focusNode;

  @override
  void initState() {
    _textCtr = TextEditingController();
    _scrollController = ScrollController()..addListener(scrollListener);
    _focusNode = FocusNode()..unfocus();
    _fetchMovies(_textCtr.text);
    super.initState();
  }

  void _fetchMovies(String title) {
    context.read<SearchMovieCubit>().searchItemByTitle(title);
  }

  void scrollListener() {
    var scrollOffset = _scrollController.offset;
    var state = context.read<SearchMovieCubit>().state;
    if (scrollOffset > state.appBarHeight && state.showAppbar) {
      context.read<SearchMovieCubit>().showAppbar(false);
    } else if (scrollOffset <= state.appBarHeight && !state.showAppbar) {
      context.read<SearchMovieCubit>().showAppbar(true);
    }

    if (state.showAppbar) {
      _appBarHeight += 4;
      context.read<SearchMovieCubit>().updateAppbarHeight(_appBarHeight);
    } else {
      _appBarHeight -= 4;
      context.read<SearchMovieCubit>().updateAppbarHeight(_appBarHeight);
    }
    _appBarHeight = _appBarHeight.clamp(0.0,
        84.0); // ensure that the app bar height remains within a range of 0 to 84 pixels.
    context.read<SearchMovieCubit>().updateAppbarHeight(_appBarHeight);
  }

  @override
  void dispose() {
    _textCtr.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var state = context.watch<SearchMovieCubit>().state;
    return InkWell(
      onTap: (() => _focusNode.unfocus()),
      child: Scaffold(
        backgroundColor: MyColors.bgColor,
        appBar: _buildAppBar(state),
        body: SizedBox.expand(
          child: ListViewSelection(state),
        ),
      ),
    );
  }

  Widget ListViewSelection(SearchMovieState state) {
    var size = MediaQuery.of(context).size;
    Widget widget = const SizedBox.shrink();
    if (state.status == SearchStatus.initial) {
      widget = SizedBox(
          width: size.width,
          height: size.height / 2,
          child: Lottie.asset('assets/lottie/astronaut.json',
              fit: BoxFit.contain));
    } else if (state.status == SearchStatus.loading) {
      widget = const SpinKitFadingFour(
        color: MyColors.primaryColor,
      );
    } else if (state.status == SearchStatus.error ||
        state.movies.isEmpty && state.status != SearchStatus.initial) {
      widget = const PageNotFound();
    } else if (state.status == SearchStatus.loaded) {
      widget = GridView.builder(
        padding: EdgeInsets.all(MyDimens.small),
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.6 / 1,
            mainAxisSpacing: 24,
            crossAxisSpacing: 8),
        itemBuilder: (context, index) {
          var currentItem = state.movies[index];
          var genreIds = currentItem.genreIds;
          String joinedString = getGenreNames(
                  genreIds, context.read<GenreMoviesCubit>().state.genres)
              .join(', ');
          String heroTag = '${UniqueKey()}${currentItem.id}';
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: MovieCardLarge(
              heroTag: heroTag,
              img: currentItem.posterUrl,
              title: currentItem.title,
              category: joinedString,
              rate: currentItem.voteAverage! / 2,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => DetailsScreen(
                            movie: currentItem, heroTag: heroTag))));
              },
            ),
          );
        },
        itemCount: state.movies.length,
      );
    }
    return widget;
  }

  PreferredSize _buildAppBar(SearchMovieState state) {
    return PreferredSize(
      preferredSize: Size.fromHeight(state.appBarHeight),
      child: AnimatedOpacity(
        opacity: state.showAppbar ? 1 : 0,
        duration: const Duration(milliseconds: 500),
        child: AppBar(
          elevation: 0,
          toolbarHeight: double.maxFinite,
          backgroundColor: MyColors.bgColor,
          title: TextField(
            focusNode: _focusNode,
            textInputAction: TextInputAction.search,
            cursorColor: Colors.white.withOpacity(0.85),
            style: MyTextStyles.title.copyWith(color: Colors.white60),
            decoration: InputDecoration(
                prefixIcon: Icon(
                  EvaIcons.search,
                  color: Colors.white.withOpacity(0.8),
                ),
                suffixIcon: IconButton(
                    onPressed: () {
                      //TODO
                    },
                    icon: Icon(
                      EvaIcons.options2Outline,
                      color: Colors.white.withOpacity(0.8),
                    )),
                labelText: 'What are you looking for?',
                hintText: state.title),
            onChanged: ((value) {
              _fetchMovies(value);
            }),
          ),
        ),
      ),
    );
  }
}
