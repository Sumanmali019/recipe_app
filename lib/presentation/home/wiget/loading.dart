import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:recepi_application/domain/model/recipe.dart';
import 'package:recepi_application/presentation/home/wiget/recepi_card.dart';

class LoadedRecipesWidget extends StatelessWidget {
  final List<Recipe> recipes;
  final BoxConstraints constraints;
  const LoadedRecipesWidget({
    Key? key,
    required this.recipes,
    required this.constraints,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              print("clicked");
              Navigator.of(context).pushNamed(
                '/catgeory',
                arguments: recipes[index],
              );
            },
            child: RecipeCardWidget(
                    constraints: constraints, recipe: recipes[index])
                .animate()
                .slideX(
                    duration: 200.ms,
                    delay: 0.ms,
                    begin: 1,
                    end: 0,
                    curve: Curves.easeInOutSine),
          );
        });
  }
}
