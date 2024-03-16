import 'package:get/get.dart';

import '../../../domain/model/recipe.dart';
import '../../../domain/model/usermodel.dart';
import '../../login/controllers/login.controller.dart';

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
    nutrition: Nutrition(calories: 650, serving: 1, prepTime: 60),
  ).obs;

  @override
  void onInit() {
    super.onInit();
    recipe.value = Get.arguments;
  }

  RxMap<int, bool> favoriteRecipes = <int, bool>{}.obs;
  void toggleFavoriteStatus(Recipe recipe) {
    var recipeId = int.parse(recipe.id);
    bool isFavorite = favoriteRecipes[recipeId] ?? false;
    favoriteRecipes[recipeId] = !isFavorite;
    favoriteRecipes.refresh();
  }

  // bool isRecipeFavorite(Recipe recipe) {
  //   var recipeId =
  //       int.parse(recipe.id); // Convert to int if recipe.id is a String
  //   return favoriteRecipes[recipeId] ?? false;
  // }
  final LoginController loginController = Get.find<LoginController>();
  Future<bool> isRecipeFavorite(Recipe recipe) async {
    try {
      UserModel currentUser = await loginController.fetchCurrentUser();
      return currentUser.favoriteRecipes.any((r) => r.id == recipe.id);
    } catch (e) {
      // Handle error or return false if the user is not found
      return false;
    }
  }
}
