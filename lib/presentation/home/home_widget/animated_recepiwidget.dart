import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recepi_application/presentation/home/controllers/home.controller.dart';
import 'package:recepi_application/presentation/home/home_widget/home_shimmer.dart';
import 'package:recepi_application/presentation/home/home_widget/loaded_receipe.dart';

class AnimatedRecipesWidget extends StatelessWidget {
  final BoxConstraints constraints;

  const AnimatedRecipesWidget({
    super.key,
    required this.constraints,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Obx(() {
      if (controller.isLoading.isTrue) {
        return ShimmerLoadingList(constraints: constraints);
      } else if (controller.errorMessage.isNotEmpty) {
        return Center(
            child: Text(
          controller.errorMessage.value,
          style: const TextStyle(color: Colors.white),
        ));
      } else {
        return LoadedRecipesWidget(
            recipes: controller.recipes, constraints: constraints);
      }
    });
  }
}
