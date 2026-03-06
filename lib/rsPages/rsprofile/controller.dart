import 'package:get/get.dart';
import 'package:rose_say/rsCommon/index.dart';
import 'package:rose_say/rsPages/rsdiscover/controller.dart';
import 'package:rose_say/rsPages/rsmessage/controller.dart';

import 'index.dart';
import 'widgets/rs_option_sheet.dart';

class RsprofileController extends GetxController {
  RsprofileController();

  final state = RsprofileState();

  final msgCtr = Get.find<RsmessageController>();

  late ChaterModel role;

  RxList images = <RoleImage>[].obs;
  final List<String> tabs = RS.storage.isRSB
      ? [RSTextData.info, RSTextData.tagsTitle, RSTextData.Moments]
      : [RSTextData.info];

  void onCollect() async {
    final id = role.id;
    if (id == null) {
      return;
    }
    if (state.isLoading) {
      return;
    }
    RSLoading.show();

    if (state.collect) {
      final res = await Api.cancelCollectRole(id);
      if (res) {
        role.collect = false;
        state.collect = false;
        Get.find<RsdiscoverController>().followEvent.value = (
          FollowEvent.unfollow,
          id,
          DateTime.now().millisecondsSinceEpoch,
        );
      }
      state.isLoading = false;
    } else {
      final res = await Api.collectRole(id);
      if (res) {
        role.collect = true;
        state.collect = true;
        Get.find<RsdiscoverController>().followEvent.value = (
          FollowEvent.follow,
          id,
          DateTime.now().millisecondsSinceEpoch,
        );

        if (!RS.storage.isShowGoodCommentDialog) {
          DialogWidget.showPositiveReview();
          RS.storage.setShowGoodCommentDialog(true);
        }
      }
      state.isLoading = false;
    }
    RSLoading.close();
  }

  report() {
    Get.bottomSheet(const RSOptionSheet());
  }

  clearHistory() {
    DialogWidget.alert(
      message: RSTextData.clearHistoryConfirmation,
      cancelText: RSTextData.cancel,
      onConfirm: () async {
        DialogWidget.dismiss();
        await msgCtr.resetConv();
        Get.back();
      },
    );
  }

  void deleteChat() async {
    DialogWidget.alert(
      message: RSTextData.deleteChatConfirmation,
      cancelText: RSTextData.cancel,
      onConfirm: () async {
        DialogWidget.dismiss();
        var res = await msgCtr.deleteConv();
        if (res) {
          Get.until((route) => route.isFirst);
        }
      },
    );
  }

  handleReport() {
    Get.bottomSheet(RSReportSheet(), isScrollControlled: true);
  }

  /// 在 widget 内存中分配后立即调用。
  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments;
    if (arguments != null && arguments is ChaterModel) {
      role = arguments;
    }
    images.value = role.images ?? [];

    state.collect = role.collect ?? false;
    ever(msgCtr.state.roleImagesChaned, (_) {
      images.value = msgCtr.state.role.images ?? [];
    });
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
