import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:recepi_application/presentation/search/widget/edamin_details.dart';
import 'package:recepi_application/presentation/search/widget/search_recepi_card.dart';

import '../../../domain/model/edaman.dart';
import '../controllers/search.controller.dart';

class LoadedsearchRecipesWidget extends StatelessWidget {
  final List<EdamamRecipeModel> recipes;
  final BoxConstraints constraints;
  const LoadedsearchRecipesWidget({
    Key? key,
    required this.recipes,
    required this.constraints,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SearchrecepiController controller =
        Get.find<SearchrecepiController>();
    return Obx(() {
      return ListView.builder(
          itemCount: controller.searchResults.length,
          itemBuilder: (context, index) {
            final recipe = controller.searchResults[index];
            return GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EdamamRecipeDetail(recipeModel: recipe),
                ),
              ),
              child: SearchRecipeCardWidget(
                      constraints: constraints, recipe: recipe)
                  .animate()
                  .slideX(
                      duration: 200.ms,
                      delay: 0.ms,
                      begin: 1,
                      end: 0,
                      curve: Curves.easeInOutSine),
            );
          });
    });
  }
}
