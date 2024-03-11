import 'package:get/get.dart';

import '../../../domain/model/recipe.dart';

class CatgeoryController extends GetxController {
  Rx<Recipe> recipe = Recipe(
    id: "1",
    name: "Spaghetti Bolognese",
    description: "A classic Italian meat sauce served over pasta",
    imageUrl: "assets/images/spaghetti.png",
    category: "popular",
    ingredients: [
      "spaghetti",
      "ground chicken",
      "onions",
      "tomato sauce",
      "red wine"
    ],
    steps: [
      "Cook the spaghetti according to package directions.",
      "Brown the ground chicken and onions.",
      "Add the tomato sauce and red wine and simmer for 1 hour.",
      "Toss with cooked spaghetti and serve."
    ],
    nutrition: Nutrition(calories: 650, protein: 35, prepTime: 60),
  ).obs;

  @override
  void onInit() {
    super.onInit();
    recipe.value = Get.arguments;
  }
}
