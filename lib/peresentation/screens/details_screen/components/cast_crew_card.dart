import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/constants/my_colors.dart';
import 'package:flutter_movie/constants/my_dimentions.dart';
import 'package:flutter_movie/constants/my_text_styles.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CastCrewCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final String imgUrl;
  const CastCrewCard({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.imgUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ZoomIn(
      child: SizedBox(
        width: size.width / 1.8,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(1000),
                child: CachedNetworkImage(
                  imageUrl: imgUrl,
                  placeholder: (context, url) => const SpinKitFadingFour(
                    color: MyColors.primaryColor,
                  ),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.person_off,
                    size: 48,
                    color: Colors.grey,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: MyDimens.small,
            ),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: MyTextStyles.title.copyWith(fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  Text(
                    subTitle,
                    style: MyTextStyles.subTitle.copyWith(fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
