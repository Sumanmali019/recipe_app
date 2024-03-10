import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:recepi_application/domain/model/recipe.dart';
import 'package:recepi_application/presentation/home/wiget/home_Listo_recepi_card.dart';

import '../controllers/home.controller.dart';

class LoadedRecipesWidget extends StatelessWidget {
  final List<Recipe> recipes;
  final BoxConstraints constraints;
  const LoadedRecipesWidget({
    Key? key,
    required this.recipes,
    required this.constraints,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();
    return Obx(() => ListView.builder(
        itemCount: controller.recipes.length,
        itemBuilder: (context, index) {
          final recipe = controller.recipes[index];
          return GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                'recipe_details',
                arguments: recipe,
              );
            },
            child: RecipeCardWidget(constraints: constraints, recipe: recipe)
                .animate()
                .slideX(
                    duration: 200.ms,
                    delay: 0.ms,
                    begin: 1,
                    end: 0,
                    curve: Curves.easeInOutSine),
          );
        }));
  }
}
