// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:recepi_application/presentation/catgeory/widgets/catgeoy_list_widget.dart';
import 'package:recepi_application/presentation/home/controllers/home.controller.dart';

class AnimatedCategoryList extends GetView<HomeController> {
  final BoxConstraints constraints;
  final Duration categoryListPlayDuration;
  final Duration categoryListDelayDuration;
  final Function(String) onCategorySelected;
  final String selectedCategory;
  final List<FoodCategoryWidget> categories;

  const AnimatedCategoryList({
    Key? key,
    required this.constraints,
    required this.categoryListPlayDuration,
    required this.categoryListDelayDuration,
    required this.onCategorySelected,
    required this.selectedCategory,
    required this.categories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: constraints.maxHeight * 0.06,
        height: 45,
        width: constraints.maxWidth,
        child: Obx(() {
          return ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 16, right: 16),
            children: List.generate(
                categories.length,
                (index) => Padding(
                      padding: const EdgeInsets.only(left: 10, right: 16),
                      child: GestureDetector(
                        onTap: () => onCategorySelected(categories[index].name),
                        child: FoodCategoryWidget(
                          icon: categories[index].icon,
                          name: categories[index].name,
                          isSelected: categories[index].name.toLowerCase() ==
                              selectedCategory
                                  .toLowerCase(), 
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
