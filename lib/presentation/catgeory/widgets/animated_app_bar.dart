import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import '../../../domain/model/recipe.dart';
import '../../login/controllers/login.controller.dart';

class AnimatedAppBarWidget extends StatelessWidget {
  final String name;
  final Recipe recipe;
  final Duration appBarPlayTime;
  final Duration appBarDelayTime;

  const AnimatedAppBarWidget({
    Key? key,
    required this.name,
    required this.appBarPlayTime,
    required this.appBarDelayTime,
    required this.recipe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginController loginController = Get.find<LoginController>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios_new,
              size: 22, color: Colors.black),
        ),
        Text(
          name.toUpperCase(),
          textAlign: TextAlign.center,
          style: GoogleFonts.alice(
              color: Colors.black87, fontSize: 16, fontWeight: FontWeight.w900),
          overflow: TextOverflow.clip,
          maxLines: 2,
        ),
        Obx(() {
          bool isFavorite = loginController.isRecipeFavorite(recipe);
          return IconButton(
              onPressed: () async {
                if (loginController.isLoggedIn()) {
                  if (isFavorite) {
                    await loginController.removeFavoriteRecipe(recipe);
                  } else {
                    await loginController.addFavoriteRecipe(recipe);
                  }
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Hey you are not Logged In"),
                        content: const Text(
                            "You must be logged in to favorite a recipe."),
                        actions: <Widget>[
                          TextButton(
                            child: const Text("Login Now"),
                            onPressed: () {
                              Navigator.of(context).pop();
                              Get.toNamed('/login');
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              icon: isFavorite
                  ? Lottie.asset('assets/images/likeed.json',
                      height: 300, repeat: false)
                  : const Icon(Icons.favorite_outline,
                      color: Colors.black, size: 30));
        }),
      ].animate(interval: 200.ms, delay: appBarDelayTime).scaleXY(
          begin: 0, end: 1, duration: appBarPlayTime, curve: Curves.decelerate),
    );
  }
}
