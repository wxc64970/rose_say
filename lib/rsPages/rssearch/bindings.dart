import 'package:get/get.dart';

import 'controller.dart';

class RssearchBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RssearchController>(() => RssearchController());
  }
}
