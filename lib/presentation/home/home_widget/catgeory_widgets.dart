// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:recepi_application/presentation/home/home_widget/catgeoy_list_widget.dart';
import 'package:recepi_application/presentation/home/controllers/home.controller.dart';

import '../../../const_assets/assets.dart';

class AnimatedCategoryList extends GetView<HomeController> {
  final BoxConstraints constraints;
  final Duration categoryListPlayDuration;
  final Duration categoryListDelayDuration;
  final Function(String) onCategorySelected;
  final List<FoodCategoryWidget> categories;

  const AnimatedCategoryList({
    Key? key,
    required this.constraints,
    required this.categoryListPlayDuration,
    required this.categoryListDelayDuration,
    required this.onCategorySelected,
    required this.categories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: constraints.maxHeight * 0.10,
        height: 80,
        width: constraints.maxWidth * 0.99,
        child: Obx(() {
          return ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 8, right: 8),
            children: List.generate(
                categories.length,
                (index) => Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: GestureDetector(
                        onTap: () => onCategorySelected(categories[index].name),
                        child: FoodCategoryWidget(
                          imageUrl: controller.categories[index].imageUrl,
                          name: controller.categories[index].name,
                          isSelected: controller.categories[index].name
                                  .toLowerCase() ==
                              controller.currentCategory.value.toLowerCase(),
                        ),
                      ),
                    )).animate().slideX(
                duration: categoryListPlayDuration,
                begin: 3,
                end: 0,
                curve: Curves.easeInOutSine),
          );
        }));
  }
}
