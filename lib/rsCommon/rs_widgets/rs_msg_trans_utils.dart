import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:rose_say/rsCommon/index.dart';

class RSMessageTransUtils {
  static final RSMessageTransUtils _instance = RSMessageTransUtils._internal();

  factory RSMessageTransUtils() => _instance;

  RSMessageTransUtils._internal();

  int _clickCount = 0; // 点击次数
  DateTime? _firstClickTime; // 第一次点击的时间

  bool shouldShowDialog() {
    final now = DateTime.now();

    if (_firstClickTime == null ||
        now.difference(_firstClickTime!).inMinutes > 1) {
      // 超过1分钟，重置计数器
      _firstClickTime = now;
      _clickCount = 1;
      return false;
    }

    _clickCount += 1;

    if (_clickCount >= 3) {
      _clickCount = 0; // 重置计数
      return true;
    }

    return false;
  }

  Future<void> handleTranslationClick() async {
    final hasShownDialog = RS.storage.hasShownTranslationDialog;

    if (RSMessageTransUtils().shouldShowDialog() &&
        !hasShownDialog &&
        !RS.login.vipStatus.value) {
      // 弹出提示弹窗
      showTranslationDialog();

      RS.storage.setShownTranslationDialog(true);
    }
  }

  void showTranslationDialog() {
    DialogWidget.alert(
      message: RSTextData.autoTrans,
      confirmText: RSTextData.confirm,
      onConfirm: () {
        SmartDialog.dismiss();
        toVip();
      },
    );
  }

  void toVip() {
    Get.toNamed(RSRouteNames.vip, arguments: VipFrom.trans);
  }
}
