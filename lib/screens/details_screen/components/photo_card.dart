import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/constants/my_colors.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class PhotoCard extends StatelessWidget {
  final String imgUrl;
  const PhotoCard({
    Key? key,
    required this.imgUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        width: size.width / 2.5,
        child: CachedNetworkImage(
          imageUrl: imgUrl,
          placeholder: (context, url) => const SpinKitFadingFour(
            color: MyColors.primaryColor,
          ),
          errorWidget: (context, url, error) => const Image(
            image: AssetImage('assets/images/img2.png'),
            fit: BoxFit.cover,
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}