import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie/constants/my_colors.dart';
import 'package:flutter_movie/logic/cubits/photos_movie/photos_movie_cubit.dart';
import 'package:flutter_movie/peresentation/screens/details_screen/components/photo_card.dart';
import 'package:flutter_movie/peresentation/screens/photo_view_screen/photo_view_screen.dart';
import 'package:flutter_movie/peresentation/shared_widgets/page_not_found.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
          widget = const PageNotFound();
        } else if (state.status == PhotosStatus.loaded) {
          widget = ListView.builder(
            itemBuilder: ((context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: PhotoCard(
                  imgUrl: state.photos[index],
                  onTap: () {
                    context.read<PhotosMovieCubit>().setItemIndex(index);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) =>
                                const PhotoViewScreen())));
                  },
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
