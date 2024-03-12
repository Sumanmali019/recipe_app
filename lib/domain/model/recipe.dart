import 'package:json_annotation/json_annotation.dart';
part 'recipe.g.dart';

@JsonSerializable(explicitToJson: true)
class Recipe {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final List<String> ingredients;
  final String category;
  final List<String> steps;
  final Nutrition nutrition;

  Recipe({
    required this.id,
    required this.category,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.ingredients,
    required this.steps,
    required this.nutrition,
  });
  factory Recipe.fromJson(Map<String, dynamic> json) => _$RecipeFromJson(json);
  Map<String, dynamic> toJson() => _$RecipeToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Nutrition {
  final int calories;
  final int protein;
  final int prepTime;

  Nutrition({
    required this.calories,
    required this.protein,
    required this.prepTime,
  });
  factory Nutrition.fromJson(Map<String, dynamic> json) =>
      _$NutritionFromJson(json);
  Map<String, dynamic> toJson() => _$NutritionToJson(this);
}
