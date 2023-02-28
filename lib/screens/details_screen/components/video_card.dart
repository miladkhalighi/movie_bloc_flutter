import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/constants/my_colors.dart';
import 'package:flutter_movie/constants/my_text_styles.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class VideoCard extends StatelessWidget {
  const VideoCard({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: SizedBox(
            width: size.width / 3,
            child: CachedNetworkImage(
              imageUrl: 'imgUrl',
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
        ),
        Positioned(
          right: 8,
          bottom: 16,
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(50)),
            child: const Icon(
              Icons.play_arrow_rounded,
              color: Colors.black,
            ),
          ),
        ),
        Positioned(
          left: 8,
          top: 8,
          child: Container(
            decoration: BoxDecoration(
                color: MyColors.cardBgColor.withOpacity(0.8), borderRadius: BorderRadius.circular(8)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("2:54",style: MyTextStyles.subTitle.copyWith(color: Colors.white),),
            )
          ),
        ),
      ],
    );
  }
}