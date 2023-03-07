import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie/constants/my_colors.dart';
import 'package:flutter_movie/logic/cubits/videos_movie/videos_movie_cubit.dart';
import 'package:flutter_movie/peresentation/screens/details_screen/components/video_player.dart';
import 'package:flutter_movie/peresentation/shared_widgets/page_not_found.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class VideosListWidget extends StatelessWidget {
  const VideosListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocBuilder<VideosMovieCubit, VideosMovieState>(
      builder: (context, state) {
        Widget widget = const SizedBox.shrink();
        if (state.status == VideosStatus.initial) {
          widget = const SpinKitFadingFour(color: MyColors.primaryColor);
        }
        if (state.status == VideosStatus.loading) {
          widget = const SpinKitFadingFour(color: MyColors.primaryColor);
        }
        if (state.status == VideosStatus.error) {
          widget = const PageNotFound();
        }
        if (state.status == VideosStatus.loaded) {
          widget = ListView.builder(
            itemBuilder: ((context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    width: size.width / 1.5,
                    child: VideoPlayer(videoId: state.movieIds[index])),
              );
            }),
            itemCount: state.movieIds.length,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
          );
        }
        return widget;
      },
    );
  }
}
