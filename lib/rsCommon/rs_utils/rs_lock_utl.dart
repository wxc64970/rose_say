import 'dart:io';

import 'package:get/get_connect/connect.dart';
import 'package:rose_say/rsCommon/index.dart';

class RSLockUtils {
  static Future request({bool isFisrt = false}) async {
    if (RSAppConstants.isDebug) {
      // 开发
      RS.storage.setIsRSB(true);
    } else {
      try {
        // 并行执行平台请求和 RometeBook 检查
        final results = await Future.wait([
          // 任务1: 执行平台特定请求
          Platform.isIOS ? _requestIos() : _requestAnd(),
          // 任务2: 执行 SAOtherBlock 检查
          RSOtherBlock.check(),
        ]);

        final isSAB = RS.storage.isRSB;
        final (success, reason) = results[1] as (bool, String);

        // clock b
        if (isSAB) {
          log.d('RometeBook: $success, reason = $reason');
          final allPass = isSAB && success;
          RS.storage.setIsRSB(allPass);
          RSlogEvent(
            allPass ? "Z7aE2sX_B" : "N3mW6rC_A",
            parameters: {"clk_status": "clk_b", "firebase_status": reason},
          );
        } else {
          // clock a
          RSlogEvent("N3mW6rC_A", parameters: {"clk_status": "clk_a"});
        }
      } catch (e) {
        log.e('---block---Error in requesClk: $e');
        RSlogEvent("N3mW6rC_A", parameters: {"clk_status": "request_catch"});
      }
    }
  }

  // iOS 点击事件请求
  static Future<void> _requestIos() async {
    try {
      final deviceId = await RS.storage.getDeviceId(isOrigin: true);
      final version = await RSInfoUtils.version();
      final idfa = await RSInfoUtils.getIdfa();
      final idfv = await RSInfoUtils.getIdfv();

      final Map<String, dynamic> body = {
        'monsanto': RSAppConstants.bundleIdIOS,
        'chaplin': 'zip',
        'adrian': version,
        'shirley': deviceId,
        'otis': DateTime.now().millisecondsSinceEpoch,
        'acanthus': idfa,
        'sedan': idfv,
      };

      final client = GetConnect(timeout: const Duration(seconds: 60));

      final response = await client.post(
        'https://aplomb.rosesayapp.com/ellipse/syzygy/bicep',
        body,
      );
      log.i('Response: $body\n ${response.body}');

      var clkStatus = false;
      if (response.isOk && response.body == 'fatten') {
        clkStatus = true;
      }
      await RS.storage.setBool(RSAppConstants.keyClkStatus, clkStatus);
    } catch (e) {
      log.e('Error in _requestIosClk: $e');
    }
  }

  static Future<void> _requestAnd() async {}
}
