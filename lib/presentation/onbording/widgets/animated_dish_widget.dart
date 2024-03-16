// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:recepi_application/const_assets/theme/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class AnimatedDishWidget extends StatelessWidget {
  final BoxConstraints constraints;
  final String imageUrl;
  final Duration dishPlayTime;
  const AnimatedDishWidget({
    Key? key,
    required this.constraints,
    required this.imageUrl,
    required this.dishPlayTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: constraints.maxHeight * 0.31,
      width: constraints.maxWidth * 0.8,
      alignment: Alignment.center,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.contain,
        alignment: Alignment.center,
        placeholder: (context, url) => Shimmer.fromColors(
          baseColor: AppColors.cardColor,
          highlightColor: AppColors.cardColor,
          child: SizedBox(
              height: constraints.maxHeight * 0.2,
              width: constraints.maxWidth * 0.4,
              child: const Center(
                child: Icon(
                  Icons.restaurant,
                  size: 60,
                ),
              )),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    )
        .animate()
        .scaleXY(
            begin: 0.0,
            end: 1.0,
            duration: dishPlayTime,
            curve: Curves.decelerate)
        .fadeIn()
        .blurXY(begin: 10, end: 0);
  }
}
