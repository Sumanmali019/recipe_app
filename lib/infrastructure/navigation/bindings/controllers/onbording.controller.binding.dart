import 'package:get/get.dart';

import '../../../../presentation/onbording/controllers/onbording.controller.dart';

class OnbordingControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnbordingController>(
      () => OnbordingController(),
    );
  }
}
