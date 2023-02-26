
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/constants/my_colors.dart';
import 'package:flutter_movie/constants/my_dimentions.dart';
import 'package:flutter_movie/constants/my_text_styles.dart';
import 'package:flutter_movie/models/cast.dart';
import 'package:flutter_movie/screens/details_screen/cast_crew_card.dart';
import 'package:flutter_movie/shared_widgets/title_with_text_btn.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: PageView(
          scrollDirection: Axis.vertical,
          //physics: const BouncingScrollPhysics(),
          children: [
            SizedBox(
              height: size.height,
              child: Stack(children: [
                Image(
                  width: size.width,
                  height: size.height,
                  image: AssetImage('assets/images/img1.png'),
                  fit: BoxFit.cover,
                ),
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.65),
                      Colors.black.withOpacity(0.65),
                      MyColors.bgColor
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )),
                ),
                Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                        margin: EdgeInsets.all(MyDimens.medium),
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(50)),
                        child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.arrow_back_ios_rounded,
                              color: Colors.white,
                            )))),
                Positioned(
                    top: 80,
                    left: 0,
                    right: 0,
                    child: Column(
                      children: [
                        Text(
                          'John Wick 3: Parabellum asdasdasdasdads',
                          style: MyTextStyles.titleSecondary,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: MyDimens.small,
                        ),
                        Text(
                          '2hr 10m | R',
                          style: MyTextStyles.subTitleSecondary,
                        ),
                        SizedBox(
                          height: MyDimens.small,
                        ),
                        Text(
                          'Action, Crime, Thriller',
                          style: MyTextStyles.subTitleSecondary,
                        ),
                        SizedBox(
                          height: MyDimens.small,
                        ),
                        RatingBar(
                            itemSize: 20,
                            initialRating: 3,
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
                        SizedBox(
                          height: MyDimens.small,
                        ),
                        Text(
                          '2010 - 2018',
                          style: MyTextStyles.subTitleSecondary,
                        ),
                        const SizedBox(
                          height: 64,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: MyDimens.small),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Synopsis',
                              style: MyTextStyles.subTitle
                                  .copyWith(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MyDimens.small,
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: MyDimens.small),
                          child: ExpandableText(
                            ' longText longText longxt' * 40,
                            expandText: 'show more',
                            collapseText: 'show less',
                            maxLines: 3,
                            linkColor: MyColors.seeMoreColor,
                            linkStyle: MyTextStyles.title,
                            style: MyTextStyles.body,
                          ),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        TitleWithTextBtn(
                          onPressed: () {},
                          title: 'Cast & Crew',
                          btnColor: MyColors.seeMoreColor,
                        ),
                        SizedBox(
                            height: 64,
                            child: ListView.builder(
                                itemBuilder: ((context, index) {
                              return Padding(
                                padding: EdgeInsets.fromLTRB(index==0? 16 :4, 0, index==fakeCast.length-1 ? 16 : 4, 0),
                                child: CastCrewCard(cast: fakeCast[index]),
                              );
                            }),
                            itemCount: fakeCast.length,
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            ))
                      ],
                    ))
              ]),
            ),
            Container(
              height: size.height,
              color: MyColors.bgColor,
            ),
          ],
        ),
      ),
    );
  }
}



List<Cast> fakeCast = [
  Cast(
      id: 23, name: 'name', character: 'character', profilePath: 'profilePath'),
  Cast(
      id: 14,
      name: 'asdads',
      character: 'gholinejad',
      profilePath: 'profilePath'),
  Cast(
      id: 33,
      name: 'imksaidm',
      character: 'ferdosipoor',
      profilePath: 'profilePath'),
  Cast(
      id: 23,
      name: 'asuyksd',
      character: 'ali daie',
      profilePath: 'profilePath'),
  Cast(
      id: 53,
      name: 'milad',
      character: 'karim bagheri',
      profilePath: 'profilePath'),
  Cast(
      id: 12,
      name: 'gholi',
      character: 'kamsdklmad',
      profilePath: 'profilePath'),
];
