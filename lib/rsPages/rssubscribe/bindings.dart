import 'package:get/get.dart';

import 'controller.dart';

class RssubscribeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RssubscribeController>(() => RssubscribeController());
  }
}
