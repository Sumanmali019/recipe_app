import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:get/get.dart';
import 'package:recepi_application/presentation/home/home_widget/animated_avitar.dart';
import 'package:recepi_application/presentation/home/home_widget/animated_search.dart';
import 'package:recepi_application/presentation/home/home_widget/catgeory_widgets.dart';
import 'package:recepi_application/presentation/home/home_widget/animated_recepiwidget.dart';
import 'package:recepi_application/presentation/home/home_widget/home_saffold.dart';

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
      final avatarPlayDuration = 900.ms;

      return Stack(
        children: [
          AnimatedAvatarWidget(
            constraints: constraints,
            avatarWaitingDuration: avatarWaitingDuration,
            avatarPlayDuration: avatarPlayDuration,
          ),
          AnimatedsearchWidget(
            constraints: constraints,
            namePlayDuration: namePlayDuration,
            nameDelayDuration: nameDelayDuration,
          ),
          AnimatedCategoryList(
            constraints: constraints,
            categoryListPlayDuration: categoryListPlayDuration,
            categoryListDelayDuration: categoryListDelayDuration,
            onCategorySelected: controller.setCurrentCategory,
            categories: controller.categories,
          ),
          Positioned.fill(
              top: constraints.maxHeight * 0.20,
              child: AnimatedRecipesWidget(
                constraints: constraints,
              )),
        ],
      );
    }));
  }
}
