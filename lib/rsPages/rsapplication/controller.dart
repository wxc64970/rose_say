import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rose_say/rsCommon/index.dart';

import 'state.dart';

class RsapplicationController extends GetxController
    with WidgetsBindingObserver {
  RsapplicationController();

  final state = RsapplicationState();

  // tab 页标题
  late final List<String> tabTitles;

  // 页控制器
  late final PageController pageController;

  // 底部导航项目
  late final List<BottomNavigationBarItem> bottomTabs;

  /// 事件

  // tab栏动画
  void handleNavBarTap(int index) {
    // pageController.animateToPage(index, duration: const Duration(milliseconds: 200), curve: Curves.ease);
    pageController.jumpToPage(index);
    RS.login.fetchUserInfo();
  }

  // tab栏页码切换
  void handlePageChanged(int page) {
    state.page = page;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.paused:
        RS.audio.stopAll();
        break;
      case AppLifecycleState.resumed:
        RSAppLogEvent().logSessionEvent();
        break;
      default:
        break;
    }
  }

  /// 在 widget 内存中分配后立即调用。
  @override
  void onInit() {
    super.onInit();
    // 注册监听器
    WidgetsBinding.instance.addObserver(this);

    bottomTabs = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Image.asset(
          "assets/tabbar/rs_aiphoto_inactive.png",
          width: 48.w,
          fit: BoxFit.contain,
        ),
        activeIcon: Image.asset(
          "assets/tabbar/rs_aiphoto_active.png",
          width: 48.w,
          fit: BoxFit.contain,
        ),
        label: 'AI Photo',
      ),
      BottomNavigationBarItem(
        icon: Image.asset(
          "assets/tabbar/rs_home_inactive.png",
          width: 48.w,
          fit: BoxFit.contain,
        ),
        activeIcon: Image.asset(
          "assets/tabbar/rs_home_active.png",
          width: 48.w,
          fit: BoxFit.contain,
        ),
        label: 'Home',
      ),

      BottomNavigationBarItem(
        icon: Image.asset(
          "assets/tabbar/rs_chat_inactive.png",
          width: 48.w,
          fit: BoxFit.contain,
        ),
        activeIcon: Image.asset(
          "assets/tabbar/rs_chat_active.png",
          width: 48.w,
          fit: BoxFit.contain,
        ),
        label: 'Chat',
      ),
      if (RS.storage.isRSB)
        BottomNavigationBarItem(
          icon: Image.asset(
            "assets/tabbar/rs_explore_inactive.png",
            width: 48.w,
            fit: BoxFit.contain,
          ),
          activeIcon: Image.asset(
            "assets/tabbar/rs_explore_active.png",
            width: 48.w,
            fit: BoxFit.contain,
          ),
          label: 'Explore',
        ),

      BottomNavigationBarItem(
        icon: Image.asset(
          "assets/tabbar/rs_me_inactive.png",
          width: 48.w,
          fit: BoxFit.contain,
        ),
        activeIcon: Image.asset(
          "assets/tabbar/rs_me_active.png",
          width: 48.w,
          fit: BoxFit.contain,
        ),
        label: 'Me',
      ),
    ];
    if (Get.arguments != null) {
      state.page = Get.arguments['page'];
    }
    pageController = PageController(initialPage: state.page);
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
