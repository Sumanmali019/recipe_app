// // GENERATED CODE - DO NOT MODIFY BY HAND

// part of 'edaman.dart';

// // **************************************************************************
// // JsonSerializableGenerator
// // **************************************************************************

// EdamamRecipeModel _$EdamamRecipeModelFromJson(Map<String, dynamic> json) =>
//     EdamamRecipeModel(
//       title: json['recipe'] as String?,
//       image: json['image'] as String?,
//       kcal: (json['calories'] as num?)?.toDouble(),
//       servings: (json['yield'] as num?)?.toDouble(),
//       cookingTime: (json['totalTime'] as num?)?.toDouble(),
//       ingredients: (json['ingredients'] as List<dynamic>?)
//           ?.map((e) => e as String)
//           .toList(),
//       url: json['url'] as String?,
//       takedingredients: (json['takedingredients'] as List<dynamic>?)
//           ?.map((e) => e as bool)
//           .toList(),
//     );

// Map<String, dynamic> _$EdamamRecipeModelToJson(EdamamRecipeModel instance) =>
//     <String, dynamic>{
//       'recipe': instance.title,
//       'image': instance.image,
//       'calories': instance.kcal,
//       'yield': instance.servings,
//       'totalTime': instance.cookingTime,
//       'url': instance.url,
//       'takedingredients': instance.takedingredients,
//       'ingredients': instance.ingredients,
//     };
