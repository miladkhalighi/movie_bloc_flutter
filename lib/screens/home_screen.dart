import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_movie/constants/my_colors.dart';
import 'package:flutter_movie/constants/my_dimentions.dart';
import 'package:flutter_movie/constants/my_text_styles.dart';
import 'package:flutter_movie/shared_widgets/title_with_text_btn.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SafeArea(
        child: Scaffold(
      backgroundColor: MyColors.bgColor,
      body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              TitleWithTextBtn(onPressed: () {}, title: "Best of all the time"),
              Container(
                height: size.height / 2.236,
                color: Colors.green,
                child: MainItemCard(
                    img: '',
                    title: 'The Walking Dead',
                    category: 'Action, Drama',
                    rate: 3.5,
                    selected: true,
                    ),
              )
            ],
          )),
    ));
  }
}

class MainItemCard extends StatelessWidget {
  final String img;
  final String title;
  final String category;
  final double rate;
  final bool selected;
  const MainItemCard({
    required this.img,
    required this.title,
    required this.category,
    required this.rate,
    this.selected = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(children: [
      Container(
        margin: EdgeInsets.all(MyDimens.small),
        height: size.height / 3.075,
        decoration: BoxDecoration(
            color: Colors.blue, // for test
            boxShadow: selected ?[
              BoxShadow(color: MyColors.primaryColor.withOpacity(0.8),blurRadius: 8)
            ] : null,
            borderRadius: BorderRadius.circular(25),
            image: DecorationImage(image: AssetImage(img), fit: BoxFit.cover)),
      ),
      SizedBox(
        height: MyDimens.small,
      ),
      RatingBar(
          itemSize: 15,
          initialRating: rate,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          //unratedColor: MyColors.primaryColor,
          glowColor: MyColors.primaryColor,
          ratingWidget: RatingWidget(
            full: const Icon(Icons.star,color: MyColors.primaryColor,),
            half: const Icon(Icons.star_half_outlined,color: MyColors.primaryColor,),
            empty: const Icon(Icons.star_border_outlined,color: MyColors.primaryColor,),
          ),
          onRatingUpdate: (_) {}),
      const SizedBox(
        height: 4,
      ),
      Text(
        title,
        style: MyTextStyles.title,
      ),
      const SizedBox(
        height: 4,
      ),
      Text(
        category,
        style: MyTextStyles.subTitle.copyWith(color: MyColors.primaryTextColor),
      ),
    ]);
  }
}
