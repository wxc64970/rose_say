import 'package:get/get.dart';

import 'controller.dart';

class RscallBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RscallController>(() => RscallController());
  }
}
