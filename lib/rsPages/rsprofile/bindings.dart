import 'package:get/get.dart';

import 'controller.dart';

class RsprofileBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RsprofileController>(() => RsprofileController());
  }
}
