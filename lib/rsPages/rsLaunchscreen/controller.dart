import 'dart:async';

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rose_say/rsCommon/index.dart';

class RslaunchscreenController extends GetxController {
  RslaunchscreenController();

  double _progressValue = 0.0;
  Timer? _progressTimer;
  bool _isProgressComplete = false;

  _initData() {
    EasyRefresh.defaultHeaderBuilder = () =>
        const MaterialHeader(color: Color(0xffABC4E4));
    EasyRefresh.defaultFooterBuilder = () => const ClassicFooter(
      showText: false,
      showMessage: false,
      iconTheme: IconThemeData(color: Color(0xffABC4E4)),
    );
    if (RS.network.isConnected) {
      setup();
    } else {
      RS.network.waitForConnection().then((v) {
        setup();
      });
    }
    update(["rslaunchscreen"]);
  }

  Future<void> setup() async {
    try {
      await RSInfoUtils.getIdfa();

      // 启动进度条动画
      _startProgressAnimation();
      // 检查系统语言和地区
      bool isChineseRegion = RSInfoUtils().isChineseInChina();

      // 检查时区
      bool isChinaTimeZone = await RSInfoUtils.isChinaTimeZone();

      // 检查运营商（异步）
      // bool isChineseOperator = await SAInfoUtils.isChineseCarrier();
      // if (isChineseRegion || isChinaTimeZone) {
      //   return SAToast.show("Abnormal server request,please try again later.");
      // }

      await RS.login.performRegister();

      await Future.wait([
        RSLockUtils.request(isFisrt: true),
        RSPayUtils().query(),
        RSFBUtils.initializeWithRemoteConfig(),
        RS.login.loadAppLangs(),
      ]).timeout(const Duration(seconds: 7));

      await RS.login.fetchUserInfo();

      _completeSetup();
    } catch (e) {
      log.e('Splash setup error: $e');
      _completeSetup();
    }
  }

  void _completeSetup() {
    _progressValue = 1.0;
    _isProgressComplete = true;
    _progressTimer?.cancel();
    _navigateToMain();
  }

  Future<void> _navigateToMain() async {
    Get.offAllNamed(RSRouteNames.application);
  }

  void _startProgressAnimation() {
    _progressTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (_progressValue < 0.5) {
        _progressValue += 0.02;
      } else if (_progressValue < 0.9) {
        _progressValue += 0.01;
      } else if (!_isProgressComplete) {
        _progressValue += 0.001;
      }
    });
  }

  @override
  void onInit() {
    super.onInit();
    _initData();
  }

  @override
  void dispose() {
    _progressTimer?.cancel();
    super.dispose();
  }
}
