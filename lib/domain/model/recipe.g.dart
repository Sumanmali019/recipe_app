// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Recipe _$RecipeFromJson(Map<String, dynamic> json) => Recipe(
      id: json['id'] as String,
      category: json['category'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      ingredients: (json['ingredients'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      steps: (json['steps'] as List<dynamic>).map((e) => e as String).toList(),
      nutrition: Nutrition.fromJson(json['nutrition'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RecipeToJson(Recipe instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'ingredients': instance.ingredients,
      'category': instance.category,
      'steps': instance.steps,
      'nutrition': instance.nutrition.toJson(),
    };

Nutrition _$NutritionFromJson(Map<String, dynamic> json) => Nutrition(
      calories: json['calories'] as int,
      serving: json['serving'] as int,
      prepTime: json['prepTime'] as int,
    );

Map<String, dynamic> _$NutritionToJson(Nutrition instance) => <String, dynamic>{
      'calories': instance.calories,
      'serving': instance.serving,
      'prepTime': instance.prepTime,
    };
