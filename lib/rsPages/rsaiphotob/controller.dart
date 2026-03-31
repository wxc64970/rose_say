import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rose_say/rsCommon/index.dart';
import 'package:rose_say/rsPages/rschat/widgets/rs_k_a_widget.dart';
import 'package:video_player/video_player.dart';

import 'widgets/rs_mak_widget.dart';

class RsaiphotobController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RsaiphotobController();

  late List tabList;
  final List<String> tabs = [RSTextData.ai_image_to_video, RSTextData.aiPhoto];
  late TabController tabController;
  List<Widget> tabViews = [];
  // 当前选中索引
  final currentIndex = 0.obs;

  final _customPrompt = ''.obs;
  String get customPrompt => _customPrompt.value;
  set customPrompt(String value) => _customPrompt.value = value;
  VideoPlayerController? videoController;
  RxList<ItemConfigs>? aiPhotoList = <ItemConfigs>[].obs;

  void _initData() async {
    RSLoading.show();
    List<ItemConfigs>? data = await ImageAPI.getAiPhoto();
    aiPhotoList!.addAll(data ?? []);
    RSLoading.close();
    update(["rsaiphotob"]);
  }

  @override
  void onInit() {
    super.onInit();
    _initData();
    tabController = TabController(length: tabs.length, vsync: this);
    // 初始化数据
    tabViews = const [
      KeepAliveWrapper(
        child: RSMakWidget(key: ValueKey('video'), type: RSAiViewType.video),
      ),
      KeepAliveWrapper(
        child: RSMakWidget(key: ValueKey('image'), type: RSAiViewType.image),
      ),
    ];
  }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
