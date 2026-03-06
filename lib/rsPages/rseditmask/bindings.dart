import 'package:get/get.dart';

import 'controller.dart';

class RseditmaskBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RseditmaskController>(() => RseditmaskController());
  }
}
