import 'package:get/get.dart';

import 'controller.dart';

class RsundrBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RsundrController>(() => RsundrController());
  }
}
