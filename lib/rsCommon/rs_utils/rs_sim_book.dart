import 'package:flutter/services.dart';
import 'package:rose_say/rsCommon/index.dart';

class RSSimBook {
  static const MethodChannel _channel = MethodChannel('rs_sim_check');

  static Future<bool> rsHasSimCard() async {
    try {
      final bool result = await _channel.invokeMethod('rsHasSimCard');
      return result;
    } on PlatformException catch (e) {
      log.e("Failed to get sim card status: '${e.message}'.");
      return false;
    }
  }
}
