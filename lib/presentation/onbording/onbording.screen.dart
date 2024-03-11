import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:recepi_application/presentation/onbording/widgets/onboarding_screen_export_widget.dart';

import '../../const_assets/text_const.dart';
import 'controllers/onbording.controller.dart';

class OnbordingScreen extends GetView<OnbordingController> {
  const OnbordingScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    FontThemeClass fontThemeClass = FontThemeClass();
    return Scaffold(
        backgroundColor: const Color.fromRGBO(255, 222, 89, 1),
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(255, 222, 89, 1),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  'Foodज्ञानी',
                  style: fontThemeClass.primaryTitle(context),
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
        ),
        body: const Center(
          child: OnBoardingBodyWidget(),
        ));
  }
}
