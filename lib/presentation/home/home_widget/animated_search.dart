import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:recepi_application/const_assets/theme/app_colors.dart';

class AnimatedsearchWidget extends StatelessWidget {
  final Duration namePlayDuration;
  final Duration nameDelayDuration;
  final BoxConstraints constraints;
  const AnimatedsearchWidget({
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
        child: Row(
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Search for recipes',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
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
