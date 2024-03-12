import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  Future<void> loadRecipes() async {
    try {
      isLoading(true);
      // Fetch the collection from Firestore
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('recipes').get();

      // Map the documents to your data model
      final fetchedRecipes = querySnapshot.docs
          .map((doc) => Recipe.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      allRecipes.assignAll(fetchedRecipes);
      recipes.assignAll(fetchedRecipes);
    } catch (e) {
      // ignore: avoid_print
      print(errorMessage(e.toString()));
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
