import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recepi_application/domain/core/interfaces/edamin_service.dart';

import '../../../domain/model/edaman.dart';

class SearchrecepiController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  final EdamamApiService apiService =
      EdamamApiService('bb937e3229ccafaaba075384dd76260e');
  var searchResults = <EdamamRecipeModel>[].obs;
  var errorMessage = ''.obs;
  var isLoading = true.obs;

  var searchrecipes = RxList<EdamamRecipeModel>();

  void searchRecipes() async {
    final query = searchController.text;
    if (query.isNotEmpty) {
      final results = await apiService.searchRecipes(query);
      if (results.isNotEmpty) {
        searchResults.value =
            results.map((recipe) => EdamamRecipeModel.fromMap(recipe)).toList();
      } else {
        searchResults.clear();
      }
    } else {
      searchResults.clear();
    }
  }

  Rx<EdamamRecipeModel> recipe = EdamamRecipeModel(
          title: 'test',
          image: '',
          kcal: 1,
          servings: 1,
          cookingTime: 1,
          ingredients: ['1', '2'],
          url: '')
      .obs;
}
