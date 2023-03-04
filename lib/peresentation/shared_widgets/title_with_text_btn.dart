import 'package:flutter/material.dart';
import 'package:flutter_movie/constants/my_colors.dart';
import 'package:flutter_movie/constants/my_text_styles.dart';

import '../../constants/my_dimentions.dart';

class TitleWithTextBtn extends StatelessWidget {
  final Function() onPressed;
  final String title;
  const TitleWithTextBtn({
    required this.onPressed,
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MyDimens.medium),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: MyTextStyles.title,
          ),
          TextButton(
              onPressed: onPressed,
              child: Text(
                'See all',
                style:
                    MyTextStyles.title.copyWith(color: MyColors.primaryColor),
              ))
        ],
      ),
    );
  }
}
