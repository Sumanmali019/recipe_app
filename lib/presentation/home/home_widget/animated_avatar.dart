import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

import '../../../const_assets/assets.dart';
import '../../login/controllers/login.controller.dart';

class AnimatedAvatarWidget extends StatelessWidget {
  final Duration avatarPlayDuration;
  final Duration avatarWaitingDuration;
  final BoxConstraints constraints;

  const AnimatedAvatarWidget({
    Key? key,
    required this.avatarPlayDuration,
    required this.avatarWaitingDuration,
    required this.constraints,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.find<LoginController>();

    return Positioned(
      top: 215,
      left: constraints.maxWidth * 0.52,
      child: Obx(() {
        Widget imageWidget;

        if (loginController.userProfileImageUrl.value.isNotEmpty) {
          imageWidget = ClipOval(
            child: Image.network(
              loginController.userProfileImageUrl.value,
              fit: BoxFit.cover,
              width: 35,
              height: 35,
            ),
          );
        } else {
          imageWidget = ClipOval(
            child: Image.asset(
              Assets.profileImage,
              fit: BoxFit.cover,
              width: 35,
              height: 35,
            ),
          );
        }

        return CircleAvatar(
          radius: 18,
          backgroundColor: Colors.white,
          child: InkWell(
            onTap: () {
              Get.toNamed('/login');
            },
            child: imageWidget,
          ),
        )
            .animate()
            .scaleXY(
                begin: 0,
                end: 1.8,
                duration: avatarPlayDuration,
                curve: Curves.easeInOutSine)
            .slide(begin: Offset.zero, end: const Offset(4.1, -5));
      }),
    );
  }
}
