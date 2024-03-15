import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../../domain/model/usermodel.dart';
import '../../../domain/model/recipe.dart';

class UserController extends GetxController {
  Rx<UserModel> user;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  UserController({required UserModel initialUser}) : user = Rx<UserModel>(initialUser);

  void addFavoriteRecipe(Recipe recipe) {
    if (!user.value.favoriteRecipes.any((r) => r.id == recipe.id)) {
      user.value.favoriteRecipes.add(recipe);
      user.refresh(); // Notify listeners to update the UI
      _updateUserFavorites();
    }
  }

  void removeFavoriteRecipe(Recipe recipe) {
    user.value.favoriteRecipes.removeWhere((r) => r.id == recipe.id);
    user.refresh(); // Notify listeners to update the UI
    _updateUserFavorites();
  }

  bool isFavoriteRecipe(Recipe recipe) {
    return user.value.favoriteRecipes.any((r) => r.id == recipe.id);
  }

  Future<void> _updateUserFavorites() async {
    try {
      await _firestore.collection('users').doc(user.value.id).update({
        'favoriteRecipes': user.value.favoriteRecipes.map((recipe) => recipe.toJson()).toList(),
      });
    } catch (e) {
      print("Error updating user favorites: $e");
    }
  }
}
