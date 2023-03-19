import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/constants/my_colors.dart';
import 'package:flutter_movie/constants/my_text_styles.dart';
import 'package:flutter_movie/peresentation/shared_widgets/custom_cached_network_image.dart';

class MovieCardSmall extends StatelessWidget {
  const MovieCardSmall({
    Key? key,
    required this.heroTag,
    required this.img,
    required this.title,
    required this.category,
    required this.onPressed,
    this.expandWidth = false,
  }) : super(key: key);

  final Function() onPressed;
  final String heroTag;
  final String img;
  final String title;
  final String category;
  final bool expandWidth;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onPressed,
      child: ZoomIn(
        child: Container(
          width: expandWidth ? size.width : size.width / 1.973,
          height: size.height / 7.25,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: MyColors.cardBgColor,
              boxShadow: [
                BoxShadow(color: Colors.white.withOpacity(0.4), blurRadius: 8)
              ]),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Hero(
                      tag: heroTag,
                      child: CustomCachedNetworkImg(imgUrl: img),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        title,
                        style: MyTextStyles.title.copyWith(fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      Text(
                        category,
                        style: MyTextStyles.subTitle,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
