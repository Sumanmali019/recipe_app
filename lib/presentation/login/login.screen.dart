import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:recepi_application/const_assets/theme/app_colors.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'controllers/login.controller.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        backgroundColor: AppColors.onBoardingButtonColor, 
        title: Obx(() => Text(controller.user == null ? 'Login' : 'Welcome ',
            style: const TextStyle(color: Colors.black))),
        centerTitle: true,
        actions: [
          Obx(() => controller.user != null
              ? IconButton(
                  icon:  Icon(Icons.logout, color: Colors.red.shade500),
                  onPressed: () => controller.signOut(),
                )
              : const SizedBox.shrink()),
        ],
      ),
      body: Obx(() {
        if (controller.user == null) {
          return buildLoginView();
        } else {
          return buildProfileView(context, controller);
        }
      }),
    );
  }

  Widget buildLoginView() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset("assets/images/login.json",
                width: Get.width * 0.6,
                animate: true,
                reverse: true,
                repeat: true,
                fit: BoxFit.fitWidth),
            const SizedBox(height: 50),
            SizedBox(
              height: 55,
              width: 360,
              child: SignInButton(
                Buttons.google,
                text: "Sign in with Google",
                onPressed: () => controller.signInWithGoogle(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProfileView(BuildContext context, LoginController controller) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(controller.user?.photoURL ?? ''),
              backgroundColor: Colors.transparent,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(controller.user?.displayName ?? 'Not available',
                style: const TextStyle(color: Colors.black)),
            const SizedBox(height: 10),
            Text(controller.user?.email ?? 'Not available',
                style: const TextStyle(color: Colors.black)),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Your Favorite Recipes',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(color: Colors.blueAccent),
                textAlign: TextAlign.right,
              ),
            ),
            const SizedBox(height: 10),
            Obx(() => controller.isLoading.isTrue
                ? const Center(child: CircularProgressIndicator())
                : controller.favoriteRecipes.isEmpty
                    ? const Padding(
                        padding: EdgeInsets.only(top: 50.0),
                        child: Text(
                          'No favorite recipes yet',
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      )
                    : ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.favoriteRecipes.length,
                        itemBuilder: (context, index) {
                          final recipe = controller.favoriteRecipes[index];
                          return Card(
                            elevation: 2,
                            child: ListTile(
                              title: Text(recipe.name),
                              onTap: () =>
                                  Get.toNamed('/catgeory', arguments: recipe),
                            ),
                          );
                        },
                      )),
          ],
        ),
      ),
    );
  }
}
