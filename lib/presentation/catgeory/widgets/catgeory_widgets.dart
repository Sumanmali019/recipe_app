// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:recepi_application/presentation/catgeory/widgets/catgeoy_list_widget.dart';

class AnimatedCategoryList extends StatelessWidget {
  final BoxConstraints constraints;
  final Duration categoryListPlayDuration;
  final Duration categoryListDelayDuration;
  const AnimatedCategoryList({
    Key? key,
    required this.constraints,
    required this.categoryListPlayDuration,
    required this.categoryListDelayDuration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: constraints.maxHeight * 0.06,
        height: 45,
        width: constraints.maxWidth,
        child: ListView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(left: 16, right: 16),
          children: List.generate(
              _categories.length,
              (index) => Padding(
                    padding: const EdgeInsets.only(left: 10, right: 16),
                    child: _categories[index],
                  )).animate().slideX(
              duration: categoryListPlayDuration,
              begin: 3,
              end: 0,
              curve: Curves.easeInOutSine),
        ));
  }
}

const _categories = [
  FoodCategoryWidget(icon: "🔥", name: "Popular"),
  FoodCategoryWidget(icon: "🥦", name: "Healthy"),
  FoodCategoryWidget(icon: "🍲", name: "Veginarian"),
  FoodCategoryWidget(icon: "🍿", name: "Diet"),
];
