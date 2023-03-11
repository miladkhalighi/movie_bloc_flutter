import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/constants/my_colors.dart';
import 'package:flutter_movie/constants/my_text_styles.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _title = "";
  late TextEditingController _textCtr;
  late ScrollController _scrollController;
  double _appBarHeight = 84;
  double _scrollOffset = 0.0;
  bool _showAppBar = true;

  @override
  void initState() {
    _textCtr = TextEditingController();
    _scrollController = ScrollController()..addListener(scrollListener);
    super.initState();
  }

  void scrollListener() {
    setState(() {
      _scrollOffset = _scrollController.offset;
      if (_scrollOffset > _appBarHeight && _showAppBar) {
        _showAppBar = false;
      } else if (_scrollOffset <= _appBarHeight && !_showAppBar) {
        _showAppBar = true;
      }

      if (_showAppBar) {
        _appBarHeight += 4;
      } else {
        _appBarHeight -= 4;
      }
      _appBarHeight = _appBarHeight.clamp(0.0, 84.0); // ensure that the app bar height remains within a range of 0 to 84 pixels.
    });
  }

  @override
  void dispose() {
    _textCtr.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: MyColors.bgColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(_appBarHeight),
        child: AnimatedOpacity(
          opacity: _showAppBar ? 1 : 0,
          duration: const Duration(milliseconds: 500),
          child: AppBar(
            toolbarHeight: double.maxFinite,
            backgroundColor: MyColors.bgColor,
            title: TextField(
              textInputAction: TextInputAction.search,
              cursorColor: Colors.white.withOpacity(0.85),
              style: MyTextStyles.title.copyWith(color: Colors.white60),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  EvaIcons.search,
                  color: Colors.white.withOpacity(0.8),
                ),
                suffixIcon: IconButton(
                    onPressed: () {
                      //TODO
                    },
                    icon: Icon(
                      EvaIcons.options2Outline,
                      color: Colors.white.withOpacity(0.8),
                    )),
                labelText: 'What are you looking for?',
              ),
              onChanged: ((value) {
                if (value.isNotEmpty) {
                  setState(() {
                    _title = value;
                  });
                }
              }),
            ),
          ),
        ),
      ),
      body: SizedBox.expand(
        child: GridView.builder(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 0.7 / 1),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 100,
                height: 100,
                color: Colors.red,
              ),
            );
          },
          itemCount: 20,
        ),
      ),
    );
  }
}
