import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class PageNotFound extends StatelessWidget {
  const PageNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset('assets/lottie/404page2.json');
  }
}