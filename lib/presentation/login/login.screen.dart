import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'controllers/login.controller.dart'; // Adjust the import path as necessary.

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Screen'),
        centerTitle: true,
        actions: [
          // Logout button in the app bar, only shown when the user is logged in
          Obx(() => controller.user != null
              ? IconButton(
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
            // User is not logged in, show the login button
            return SizedBox(
              height: 50,
              width: 300,
              child: SignInButton(
                Buttons.google,
                onPressed: () {
                  controller.signInWithGoogle();
                },
              ),
            );
          } else {
            // User is logged in, show user details
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
