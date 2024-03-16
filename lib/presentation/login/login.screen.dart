import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:recepi_application/const_assets/theme/app_colors.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'controllers/login.controller.dart'; // Adjust the import path as necessary.

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1F1F1F),
      appBar: AppBar(
        leading: controller.user == null
            ? IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Get.back(),
              )
            : null,
        title: Obx(() => Text(controller.user == null ? 'Login' : 'Welcome ',
            style: const TextStyle(color: Colors.white))),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Obx(() => controller.user != null
              ? IconButton(
                  icon: Icon(Icons.logout, color: Colors.red.shade500),
                  onPressed: () => controller.signOut(),
                )
              : const SizedBox.shrink()),
        ],
      ),
      body: Obx(() {
        if (controller.user == null) {
          return buildLoginView(context);
        } else {
          return buildProfileView(context, controller);
        }
      }),
    );
  }

  Widget buildLoginView(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              "assets/images/login.json",
              width: MediaQuery.of(context).size.width * 0.75,
              animate: true,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 50),
            SizedBox(
              width: double.infinity,
              height: 45,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 70),
                child: SignInButton(
                  Buttons.google,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 18, // Shadow elevation
                  text: "Sign in with Google",
                  onPressed: () => controller.signInWithGoogle(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProfileView(BuildContext context, LoginController controller) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 24),
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(controller.user?.photoURL ?? ''),
            backgroundColor: Colors.transparent,
          ),
          const SizedBox(height: 20),
          Text(controller.user?.displayName ?? 'Not available',
              style: const TextStyle(fontSize: 24, color: Colors.white)),
          const SizedBox(height: 10),
          Text(controller.user?.email ?? 'Not available',
              style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 20),
          buildFavoriteRecipesTitle(context),
          const SizedBox(height: 10),
          buildFavoriteRecipesList(context, controller),
        ],
      ),
    );
  }

  Widget buildFavoriteRecipesTitle(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          'Your Favorite Recipes',
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: AppColors.onBoardingButtonColor),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }

  Widget buildFavoriteRecipesList(
      BuildContext context, LoginController controller) {
    return Obx(() {
      if (controller.isLoading.isTrue) {
        return const Center(child: CircularProgressIndicator());
      }
      if (controller.favoriteRecipes.isEmpty) {
        return const Padding(
          padding: EdgeInsets.only(top: 50),
          child: Text(
            'No favorite recipes yet',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        );
      }
      return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: controller.favoriteRecipes.length,
        itemBuilder: (context, index) {
          final recipe = controller.favoriteRecipes[index];
          return Card(
            color: Colors.white,
            child: ListTile(
              title: Text(recipe.name,
                  style: const TextStyle(color: Color(0xFF1F1F1F))),
              onTap: () => Get.toNamed('/catgeory', arguments: recipe),
            ),
          );
        },
      );
    });
  }
}
