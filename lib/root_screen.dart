import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie/constants/my_colors.dart';
import 'package:flutter_movie/constants/my_text_styles.dart';
import 'package:flutter_movie/logic/cubits/bottom_navigation/bottom_navigation_cubit.dart';
import 'package:flutter_movie/peresentation/screens/home_screen/home_screen.dart';
import 'package:flutter_movie/peresentation/screens/search_screen/search_screen.dart';
import 'package:flutter_movie/peresentation/screens/watch_list_screen/watch_list_screen.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: context.read<BottomNavigationCubit>().state.currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: MyColors.bgColor,
      body: SizedBox.expand(
        child: PageView(
          scrollDirection: Axis.vertical,
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            const HomeScreen(),
            const SearchScreen(),
            const WatchListScreen(),
            Container(
              color: MyColors.bgColor,
              child: Center(child: Text('Not implemented yet',style: MyTextStyles.title,)),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(top: 8),
        decoration: const BoxDecoration(
          color: MyColors.cardBgColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),),
        child: BottomNavyBar(
          iconSize: 24,
          backgroundColor: MyColors.cardBgColor,
          containerHeight: MediaQuery.of(context).size.height / 11,
          itemCornerRadius: 16,
          items: [
            BottomNavyBarItem(
                title: const Text('Home'),
                icon: Icon(context.watch<BottomNavigationCubit>().state.currentIndex==0 ? EvaIcons.tv : EvaIcons.tvOutline),
                activeColor: MyColors.primaryColor,
                inactiveColor: Colors.grey),
            BottomNavyBarItem(
                title: const Text('Search'),
                icon: Icon(context.watch<BottomNavigationCubit>().state.currentIndex==1 ? EvaIcons.search : EvaIcons.searchOutline),
                activeColor: MyColors.primaryColor,
                inactiveColor: Colors.grey),
            BottomNavyBarItem(
                title: const Text('Watch list'),
                icon: Icon(context.watch<BottomNavigationCubit>().state.currentIndex==2 ? EvaIcons.bookmark : EvaIcons.bookmarkOutline),
                activeColor: MyColors.primaryColor,
                inactiveColor: Colors.grey),
            BottomNavyBarItem(
                title: const Text('Profile'),
                icon: Icon(context.watch<BottomNavigationCubit>().state.currentIndex==3 ? EvaIcons.person : EvaIcons.personOutline),
                activeColor: MyColors.primaryColor,
                inactiveColor: Colors.grey),
          ],
          onItemSelected: (index) {
            context.read<BottomNavigationCubit>().setIndex(index);
            _pageController.animateToPage(index,
                duration: const Duration(milliseconds: 600),
                curve: Curves.fastOutSlowIn);

            // without animation
            //_pageController.jumpToPage(index);
          },
          selectedIndex:
              context.watch<BottomNavigationCubit>().state.currentIndex,
        ),
      ),
    ));
  }
}
