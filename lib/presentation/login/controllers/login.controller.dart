import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../domain/model/recipe.dart';
import '../../../domain/model/usermodel.dart';

class LoginController extends GetxController {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var userProfileImageUrl = ''.obs;
  var isLoading = false.obs;

  final Rx<User?> _user = Rx<User?>(null);

  User? get user => _user.value;

  RxList<Recipe> favoriteRecipes = RxList<Recipe>();

  @override
  void onInit() {
    super.onInit();
    _user.bindStream(FirebaseAuth.instance.authStateChanges());
    ever(_user, handleAuthChanged);
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        userProfileImageUrl.value = user.photoURL ?? '';
        _initializeUserInFirestore(user);
      } else {
        userProfileImageUrl.value = '';
      }
    });
  }

  void handleAuthChanged(User? user) async {
    if (user != null) {
      await fetchFavoriteRecipes();
    } else {
      favoriteRecipes.clear();
    }
  }

  Future<void> fetchFavoriteRecipes() async {
    if (user == null) return;
    isLoading.value = true;

    final userDoc = _firestore.collection('users').doc(user!.uid);
    final snapshot = await userDoc.get();

    if (snapshot.exists) {
      UserModel userModel =
          UserModel.fromJson(snapshot.data() as Map<String, dynamic>);
      favoriteRecipes.value = userModel.favoriteRecipes;
    }
    isLoading.value = false;
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        await FirebaseAuth.instance.signInWithCredential(credential);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> signOut() async {
    await googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();
    favoriteRecipes.clear();
  }

  void setUserProfileImage(String url) {
    userProfileImageUrl.value = url;
  }

  Future<void> _initializeUserInFirestore(User user) async {
    final userDoc = _firestore.collection('users').doc(user.uid);
    final snapshot = await userDoc.get();

    if (!snapshot.exists) {
      final newUser = UserModel(
        id: user.uid,
        name: user.displayName ?? '',
        email: user.email ?? '',
        favoriteRecipes: [],
        recipesRead: [],
        recipesClickedCount: 0,
        isPremium: false,
        isVegetarian: false,
        // lastOpenOrLogin: DateTime.now(),
      );
      await userDoc.set(newUser.toJson());
    } else {
      // Existing user: fetch and set favorite recipes
      UserModel userModel =
          UserModel.fromJson(snapshot.data() as Map<String, dynamic>);
      favoriteRecipeIds.clear();
      favoriteRecipeIds.addAll(userModel.favoriteRecipes.map((r) => r.id));
      await userDoc.update({'lastOpen': DateTime.now()});
    }
  }

  Future<UserModel> fetchCurrentUser() async {
    User? firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser.uid)
          .get();
      if (userDoc.exists) {
        return UserModel.fromJson(userDoc.data() as Map<String, dynamic>);
      } else {
        throw Exception('User not found in Firestore');
      }
    } else {
      throw Exception('No user logged in');
    }
  }

  Future<void> addFavoriteRecipe(Recipe recipe) async {
    User? firebaseUser = FirebaseAuth.instance.currentUser;
    if (!favoriteRecipeIds.contains(recipe.id)) {
      favoriteRecipeIds.add(recipe.id);
      if (firebaseUser != null) {
        DocumentReference userDocRef =
            _firestore.collection('users').doc(firebaseUser.uid);
        await _firestore.runTransaction((transaction) async {
          DocumentSnapshot snapshot = await transaction.get(userDocRef);
          if (snapshot.exists) {
            UserModel user =
                UserModel.fromJson(snapshot.data() as Map<String, dynamic>);
            if (!user.favoriteRecipes.any((r) => r.id == recipe.id)) {
              user.favoriteRecipes.add(recipe);
              transaction.update(userDocRef, {
                'favoriteRecipes':
                    user.favoriteRecipes.map((r) => r.toJson()).toList()
              });
              favoriteRecipes.add(recipe);
            }
          }
        });
      }
    }
  }

  Future<void> removeFavoriteRecipe(Recipe recipe) async {
    User? firebaseUser = FirebaseAuth.instance.currentUser;

    if (firebaseUser != null) {
      DocumentReference userDocRef =
          _firestore.collection('users').doc(firebaseUser.uid);
      await _firestore.runTransaction((transaction) async {
        DocumentSnapshot snapshot = await transaction.get(userDocRef);
        if (snapshot.exists) {
          UserModel user =
              UserModel.fromJson(snapshot.data() as Map<String, dynamic>);
          user.favoriteRecipes.removeWhere((r) => r.id == recipe.id);
          transaction.update(userDocRef, {
            'favoriteRecipes':
                user.favoriteRecipes.map((r) => r.toJson()).toList()
          });
        }
        favoriteRecipeIds.remove(recipe.id);
        favoriteRecipes.removeWhere((r) => r.id == recipe.id);
      });
    }
  }

  RxList<String> favoriteRecipeIds = RxList<String>();

  bool isRecipeFavorite(Recipe recipe) {
    return favoriteRecipeIds.contains(recipe.id);
  }

  // Future<void> fetchFavoriteRecipes() async {
  //   if (user == null) return;

  //   final userDoc = _firestore.collection('users').doc(user!.uid);
  //   final snapshot = await userDoc.get();

  //   if (snapshot.exists) {
  //     UserModel userModel =
  //         UserModel.fromJson(snapshot.data() as Map<String, dynamic>);
  //     List<Recipe> recipes = [];

  //     for (var recipeId in userModel.favoriteRecipes) {
  //       DocumentSnapshot recipeDoc = await _firestore
  //           .collection('recipes')
  //           .doc(recipeId as String?)
  //           .get();
  //       if (recipeDoc.exists) {
  //         recipes
  //             .add(Recipe.fromJson(recipeDoc.data() as Map<String, dynamic>));
  //       }
  //     }

  //     favoriteRecipes.value = recipes;
  //   }
  // }

  Future<void> incrementRecipesClickedCount() async {
    User? firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      DocumentReference userDocRef =
          _firestore.collection('users').doc(firebaseUser.uid);
      await _firestore.runTransaction((transaction) async {
        DocumentSnapshot snapshot = await transaction.get(userDocRef);
        if (snapshot.exists) {
          UserModel user =
              UserModel.fromJson(snapshot.data() as Map<String, dynamic>);
          int newCount = user.recipesClickedCount + 1;
          transaction.update(userDocRef, {'recipesClickedCount': newCount});
        }
      });
    }
  }

  bool isLoggedIn() {
    return user != null;
  }
}
