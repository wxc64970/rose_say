import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:rose_say/rsCommon/index.dart';
import 'package:rose_say/rsPages/ad/rs_ad_type.dart';
import 'package:rose_say/rsPages/ad/rs_my_ad.dart';

import 'rs_auto_call_controller.dart';
import 'widgets/rs_filter_widget.dart';

enum HomeListCategroy { all, realistic, anime, dressUp, video }

enum FollowEvent { follow, unfollow }

// 为枚举添加扩展，提供title和icon等属性
extension HomeListCategoryExtension on HomeListCategroy {
  String get title {
    switch (this) {
      case HomeListCategroy.all:
        return "Popular";
      case HomeListCategroy.realistic:
        return "Realistic";
      case HomeListCategroy.anime:
        return "Anime";
      case HomeListCategroy.dressUp:
        return "Dress Up";
      case HomeListCategroy.video:
        return "Video";
    }
  }

  int get index => HomeListCategroy.values.indexOf(this);
}

class RsdiscoverController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RsdiscoverController();

  final EasyRefreshController refreshCtr = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );

  var categroyList = <HomeListCategroy>[].obs;
  var categroy = HomeListCategroy.all.obs;

  String? rendStyl;
  bool? videoChat;
  bool? genVideo;
  bool? genImg;
  bool? changeClothing;
  int page = 1;
  int size = 10;
  var list = <RxList<ChaterModel>>[];
  List<int> tagIds = [];

  Rx<EmptyType?> type = Rx<EmptyType?>(null);

  List<bool> isNoMoreData = [];

  // 标签
  List<RSTagsModel> roleTags = [];
  var selectTags = <TagModel>{}.obs;
  var cjSelectTags = <TagModel>{}.obs;
  Rx<(Set<TagModel>, int)> filterEvent = (<TagModel>{}, 0).obs;

  // 关注

  Rx<(FollowEvent, String, int)> followEvent = (FollowEvent.follow, '', 0).obs;

  late TabController tabController;

  // 记录每个选项卡的数据加载状态
  final List<RxBool> isDataLoaded = [];
  final List<RxBool> isLoading = [];

  // 当前选中索引
  final currentIndex = 0.obs;

  //筛选
  Rx<RSTagsModel?> selectedType = RSTagsModel().obs;

  NativeAd? nativeAd;

  @override
  void onInit() {
    super.onInit();
    // 初始化标签数据
    _initData();
    //加载广告
    _loadAd();
    Get.put(RSAutoCallController());
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    ever(RS.login.vipStatus, (_) {
      if (RS.login.vipStatus.value) {
        nativeAd?.dispose();
        nativeAd = null;
        update();
      }
    });
  }

  Future<void> _loadAd() async {
    try {
      final success = await MyAd().loadNativeAd(
        placement: PlacementType.homelist,
      );
      if (success) {
        nativeAd = MyAd().nativeAd;
        update();
      }
    } catch (e) {
      log.e('[ad] native load error: $e');
    }
  }

  // 初始化标签数据
  Future<void> _initData() async {
    if (RS.network.isConnected) {
      setupAndJump();
    } else {
      RS.network.waitForConnection().then((v) {
        if (v) {
          setupAndJump();
        }
      });
    }
  }

  Future<void> setupAndJump() async {
    await setup();
    ever(filterEvent, (event) async {
      final tags = event.$1;
      if (categroy.value == categroy.value) {
        final ids = tags.map((e) => e.id!).toList();
        tagIds = ids;
        RSLoading.show();
        await Future.wait(
          categroyList.asMap().entries.map(
            (entry) async => await onRefresh(entry.key),
          ),
        );
        RSLoading.close();
      }
    });

    ever(followEvent, (even) {
      try {
        final e = even.$1;
        final id = even.$2;
        final index = list[tabController.index].indexWhere(
          (element) => element.id == id,
        );
        if (index != -1) {
          list[tabController.index][index].collect = e == FollowEvent.follow;
          list[tabController.index].refresh();
        }
      } catch (e) {
        debugPrint('[DiscoverChildController] : $e');
      }
    });
    jump();
  }

  Future<void> setup() async {
    try {
      final isRSB = RS.storage.isRSB;
      categroyList.addAll([
        HomeListCategroy.all,
        HomeListCategroy.realistic,
        HomeListCategroy.anime,
        if (isRSB) HomeListCategroy.video,
        if (isRSB) HomeListCategroy.dressUp,
      ]);

      // 初始化数据
      for (int i = 0; i < categroyList.length; i++) {
        isDataLoaded.add(false.obs);
        isLoading.add(false.obs);
        list.add(<ChaterModel>[].obs);
        isNoMoreData.add(false);
      }
      RSLoading.show();
      onRefresh(0);
      tabController = TabController(
        length: categroyList.length,
        vsync: this,
        animationDuration: const Duration(milliseconds: 200),
      );
      tabController.addListener(() {
        currentIndex.value = tabController.index;
        // 避免重复触发（Tab 切换动画过程中索引会变化）
        if (tabController.indexIsChanging) return;

        final tabState = list[currentIndex.value];
        if (tabController.index + 1 == HomeListCategroy.video.index) {
          RSlogEvent('c_videochat');
        }
        // 首次切换且未加载过数据 → 加载初始数据
        if (tabState.isEmpty && !isLoading[currentIndex.value].value) {
          onRefresh(currentIndex.value);
        }
      });
      if (RS.storage.isRSB) {
        await loadTags();
        selectedType.value = roleTags.firstOrNull;
      }

      Api.updateEventParams();
    } catch (e) {
      log.e('All tasks failed with error: $e');
    }

    update();
  }

  Future<void> onRefresh(index) async {
    try {
      page = 1;
      isNoMoreData[index] = false;
      await _fetchData(index);

      await Future.delayed(const Duration(milliseconds: 50));
      refreshCtr.finishRefresh();
      refreshCtr.finishLoad(
        isNoMoreData[index] ? IndicatorResult.noMore : IndicatorResult.none,
      );
    } finally {
      if (index == 0) {
        RSLoading.close();
      }
      isDataLoaded[index].value = true;
      isLoading[index].value = false;
    }
  }

  Future<void> onLoad(index) async {
    if (isLoading[index].value) return;
    if (isNoMoreData[index]) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        refreshCtr.finishLoad(IndicatorResult.noMore);
      });
      return;
    }

    // isLoading[index].value = true;

    try {
      page++;
      await _fetchData(index);

      await Future.delayed(const Duration(milliseconds: 50));
      refreshCtr.finishLoad(
        isNoMoreData[index] ? IndicatorResult.noMore : IndicatorResult.none,
      );
    } catch (e) {
      page--;
      refreshCtr.finishLoad(IndicatorResult.fail);
    } finally {
      isLoading[index].value = false;
    }
  }

  Future loadTags() async {
    final tags = await Api.roleTagsList();
    if (tags != null) {
      roleTags.assignAll(tags);
    }
  }

  void jump() {
    if (RS.storage.isRSB) {
      jumpForB();
    } else {
      jumpForA();
    }
  }

  void jumpForA() async {
    final isFirstLaunch = RS.storage.isRestart == false;
    if (isFirstLaunch) {
      recordInstallTime();
      RS.storage.setRestart(true);
    } else {
      final isShowDailyReward = await shouldShowDailyReward();
      if (isShowDailyReward) {
        // 更新奖励时间戳
        await RS.storage.setInstallTime(DateTime.now().millisecondsSinceEpoch);
        DialogWidget.showLoginReward();
      }
    }
  }

  void jumpForB() async {
    final isShowDailyReward = await shouldShowDailyReward();
    final isVip = RS.login.vipStatus.value;
    final isFirstLaunch = RS.storage.isRestart == false;
    if (isFirstLaunch) {
      // 记录安装时间
      recordInstallTime();
      // 记录为重启
      RS.storage.setRestart(true);

      // 首次启动 获取指定人物聊天
      final startRole = await getSplashRole();
      if (startRole != null) {
        final roleId = startRole.id;
        RoutePages.pushChat(roleId, showLoading: false);
      } else {
        jumpVip(isFirstLaunch);
      }
    } else {
      // 非首次启动 判断弹出奖励弹窗
      if (isShowDailyReward) {
        // 更新奖励时间戳
        await RS.storage.setInstallTime(DateTime.now().millisecondsSinceEpoch);
        DialogWidget.showLoginReward();
      } else {
        // 非vip用户 跳转订阅页
        if (!isVip) {
          jumpVip(isFirstLaunch);
        }
      }
    }
  }

  handleFilter() async {
    if (roleTags.isEmpty) {
      RSLoading.show();
      await loadTags();
      selectedType.value = roleTags.firstOrNull;
      RSLoading.close();
    }
    selectTags.assignAll(cjSelectTags);
    DialogWidget.show(child: RSFilterWidget(), clickMaskDismiss: false);
  }

  handleFilterSubmit() {
    SmartDialog.dismiss();
    cjSelectTags.assignAll(selectTags);
    filterEvent.value = (
      Set<TagModel>.from(cjSelectTags),
      DateTime.now().millisecondsSinceEpoch,
    );
    filterEvent.refresh();
    update();
  }

  Future<void> recordInstallTime() async {
    await RS.storage.setInstallTime(DateTime.now().millisecondsSinceEpoch);
  }

  Future<bool> shouldShowDailyReward() async {
    final installTimeMillis = RS.storage.installTime;
    if (installTimeMillis <= 0) {
      // 记录安装时间
      recordInstallTime();
      return false; // 没有记录安装时间，不处理
    }

    final installTime = DateTime.fromMillisecondsSinceEpoch(installTimeMillis);
    final now = DateTime.now();

    // 安装后第一天不弹窗，只有从第二天开始才弹窗
    final isAfterSecondDay =
        now.year > installTime.year ||
        (now.year == installTime.year && now.month > installTime.month) ||
        (now.year == installTime.year &&
            now.month == installTime.month &&
            now.day > installTime.day);

    if (!isAfterSecondDay) {
      return false;
    }

    // 检查今天是否已经发过奖励（避免重复弹窗）
    await RS.storage.setLastRewardDate(0);
    final lastRewardDateMillis = RS.storage.lastRewardDate;
    if (lastRewardDateMillis > 0) {
      final lastRewardDate = DateTime.fromMillisecondsSinceEpoch(
        lastRewardDateMillis,
      );

      // 如果今天已经发过奖励，则不弹窗
      if (now.year == lastRewardDate.year &&
          now.month == lastRewardDate.month &&
          now.day == lastRewardDate.day) {
        return false;
      }
    }
    //设置奖励时间戳
    await RS.storage.setLastRewardDate(DateTime.now().millisecondsSinceEpoch);
    return true; // 可以发奖励
  }

  Future<ChaterModel?> getSplashRole() async {
    await RS.login.fetchUserInfo();
    final role = await Api.splashRandomRole();
    return role;
  }

  void jumpVip(bool isFirstLaunch) async {
    Get.toNamed(
      RSRouteNames.vip,
      arguments: RS.storage.isRestart ? VipFrom.relaunch : VipFrom.launch,
    );

    var event = RS.storage.isRSB ? 't_vipb' : 't_vipa';

    if (RS.storage.isRestart) {
      event = '${event}_relaunch';
    } else {
      event = '${event}_launch';
      RS.storage.setRestart(true);
    }
    RSlogEvent(event);
  }

  Future _fetchData(int index) async {
    isLoading[index].value = true;
    var cate = categroyList[index];
    rendStyl = null;
    videoChat = null;
    genImg = null;
    genVideo = null;
    changeClothing = null;
    if (cate == HomeListCategroy.realistic) {
      rendStyl = HomeListCategroy.realistic.name.toUpperCase();
    } else if (cate == HomeListCategroy.anime) {
      rendStyl = HomeListCategroy.anime.name.toUpperCase();
    } else if (cate == HomeListCategroy.video) {
      videoChat = true;
    } else if (cate == HomeListCategroy.dressUp) {
      changeClothing = true;
    }
    final ids = selectTags.map((e) => e.id!).toList();
    tagIds = ids;

    try {
      final res = await Api.homeList(
        page: page,
        size: size,
        rendStyl: rendStyl,
        videoChat: videoChat,
        genImg: genImg,
        genVideo: genVideo,
        tags: tagIds,
        dress: changeClothing,
      );

      final records = res?.records ?? [];
      isNoMoreData[index] = (records.length) < size;

      if (page == 1) {
        list[index].clear();
        if (RS.login.vipStatus.value == false) {
          Get.find<RSAutoCallController>().onCall(records);
        }
      }
      nativeAd ??= MyAd().nativeAd;

      type.value = list[index].isEmpty ? EmptyType.noData : null;
      list[index].addAll(records);
      isDataLoaded[index].value = true;
      isLoading[index].value = false;
    } catch (e) {
      type.value = list[index].isEmpty ? EmptyType.noData : null;
    } finally {
      // RSLoading.close();
    }
  }

  void onCollect(int tabIndex, int index, ChaterModel role) async {
    final chatId = role.id;
    if (chatId == null) {
      return;
    }
    RSLoading.show();
    if (role.collect == true) {
      final res = await Api.cancelCollectRole(chatId);
      if (res) {
        role.collect = false;

        list[tabIndex].refresh();
      }
      followEvent.value = (
        FollowEvent.unfollow,
        chatId,
        DateTime.now().millisecondsSinceEpoch,
      );
    } else {
      final res = await Api.collectRole(chatId);
      if (res) {
        role.collect = true;
        list[tabIndex].refresh();

        if (!RS.storage.isShowGoodCommentDialog) {
          DialogWidget.showPositiveReview();
          RS.storage.setShowGoodCommentDialog(true);
        }
      }
    }
    RSLoading.close();
  }

  // 手动刷新当前选项卡
  Future<void> refreshCurrentTab() async {
    print(currentIndex.value);
    await onRefresh(currentIndex.value);
  }

  // 手动刷新指定选项卡
  Future<void> refreshTab(int index) async {
    await onRefresh(index);
  }

  @override
  void onClose() {
    tabController.dispose();
    // scrollController.dispose();
    super.onClose();
  }
}
