import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:rose_say/rsCommon/index.dart';

import 'index.dart';

class RsaigeneratehistoryController extends GetxController {
  RsaigeneratehistoryController();

  final state = RsaigeneratehistoryState();

  int page = 1;
  int size = 15;
  final EasyRefreshController refreshCtr = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );
  var list = RxList<RSCreationsHistory>();
  Rx<EmptyType?> type = Rx<EmptyType?>(null);
  bool isNoMoreData = false;

  /// 在 widget 内存中分配后立即调用。
  @override
  void onInit() {
    super.onInit();
    initData();
  }

  // 初始化数据
  void initData() async {
    // 初始化选项卡数据
    RSLoading.show();

    await onRefresh();
  }

  Future<void> onRefresh() async {
    try {
      page = 1;
      await _fetchData();

      await Future.delayed(const Duration(milliseconds: 50));
      refreshCtr.finishRefresh();
      refreshCtr.finishLoad(
        isNoMoreData ? IndicatorResult.noMore : IndicatorResult.none,
      );
    } finally {
      RSLoading.close();
    }
  }

  Future<void> onLoad() async {
    if (isNoMoreData) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        refreshCtr.finishLoad(IndicatorResult.noMore);
      });
      return;
    }

    try {
      page++;
      await _fetchData();

      await Future.delayed(const Duration(milliseconds: 50));
      refreshCtr.finishLoad(
        isNoMoreData ? IndicatorResult.noMore : IndicatorResult.none,
      );
    } catch (e) {
      page--;
      refreshCtr.finishLoad(IndicatorResult.fail);
    } finally {}
  }

  Future _fetchData() async {
    try {
      final res = await ImageAPI.getAiPhotoHistoryList(page: page, size: size);
      isNoMoreData = (res.length) < size;

      if (page == 1) {
        list.clear();
      }

      type.value = list.isEmpty ? EmptyType.noData : null;
      list.addAll(res);
    } catch (e) {
      type.value = list.isEmpty ? EmptyType.noData : null;
    } finally {
      // SALoading.close();
    }
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
