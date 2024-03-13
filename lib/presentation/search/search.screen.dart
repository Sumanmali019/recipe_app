import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:recepi_application/presentation/search/controllers/search.controller.dart';
import 'package:recepi_application/presentation/search/widget/search_loaded.dart';

import '../home/home_widget/home_saffold.dart';

class SearchScreen extends GetView<SearchrecepiController> {
  const SearchScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AnnotatedScaffold(
        child: LayoutBuilder(builder: (context, constraints) {
      final avatarWaitingDuration = 400.ms;
      final nameDelayDuration =
          avatarWaitingDuration + avatarWaitingDuration + 200.ms;
      final namePlayDuration = 800.ms;
      nameDelayDuration + namePlayDuration - 400.ms;

      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: controller.searchController,
              decoration: const InputDecoration(
                labelText: 'Search for a recipe',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
              onFieldSubmitted: (_) => controller.searchRecipes(),
            ),
          ),
          ElevatedButton(
            onPressed: controller.searchRecipes,
            child: const Text('Search'),
          ),
          Expanded(child: Obx(() {
            if (controller.searchResults.isEmpty) {
              return const Center(
                child: Text('No results found'),
              );
            } else {
              return LoadedsearchRecipesWidget(
                  recipes: controller.searchrecipes, constraints: constraints);
            }
          })),
        ],
      );
    }));
  }
}
