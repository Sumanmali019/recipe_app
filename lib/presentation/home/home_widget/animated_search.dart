import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:recepi_application/const_assets/theme/app_colors.dart';

class AnimatedNameWidget extends StatelessWidget {
  final Duration namePlayDuration;
  final Duration nameDelayDuration;
  final BoxConstraints constraints;
  const AnimatedNameWidget({
    super.key,
    required this.namePlayDuration,
    required this.nameDelayDuration,
    required this.constraints,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 27,
      top: Get.height * 0.025,
      child: InkWell(
        onTap: () {
          Get.toNamed('/search');
        },
        child: const Row(
          children: [
            Icon(
              Icons.search,
              size: 35,
              color: AppColors.bluecolur,
              weight: 50,
              opticalSize: 50,
            ),
            Text(
              "search",
              style: TextStyle(fontSize: 22, color: Colors.black),
            )
          ],
        ),
      )
          .animate()
          .slideX(
              begin: 0.2,
              end: 0,
              duration: namePlayDuration,
              delay: nameDelayDuration,
              curve: Curves.fastOutSlowIn)
          .fadeIn(),
    );
  }
}
