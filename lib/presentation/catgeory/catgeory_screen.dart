import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:get/get.dart';
import 'package:recepi_application/presentation/catgeory/widgets/animated_app_bar.dart';
import 'package:recepi_application/presentation/catgeory/widgets/reciepi_information.dart';
import 'package:recepi_application/presentation/catgeory/widgets/time_linr-sliding.dart';
import 'package:recepi_application/presentation/home/home_widget/home_saffold.dart';
import 'package:recepi_application/presentation/onbording/widgets/animated_dish_widget.dart';
import 'controllers/catgeory.controller.dart';

class CatgeoryScreen extends GetView<CatgeoryController> {
  const CatgeoryScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AnnotatedScaffold(
        child: LayoutBuilder(builder: (context, constraints) {
      final appBarPlayTime = 800.ms;
      final appBarDelayTime = 400.ms;
      final infoDelayTime = appBarPlayTime + appBarDelayTime - 200.ms;
      final infoPlayTime = 500.ms;
      final dishPlayTime = 600.ms;
      return TimeLineSlidingPanel(
          recipe: controller.recipe.value,
          constraints: constraints,
          body: Column(
            children: [
              AnimatedAppBarWidget(
                name: controller.recipe.value.name,
                appBarPlayTime: appBarPlayTime,
                appBarDelayTime: appBarDelayTime,
                recipe: controller.recipe.value,
              ),
              SizedBox(
                height: constraints.maxHeight * 0.04,
              ),
              AnimatedDishWidget(
                constraints: constraints,
                imageUrl: controller.recipe.value.imageUrl,
                dishPlayTime: dishPlayTime,
              ),
              SizedBox(
                height: constraints.maxHeight * 0.06,
              ),
              AnimatedInfoWidget(
                  nutrition: {
                    'calories': controller.recipe.value.nutrition.calories,
                    'Serving': controller.recipe.value.nutrition.serving,
                    'prepTime': controller.recipe.value.nutrition.prepTime,
                  },
                  infoDelayTime: infoDelayTime,
                  infoPlayTime: infoPlayTime,
                  constraints: constraints),
            ],
          ));
    }));
  }
}
