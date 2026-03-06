import 'package:get/get.dart';

import 'controller.dart';

class RsgemsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RsgemsController>(() => RsgemsController());
  }
}
