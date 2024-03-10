import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:recepi_application/domain/model/recipe.dart';

class HomeController extends GetxController {
  var recipes = RxList<Recipe>();
  var isLoading = true.obs;
  var errorMessage = ''.obs;
  var showRecipeList = true.obs;

  @override
  void onInit() {
    super.onInit();
    Future.delayed(2550.ms, () => changeListVisibility());
    loadRecipes();
  }

  void changeListVisibility() {
    showRecipeList(true);
  }

  Future<void> loadRecipes({String filePath = "assets/recipes.json"}) async {
    try {
      isLoading(true);
      final fetchedRecipes = await fetchRecipes(filePath);
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
