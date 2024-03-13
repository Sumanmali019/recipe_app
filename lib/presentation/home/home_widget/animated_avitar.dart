// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

import '../../../const_assets/assets.dart';
import '../../login/login.screen.dart';

class AnimatedAvatarWidget extends StatelessWidget {
  // final Duration avatarPlayDuration;
  // final Duration avatarWaitingDuration;
  final BoxConstraints constraints;
  const AnimatedAvatarWidget({
    Key? key,
    // required this.avatarPlayDuration,
    // required this.avatarWaitingDuration,
    required this.constraints,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 215,
      left: constraints.maxWidth * 0.52,
      child: CircleAvatar(
        radius: 18,
        backgroundColor: Colors.blue.shade900,
        child: InkWell(
            onTap: () {
              Get.toNamed('/login');
            },
            child: Image.asset(Assets.profileImage)),
      )
          .animate()
          .scaleXY(
              begin: 0,
              end: 2,
              // duration: avatarPlayDuration,
              curve: Curves.easeInOutSine)
          // .then(delay: 0)
          .slide(begin: Offset.zero, end: const Offset(4.1, -5)),
    );
  }
}
