// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_movie/peresentation/shared_widgets/custom_cached_network_image.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:flutter_movie/constants/my_colors.dart';
import 'package:flutter_movie/constants/my_dimentions.dart';
import 'package:flutter_movie/constants/my_text_styles.dart';

class MostPopularCard extends StatelessWidget {
  final String heroTag;
  final String img;
  final String title;
  final String category;
  final double rate;
  final bool selected;
  final Function() onPressed;
  const MostPopularCard({
    Key? key,
    required this.heroTag,
    required this.img,
    required this.title,
    required this.category,
    required this.rate,
    this.selected = false,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // I use STACK rather than COLUMN becuse when sliding carousel and changing the size of card overflow acurs, i fix this by using stack
    return InkWell(
      onTap: onPressed,
      child: Stack(fit: StackFit.expand, children: [
        //image
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            margin: EdgeInsets.all(MyDimens.small),
            height: size.height / 3.075,
            decoration: BoxDecoration(
              color: MyColors.cardBgColor, // for test
              boxShadow: selected
                  ? [
                      BoxShadow(
                          color: MyColors.primaryColor.withOpacity(0.8),
                          blurRadius: 8,
                          spreadRadius: 4)
                    ]
                  : null,
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
        selected
            ? Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MyDimens.small,
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
                      style: MyTextStyles.title,
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
            : const SizedBox.shrink(),
      ]),
    );
  }
}
