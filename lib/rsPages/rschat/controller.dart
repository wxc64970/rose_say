import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rose_say/rsCommon/index.dart';

import 'widgets/rs_c_con.dart';
import 'widgets/rs_f_c.dart';

class RschatController extends GetxController
    with GetSingleTickerProviderStateMixin, RouteAware {
  RschatController();

  final List<String> tabs = [RSTextData.chatted, RSTextData.liked];
  late TabController tabController;
  // 记录每个选项卡的数据加载状态
  final List<RxBool> isDataLoaded = [];
  final List<RxBool> isLoading = [];

  final chatCtr = Get.put(ConversationController());
  final likedCtr = Get.put(FollowController());

  // 当前选中索引
  final currentIndex = 0.obs;

  _initData() {
    for (int i = 0; i < tabs.length; i++) {
      isDataLoaded.add(false.obs);
      isLoading.add(false.obs);
      // list.add(<ChaterModel>[].obs);
    }

    chatCtr.onRefresh();

    tabController = TabController(
      length: tabs.length,
      vsync: this,
      animationDuration: const Duration(milliseconds: 200),
    );
    tabController.addListener(() {
      final currentIndex = tabController.index;
      // 避免重复触发（Tab 切换动画过程中索引会变化）
      if (tabController.indexIsChanging) return;

      if (currentIndex == 1) {
        likedCtr.onRefresh();
      }
    });

    update(["chat"]);
  }

  // 当页面重新显示时调用（从其他页面返回）
  @override
  void didPopNext() {
    refreshCurrentTabList();
  }

  void refreshCurrentTabList() {
    chatCtr.onRefresh();
    likedCtr.onRefresh();
  }

  @override
  void onInit() {
    super.onInit();
    _initData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
}
