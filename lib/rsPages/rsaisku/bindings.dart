import 'package:get/get.dart';

import 'controller.dart';

class RsaiskuBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RsaiskuController>(() => RsaiskuController());
  }
}
