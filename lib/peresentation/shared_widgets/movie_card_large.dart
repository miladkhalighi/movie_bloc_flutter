// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/peresentation/shared_widgets/custom_cached_network_image.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:flutter_movie/constants/my_colors.dart';
import 'package:flutter_movie/constants/my_dimentions.dart';
import 'package:flutter_movie/constants/my_text_styles.dart';

class MovieCardLarge extends StatelessWidget {
  final String heroTag;
  final String img;
  final String title;
  final String category;
  final double rate;
  final Function() onPressed;
  const MovieCardLarge({
    Key? key,
    required this.heroTag,
    required this.img,
    required this.title,
    required this.category,
    required this.rate,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        //image
        Expanded(
          child: ZoomIn(
            child: Container(
              decoration: BoxDecoration(
                color: MyColors.cardBgColor,
                boxShadow: [
                  BoxShadow(
                      color: Colors.white.withOpacity(0.4),
                      blurRadius: 8,
                      spreadRadius: 2),
                  BoxShadow(
                      color: MyColors.primaryColor.withOpacity(0.4),
                      blurRadius: 16,
                      ),
                ],
                borderRadius: BorderRadius.circular(25),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Hero(
                  tag: heroTag,
                  child: CustomCachedNetworkImg(imgUrl: img),
                ),
              ),
            ),
          ),
        ),
        FadeIn(
          delay: const Duration(milliseconds: 300),
          duration: const Duration(milliseconds: 800),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MyDimens.medium,
              ),
              RatingBar(
                  itemSize: 20,
                  initialRating: rate,
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
              const SizedBox(
                height: 8,
              ),
              Text(
                title,
                style: MyTextStyles.title.copyWith(fontSize: 14),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: 4,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  category,
                  style: MyTextStyles.subTitle,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
