// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usermodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      isPremium: json['isPremium'] as bool,
      favoriteRecipes: (json['favoriteRecipes'] as List<dynamic>)
          .map((e) => Recipe.fromJson(e as Map<String, dynamic>))
          .toList(),
      recipesRead: (json['recipesRead'] as List<dynamic>)
          .map((e) => Recipe.fromJson(e as Map<String, dynamic>))
          .toList(),
      recipesClickedCount: json['recipesClickedCount'] as int,
      isVegetarian: json['isVegetarian'] as bool,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'favoriteRecipes':
          instance.favoriteRecipes.map((e) => e.toJson()).toList(),
      'recipesRead': instance.recipesRead.map((e) => e.toJson()).toList(),
      'recipesClickedCount': instance.recipesClickedCount,
      'isVegetarian': instance.isVegetarian,
      'isPremium': instance.isPremium,
    };
