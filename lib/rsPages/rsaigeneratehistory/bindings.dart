import 'package:get/get.dart';

import 'controller.dart';

class RsaigeneratehistoryBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RsaigeneratehistoryController>(
      () => RsaigeneratehistoryController(),
    );
  }
}
