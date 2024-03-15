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
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        backgroundColor: AppColors.onBoardingButtonColor,
        title: Obx(() {
          return Text(
            controller.user == null ? 'Login' : 'Profile',
            style: const TextStyle(color: Colors.black),
          );
        }),
        centerTitle: true,
        actions: [
          Obx(() => controller.user != null
              ? IconButton(
                  color: Colors.red,
                  iconSize: 30,
                  icon: const Icon(Icons.logout),
                  onPressed: () {
                    controller.signOut();
                  },
                )
              : const SizedBox.shrink()),
        ],
      ),
      body: Center(
        child: Obx(() {
          if (controller.user == null) {
            return Stack(
              children: [
                Column(
                  children: [
                    Container(
                      width: Get.width,
                      height: Get.height * 0.07,
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(255, 222, 89, 1),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(34),
                          bottomRight: Radius.circular(45),
                        ),
                      ),
                    ),
                    Lottie.asset("assets/images/login.json",
                        animate: true,
                        reverse: true,
                        repeat: true,
                        fit: BoxFit.fitHeight),
                    const SizedBox(
                      height: 35,
                    ),
                    SizedBox(
                      height: 55,
                      width: 360,
                      child: SignInButton(
                        Buttons.google,
                        shape: ShapeBorder.lerp(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0)),
                            const CircleBorder(),
                            2),
                        elevation: 12,
                        onPressed: () {
                          controller.signInWithGoogle();
                        },
                      ),
                    ),
                  ],
                )
              ],
            );
          } else {
            final user = controller.user;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(user?.photoURL ?? ''),
                  backgroundColor: Colors.transparent,
                ),
                const SizedBox(height: 20),
                Text(
                  'Name: ${user?.displayName ?? 'Not available'}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 10),
                Text(
                  'Email: ${user?.email ?? 'Not available'}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 10),
              ],
            );
          }
        }),
      ),
    );
  }
}
