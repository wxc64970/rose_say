import 'package:get/get.dart';

import 'controller.dart';

class RsapplicationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RsapplicationController>(() => RsapplicationController());
  }
}
