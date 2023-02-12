import 'package:flutter/material.dart';
import 'package:flutter_movie/constants/my_colors.dart';
import 'package:flutter_movie/screens/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        fontFamily: GoogleFonts.aclonica().fontFamily,
      ),
      home: const HomeScreen(),
    );
  }
}



