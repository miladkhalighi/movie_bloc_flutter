import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie/constants/my_colors.dart';
import 'package:flutter_movie/logic/cubits/cast_movies/cast_movies_cubit.dart';
import 'package:flutter_movie/logic/cubits/crew_movies/crew_movies_cubit.dart';
import 'package:flutter_movie/peresentation/screens/details_screen/components/cast_crew_card.dart';
import 'package:flutter_movie/peresentation/shared_widgets/page_not_found.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CastAndCrewListWidget extends StatelessWidget {
  const CastAndCrewListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CastMoviesCubit, CastMoviesState>(
      builder: (context, castState) {
        return BlocBuilder<CrewMoviesCubit, CrewMoviesState>(
          builder: (context, crewState) {
            Widget widget = const SizedBox.shrink();
            if (castState.status == CastStatus.initial ||
                crewState.status == CrewStatus.initial) {
              //initial
              widget = const SpinKitFadingFour(
                color: MyColors.primaryColor,
              );
            } else if (castState.status == CastStatus.loading ||
                crewState.status == CrewStatus.loading) {
              //loading
              widget = const SpinKitFadingFour(
                color: MyColors.primaryColor,
              );
            } else if (castState.status == CastStatus.error &&
                crewState.status == CrewStatus.error) {
              //error
              widget = const PageNotFound();
            } else if (castState.status == CastStatus.loaded ||
                crewState.status == CrewStatus.loaded) {
              //loaded
              widget = ListView.builder(
                itemBuilder: ((context, index) {
                  if (index < castState.cast.length) {
                    final member = castState.cast[index];
                    return Padding(
                      padding: EdgeInsets.fromLTRB(
                          index == 0 ? 16 : 4,
                          0,
                          index ==
                                  castState.cast.length +
                                      crewState.crew.length -
                                      1
                              ? 16
                              : 4,
                          0),
                      child: CastCrewCard(
                          title: member.name ?? "unkown",
                          subTitle: member.character ?? "unkown",
                          imgUrl: member.imageUrl),
                    );
                  } else {
                    final member =
                        crewState.crew[index - castState.cast.length];
                    return Padding(
                      padding: EdgeInsets.fromLTRB(
                          index == 0 ? 16 : 4,
                          0,
                          index ==
                                  castState.cast.length +
                                      crewState.crew.length -
                                      1
                              ? 16
                              : 4,
                          0),
                      child: CastCrewCard(
                          title: member.name ?? 'unkown',
                          subTitle: member.job ?? 'unkown',
                          imgUrl: member.imageUrl),
                    );
                  }
                }),
                itemCount: castState.cast.length + crewState.crew.length,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
              );
            }
            return widget;
          },
        );
      },
    );
  }
}