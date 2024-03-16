import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:recepi_application/domain/model/recipe.dart';
import 'package:recepi_application/presentation/home/home_widget/catgeoy_list_widget.dart';

import '../../../const_assets/assets.dart';

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
    const FoodCategoryWidget(
      imageUrl: Assets.dish,
      name: "All",
    ),
    const FoodCategoryWidget(
      imageUrl: Assets.dish,
      name: "Popular",
    ),
    const FoodCategoryWidget(
      imageUrl: Assets.dish,
      name: "Healthy",
    ),
    const FoodCategoryWidget(
      imageUrl: Assets.dish,
      name: "Vegetarian",
    ),
    const FoodCategoryWidget(
      imageUrl: Assets.dish,
      name: "Diet",
    ),
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

  Future<void> loadRecipes() async {
    try {
      isLoading(true);
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('recipes').get();
      final fetchedRecipes = querySnapshot.docs
          .map((doc) => Recipe.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      allRecipes.assignAll(fetchedRecipes);
      recipes.assignAll(fetchedRecipes);
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
