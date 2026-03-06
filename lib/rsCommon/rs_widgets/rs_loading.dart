import 'package:flutter/cupertino.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:rose_say/rsCommon/index.dart';

class RSLoading {
  static Future show() async {
    await SmartDialog.showLoading(msg: "loading...");
  }

  static void showText(String text) {
    SmartDialog.showLoading(msg: text);
  }

  static Future close() async {
    await SmartDialog.dismiss(status: SmartStatus.loading);
  }

  static CupertinoActivityIndicator activityIndicator() {
    return const CupertinoActivityIndicator(
      radius: 16.0, // 指示器大小（默认10.0）
      color: RSAppColors.primaryColor, // 颜色（默认蓝色）
    );
  }
}
