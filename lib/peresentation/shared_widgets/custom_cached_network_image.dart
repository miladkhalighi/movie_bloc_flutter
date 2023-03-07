import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/constants/my_colors.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomCachedNetworkImg extends StatelessWidget {
  final String imgUrl;
  const CustomCachedNetworkImg({required this.imgUrl, super.key});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imgUrl,
      placeholder: (context, url) => Container(
        color: MyColors.cardBgColor,
        child: const Center(
          child: SpinKitFadingFour(
            color: MyColors.primaryColor,
          ),
        ),
      ),
      errorWidget: (context, url, error) => Container(
        color: MyColors.cardBgColor,
        child: Icon(Icons.broken_image,color: Colors.grey,size: MediaQuery.of(context).size.width / 5,)
      ),
      fit: BoxFit.cover,
    );
  }
}
