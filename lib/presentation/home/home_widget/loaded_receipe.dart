import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:recepi_application/domain/model/recipe.dart';
import 'package:recepi_application/presentation/home/home_widget/home_recepi_card.dart';
import 'package:recepi_application/presentation/home/controllers/home.controller.dart';
import 'package:recepi_application/presentation/login/controllers/login.controller.dart';

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
    final LoginController loginController = Get.find<LoginController>();

    return Obx(() {
      return ListView.builder(
        itemCount: controller.recipes.length,
        itemBuilder: (context, index) {
          final recipe = controller.recipes[index];
          return GestureDetector(
            onTap: () {
              if (loginController.isLoggedIn()) {
                loginController.incrementRecipesClickedCount();
                navigateToRecipe(context, recipe);
              } else {
                handleNonLoggedInUser(context, recipe);
              }
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
        },
      );
    });
  }

  void handleNonLoggedInUser(BuildContext context, Recipe recipe) {
    final GetStorage box = GetStorage();
    int localCount = box.read('localCount') ?? 0;

    if (localCount >= 5) {
      showLoginPrompt(context);
    } else {
      localCount++;
      box.write('localCount', localCount);
      navigateToRecipe(context, recipe);
    }
  }

  void showLoginPrompt(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Sign In Required"),
          content: const Text("Please log in to continue exploring recipes."),
          actions: <Widget>[
            TextButton(
              child: const Text("Login Now"),
              onPressed: () {
                Navigator.of(context).pop();
                Get.toNamed('/login');
              },
            ),
          ],
        );
      },
    );
  }

  void navigateToRecipe(BuildContext context, Recipe recipe) {
    Navigator.of(context).pushNamed('/catgeory', arguments: recipe);
  }
}
