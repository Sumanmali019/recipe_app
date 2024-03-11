import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recepi_application/presentation/home/controllers/home.controller.dart';
import 'package:recepi_application/presentation/home/wiget/afterlodainf.dart';
import 'package:recepi_application/presentation/home/wiget/shimmer.dart';

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
        return Center(child: Text(controller.errorMessage.value));
      } else {
        return LoadedRecipesWidget(
            recipes: controller.recipes, constraints: constraints);
      }
    });
  }
}
