import 'package:get/get.dart';
import 'package:rose_say/rsCommon/index.dart';

import 'index.dart';

class RsaiskuController extends GetxController {
  RsaiskuController();

  final state = RsaiskuState();

  final aiSkuList = <RSSkModel>[].obs;

  Rx<RSSkModel> selectedModel = RSSkModel().obs;
  var isVideo = false;
  late ConsumeFrom from;

  /// 在 widget 内存中分配后立即调用。
  @override
  void onInit() {
    super.onInit();
    var arg = Get.arguments;
    if (arg != null && arg is ConsumeFrom) {
      from = arg;
    }
    isVideo = from == ConsumeFrom.img2v;
    RSlogEvent(isVideo ? 't_buyvideos' : 't_buyphotos');
    _loadData();

    ever(RSPayUtils().iapEvent, (event) async {
      if (event?.$1 == IAPEvent.goldSucc && event?.$2 != null) {
        await RS.login.fetchUserInfo();
        Get.back(result: true);
      }
    });
  }

  Future<void> _loadData() async {
    RSLoading.show();
    await RSPayUtils().query();

    var products = RSPayUtils().consumableList;

    if (!isVideo) {
      aiSkuList.assignAll(
        products.where((e) => e.createImg != null && e.createImg! > 0).toList()
          ..sort((a, b) => (a.orderNum ?? 0).compareTo(b.orderNum ?? 0)),
      );
    } else {
      aiSkuList.assignAll(
        products
            .where((e) => e.createVideo != null && e.createVideo! > 0)
            .toList()
          ..sort((a, b) => (a.orderNum ?? 0).compareTo(b.orderNum ?? 0)),
      );
    }

    selectedModel.value = aiSkuList.firstWhereOrNull(
      (e) => e.id == aiSkuList.last.id,
    )!;
    RSLoading.close();
    update();
  }

  String photoText(int count) {
    if (count == 1) {
      return 'photo_one'.tr;
    } else {
      return 'photo_count'.trParams({'count': count.toString()});
    }
  }

  String videoText(int count) {
    if (count == 1) {
      return 'video_one'.tr;
    } else {
      return 'video_count'.trParams({'count': count.toString()});
    }
  }

  void buy() async {
    await RSPayUtils().buy(selectedModel.value, consFrom: from);
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
