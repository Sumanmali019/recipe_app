import 'package:get/get.dart';

import '../../../../presentation/catgeory/controllers/catgeory.controller.dart';

class CatgeoryControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CatgeoryController>(
      () => CatgeoryController(),
    );
  }
}
