import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
class BackgroundDismissible extends StatelessWidget {
  final bool alignIconLeft;
  const BackgroundDismissible({
    required this.alignIconLeft,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.red.withOpacity(0.8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Align(
            alignment:
                alignIconLeft ? Alignment.centerLeft : Alignment.centerRight,
            child: const Icon(
              EvaIcons.trash2Outline,
              color: Colors.white70,
              size: 40,
            )),
      ),
    );
  }
}