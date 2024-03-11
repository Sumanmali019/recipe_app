import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:recepi_application/domain/model/recipe.dart';
import 'package:recepi_application/presentation/catgeory/widgets/catgeoy_list_widget.dart';

class HomeController extends GetxController {
  var allRecipes = RxList<Recipe>(); // This will hold all the recipes.
  var recipes =
      RxList<Recipe>(); // This will hold the filtered recipes for display.
  var isLoading = true.obs;
  var errorMessage = ''.obs;
  var showRecipeList = true.obs;
  var currentCategory = 'All'.obs;
  RxBool isSelected = false.obs;

  final List<FoodCategoryWidget> categories = [
    const FoodCategoryWidget(icon: "🤤", name: "All"),
    const FoodCategoryWidget(
      icon: "🔥",
      name: "Popular",
    ),
    const FoodCategoryWidget(icon: "🥦", name: "Healthy"),
    const FoodCategoryWidget(icon: "🍲", name: "Vegetarian"),
    const FoodCategoryWidget(icon: "🍿", name: "Diet"),
  ].obs;

  @override
  void onInit() {
    super.onInit();
    Future.delayed(4550.ms, () => changeListVisibility());
    loadRecipes();
  }

  void changeListVisibility() {
    showRecipeList(true);
  }

  void setCurrentCategory(String category) {
    currentCategory(category);
    if (category == 'All') {
      recipes.assignAll(allRecipes);
    } else {
      var filteredRecipes = allRecipes
          .where((recipe) =>
              recipe.category.toLowerCase() == category.toLowerCase())
          .toList();
      recipes.assignAll(filteredRecipes);
    }
  }

  Future<void> loadRecipes({String filePath = "assets/recipes.json"}) async {
    try {
      isLoading(true);
      final fetchedRecipes = await fetchRecipes(filePath);
      allRecipes.assignAll(fetchedRecipes);
      recipes.assignAll(fetchedRecipes); // Initially display all recipes.
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<List<Recipe>> fetchRecipes(String filePath) async {
    try {
      final response = await rootBundle.loadString(filePath);
      final data = jsonDecode(response) as List;
      return data.map((e) => Recipe.fromJson(e)).toList();
    } catch (e) {
      throw Exception('Failed to load recipes: $e');
    }
  }
}
