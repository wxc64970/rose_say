import 'package:rose_say/rsCommon/index.dart';

class RSLockUtils {
  static Future request({bool isFisrt = false}) async {
    if (RSAppConstants.isDebug) {
      // 开发
      RS.storage.setIsRSB(false);
    } else {
      RS.storage.setIsRSB(false);
    }
  }
}
