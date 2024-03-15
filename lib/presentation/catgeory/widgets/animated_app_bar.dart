import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../../domain/model/recipe.dart';
import '../../login/controllers/login.controller.dart';

class AnimatedAppBarWidget extends StatelessWidget {
  final String name;
  final Recipe recipe; // Assuming you pass the current recipe to the widget
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 22,
            color: Colors.black,
          ),
        ),
        Text(
          name.toUpperCase(),
          textAlign: TextAlign.center,
          style: GoogleFonts.alice(
            color: Colors.black87,
            fontSize: 16,
            fontWeight: FontWeight.w900,
          ),
          overflow: TextOverflow.clip,
          maxLines: 2,
        ),
        IconButton(
          onPressed: () async {
            if (Get.find<LoginController>().isLoggedIn()) {
              bool isFavorite =
                  Get.find<LoginController>().isRecipeFavorite(recipe);
              if (isFavorite) {
                await Get.find<LoginController>().removeFavoriteRecipe(recipe);
              } else {
                await Get.find<LoginController>().addFavoriteRecipe(recipe);
              }
            } else {
              // Show alert dialog
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Not Logged In"),
                    content: const Text(
                        "You must be logged in to favorite a recipe."),
                    actions: <Widget>[
                      TextButton(
                        child: const Text("Login Now"),
                        onPressed: () {
                          Navigator.of(context)
                              .pop(); // Dismiss the alert dialog
                          Get.toNamed('/login'); // Navigate to the login screen
                        },
                      ),
                    ],
                  );
                },
              );
            }
          },
          icon: Obx(() {
            bool isFavorite =
                Get.find<LoginController>().isRecipeFavorite(recipe);
            return Icon(
              isFavorite ? Icons.favorite : Icons.favorite_outline,
              color: isFavorite ? Colors.red : Colors.black,
              size: 25,
            );
          }),
        ),
      ].animate(interval: 200.ms, delay: appBarDelayTime).scaleXY(
          begin: 0, end: 1, duration: appBarPlayTime, curve: Curves.decelerate),
    );
  }
}
