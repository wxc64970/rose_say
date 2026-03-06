import 'package:get/get.dart';

import 'controller.dart';

class RsmaskBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RsmaskController>(() => RsmaskController());
  }
}
