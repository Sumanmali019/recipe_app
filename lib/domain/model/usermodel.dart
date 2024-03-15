import 'package:json_annotation/json_annotation.dart';
import 'package:recepi_application/domain/model/recipe.dart';

part 'usermodel.g.dart';

@JsonSerializable(explicitToJson: true)
class UserModel {
  final String id;
  final String name;
  final String email;
  List<Recipe> favoriteRecipes;
  List<Recipe> recipesRead;
  int recipesClickedCount;
  bool isVegetarian;
  bool isPremium;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.isPremium,
    required this.favoriteRecipes,
    required this.recipesRead,
    required this.recipesClickedCount,
    required this.isVegetarian,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
