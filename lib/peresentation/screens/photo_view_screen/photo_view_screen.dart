import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie/constants/my_colors.dart';
import 'package:flutter_movie/constants/my_dimentions.dart';
import 'package:flutter_movie/constants/my_text_styles.dart';
import 'package:flutter_movie/logic/cubits/photos_movie/photos_movie_cubit.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class PhotoViewScreen extends StatefulWidget {
  const PhotoViewScreen({super.key,});

  @override
  State<PhotoViewScreen> createState() => _PhotoViewScreenState();
}

class _PhotoViewScreenState extends State<PhotoViewScreen> {
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: context.read<PhotosMovieCubit>().state.selectedItem);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          backgroundColor: MyColors.bgColor,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: size.width,
                height: size.width,
                child: PageView.builder(
                  controller: _controller,
                  itemBuilder: ((context, index) {
                    return CachedNetworkImage(
                      imageUrl:
                          context.watch<PhotosMovieCubit>().state.photos[index],
                      placeholder: (context, url) => const SpinKitFadingFour(
                        color: MyColors.primaryColor,
                      ),
                      errorWidget: (context, url, error) => const Image(
                        image: AssetImage('assets/images/img2.png'),
                        fit: BoxFit.cover,
                      ),
                      fit: BoxFit.cover,
                    );
                  }),
                  itemCount:
                      context.watch<PhotosMovieCubit>().state.photos.length,
                  onPageChanged: ((value) {
                    context.read<PhotosMovieCubit>().setItemIndex(value);
                  }),
                ),
              ),
              SizedBox(
                height: MyDimens.small,
              ),
              Text(
                '${context.watch<PhotosMovieCubit>().state.selectedItem + 1} / ${context.watch<PhotosMovieCubit>().state.photos.length}',
                style: MyTextStyles.subTitleSecondary
                    .copyWith(color: Colors.white),
              ),
            ],
          )),
    );
  }
}
