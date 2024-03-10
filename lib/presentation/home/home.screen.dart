import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:get/get.dart';
import 'package:recepi_application/presentation/catgeory/widgets/catgeory_widgets.dart';
import 'package:recepi_application/presentation/home/wiget/animated_recepiwidget.dart';
import 'package:recepi_application/presentation/home/wiget/home_Listo_recepi_card.dart';
import 'package:recepi_application/presentation/home/wiget/wiget.dart';

import 'controllers/home.controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AnnotatedScaffold(
        child: LayoutBuilder(builder: (context, constraints) {
      final avatarWaitingDuration = 400.ms;
      final nameDelayDuration =
          avatarWaitingDuration + avatarWaitingDuration + 200.ms;
      final namePlayDuration = 800.ms;
      final categoryListPlayDuration = 750.ms;
      final categoryListDelayDuration =
          nameDelayDuration + namePlayDuration - 400.ms;

      return Stack(
        children: [
          // AnimatedCategoryList(
          //   constraints: constraints,
          //   categoryListPlayDuration: categoryListPlayDuration,
          //   categoryListDelayDuration: categoryListDelayDuration,
          // ),
          Obx(() {
            if (controller.isLoading.isTrue) {
              return Center(child: CircularProgressIndicator());
            } else if (controller.errorMessage.isNotEmpty) {
              return Center(child: Text(controller.errorMessage.value));
            } else {
              return ListView.builder(
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
                      child: RecipeCardWidget(
                              constraints: constraints, recipe: recipe)
                          .animate()
                          .slideX(
                              duration: 200.ms,
                              delay: 0.ms,
                              begin: 1,
                              end: 0,
                              curve: Curves.easeInOutSine),
                    );
                  });
            }
          })
        ],
      );
    }));
  }
}
