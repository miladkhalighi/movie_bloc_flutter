import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/constants/my_colors.dart';
import 'package:flutter_movie/constants/my_dimentions.dart';
import 'package:flutter_movie/constants/my_text_styles.dart';
import 'package:flutter_movie/models/cast.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CastCrewCard extends StatelessWidget {
  final Cast cast;
  const CastCrewCard({
    Key? key,
    required this.cast,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width / 2,
      child: Row(
        children: [
          SizedBox(
            width: 64,
            height: 64,
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: cast.imageUrl,
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
          SizedBox(
            width: MyDimens.small,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cast.name,
                style: MyTextStyles.title.copyWith(fontSize: 16),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              Text(
                cast.character,
                style: MyTextStyles.subTitle.copyWith(fontSize: 16),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          )
        ],
      ),
    );
  }
}