import 'package:get/get.dart';
import 'package:rose_say/rsCommon/index.dart';

import 'index.dart';

class RsundrController extends GetxController {
  RsundrController();

  final state = RsundrState();

  ChaterModel? role;

  /// 在 widget 内存中分配后立即调用。
  @override
  void onInit() {
    super.onInit();
    RSlogEvent('chat_undress_show');
    if (Get.arguments != null) {
      role = Get.arguments;
    }
  }

  /// 在 onInit() 之后调用 1 帧。这是进入的理想场所
  @override
  void onReady() {
    super.onReady();
  }

  /// 在 [onDelete] 方法之前调用。
  @override
  void onClose() {
    super.onClose();
  }

  /// dispose 释放内存
  @override
  void dispose() {
    super.dispose();
  }
}
