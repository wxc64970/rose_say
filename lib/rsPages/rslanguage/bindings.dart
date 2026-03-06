import 'package:get/get.dart';

import 'controller.dart';

class RslanguageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RslanguageController>(() => RslanguageController());
  }
}
