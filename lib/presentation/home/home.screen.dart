import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:get/get.dart';
import 'package:recepi_application/presentation/catgeory/widgets/catgeory_widgets.dart';
import 'package:recepi_application/presentation/home/wiget/animated_recepiwidget.dart';
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
          AnimatedCategoryList(
            constraints: constraints,
            categoryListPlayDuration: categoryListPlayDuration,
            categoryListDelayDuration: categoryListDelayDuration,
          ),
          Positioned.fill(
              top: constraints.maxHeight * 0.15,
              child: controller.showRecipeList.value
                  ? AnimatedRecipesWidget(
                      constraints: constraints,
                    )
                  : const SizedBox())
        ],
      );
    }));
  }
}
