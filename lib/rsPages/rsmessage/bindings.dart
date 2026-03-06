import 'package:get/get.dart';

import 'controller.dart';

class RsmessageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RsmessageController>(() => RsmessageController());
  }
}
