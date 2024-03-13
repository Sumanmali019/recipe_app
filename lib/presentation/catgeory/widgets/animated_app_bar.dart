// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class AnimatedAppBarWidget extends StatelessWidget {
  final String name;
  final Duration appBarPlayTime;
  final Duration appBarDelayTime;
  const AnimatedAppBarWidget({
    Key? key,
    required this.name,
    required this.appBarPlayTime,
    required this.appBarDelayTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              size: 16,
              color: Colors.black,
            )),
        Text(
          name.toUpperCase(),
          style: GoogleFonts.alice(
            color: Colors.black87,
            fontSize: 16,
            fontWeight: FontWeight.w900,
          ),
        ),
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.favorite_outline,
              size: 25,
              color: Colors.black,
            ))
      ].animate(interval: 200.ms, delay: appBarDelayTime).scaleXY(
          begin: 0, end: 1, duration: appBarPlayTime, curve: Curves.decelerate),
    );
  }
}
