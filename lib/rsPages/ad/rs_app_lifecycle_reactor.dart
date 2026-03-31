import 'dart:async';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:rose_say/rsCommon/index.dart';

class AppLifecycleReactor {
  bool _isShowingAd = false;

  void listenToAppStateChanges() {
    AppStateEventNotifier.startListening();
    AppStateEventNotifier.appStateStream.forEach((state) {
      log.d('AppLifecycleReactor: AppState changed to $state');
      if (state == AppState.foreground) {
        _showAdIfAvailable();
        RSAppLogEvent().logSessionEvent();
      }
    });
  }

  Future<void> _showAdIfAvailable() async {
    // 避免重复展示广告
    if (_isShowingAd) {
      return;
    }

    _isShowingAd = true;
    try {
      // await MyAd().showOpenAd();
    } finally {
      _isShowingAd = false;
    }
  }
}
