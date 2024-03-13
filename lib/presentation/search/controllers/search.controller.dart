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
  var isLoading = false.obs;

  var lastSearchQuery = ''.obs;

  var searchrecipes = RxList<EdamamRecipeModel>();

  void searchRecipes(String query) async {
    lastSearchQuery.value = query;
    isLoading.value = true;
    if (query.isNotEmpty) {
      final results = await apiService.searchRecipes(query);
      searchResults.value = results.isNotEmpty
          ? results.map((recipe) => EdamamRecipeModel.fromMap(recipe)).toList()
          : [];
    } else {
      searchResults.clear();
    }
    isLoading.value = false;
  }
}
