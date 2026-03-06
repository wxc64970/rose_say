import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:rose_say/rsCommon/index.dart';

class RsaiphotoController extends GetxController {
  RsaiphotoController();

  late TextEditingController descriptionController;
  List<RSImageStyle> imageStyleList = [];
  RxList<RSImageStyle> imageStyleData = <RSImageStyle>[].obs;
  Rx<RSImageStyle> selectImageStyleData = RSImageStyle().obs;
  final _imageStyleTabs = "".obs;
  set imageStyleTabs(value) => _imageStyleTabs.value = value;
  get imageStyleTabs => _imageStyleTabs.value;
  final _numberOfImages = 1.obs;
  set numberOfImages(value) => _numberOfImages.value = value;
  get numberOfImages => _numberOfImages.value;
  final _defaultDescription = ''.obs;
  set defaultDescription(value) => _defaultDescription.value = value;
  get defaultDescription => _defaultDescription.value;

  final imageRatioList = ["1:1", "4:3", "9:16", "9:19"];
  final _selectImageRatio = "1:1".obs;
  set selectImageRatio(value) => _selectImageRatio.value = value;
  get selectImageRatio => _selectImageRatio.value;
  final _coins = "20".obs;
  set coins(value) => _coins.value = value;
  get coins => _coins.value;
  final RxInt descriptionLength = 0.obs;
  final int maxDescriptionLength = 500;
  final _progress = 0.0.obs;
  set progress(value) => _progress.value = value;
  get progress => _progress.value;
  Timer? _timeoutTimer;
  Timer? _progressTimer;
  static const Duration _timeoutDuration = Duration(minutes: 2);
  RSGenAvatarResult? _cachedResult;
  bool _hasResult = false;
  bool _isTimeoutHandled = false;
  int _currentStep = 0;
  int maxRetries = 40;
  final Duration _retryInterval = const Duration(seconds: 3);

  _initData() async {
    RSLoading.show();
    await Future.wait([
      RS.login.fetchUserInfo(),
      loadImageStyles(),
      loadDefaultDescription(true),
    ]);
    RSLoading.close();
    update(["rsaiphoto"]);
  }

  Future<void> loadImageStyles() async {
    List<RSImageStyle>? styles = await ImageAPI.getImageStyle();
    imageStyleList = styles ?? [];
    selectImageStyleTab(RSTextData.real);
  }

  Future<void> loadDefaultDescription(type) async {
    PresetTips? data = await Api.getPresetTips();
    if (type) {
      defaultDescription = data?.prompt ?? RSTextData.defaultDescription;
    } else {
      descriptionController.text = data?.prompt ?? "";
    }
  }

  void clearDescription() {
    descriptionController.clear();
  }

  void handleAIWrite() async {
    RSLoading.show();
    try {
      await loadDefaultDescription(false);
    } catch (e) {
    } finally {
      RSLoading.close();
    }
  }

  void handleNumberOfImages(type) {
    if (type == 1) {
      if (numberOfImages >= 4) return;
      numberOfImages++;
    } else {
      if (numberOfImages <= 1) return;
      numberOfImages--;
    }
    switch (numberOfImages) {
      case 1:
        coins = "20";
        break;
      case 2:
        coins = "30";
        break;
      case 3:
        coins = "50";
        break;
      case 4:
        coins = "70";
        break;
      default:
        break;
    }
  }

  void createImage() async {
    RSLoading.show();

    await RS.login.fetchUserInfo();

    // 检查免费次数和钻石
    if (int.parse(coins) > RS.login.gemBalance.value) {
      RSLoading.close();
      Get.toNamed(RSRouteNames.gems, arguments: ConsumeFrom.generateimage);
      return;
    }
    Map<String, dynamic> params = {
      "style_id": selectImageStyleData.value.id!,
      'img_count': numberOfImages,
      'describe_img': descriptionController.text.trim().isEmpty
          ? defaultDescription
          : descriptionController.text.trim(),
      'image_ratio': selectImageRatio,
    };
    _generateImage(params);
  }

  void _generateImage(Map<String, dynamic> params) async {
    try {
      final result = await ImageAPI.avatarAiGenerateGems(params);
      RSLoading.close();
      if (result != null) {
        if (result.code == 200) {
          toLoadingWidget(result.data);
        } else {
          RSToast.show(result.message ?? RSTextData.failedGenerate);
        }
      } else {
        RSToast.show(RSTextData.failedGenerate);
      }
    } catch (e) {
      RSLoading.close();
      RSToast.show(RSTextData.errorGenerate);
    }
  }

  toLoadingWidget(int id) async {
    SmartDialog.show(
      clickMaskDismiss: false,
      debounce: true,
      backType: SmartBackType.block,
      builder: (context) {
        return SizedBox(
          width: Get.width,
          height: Get.height,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 32.w,
              children: [loadingIndicatorWidget(), progressText()],
            ),
          ),
        );
      },
    );
    try {
      _updateProgress(0.1);
      await _startRecursiveGeneration(id);
    } catch (e) {
      log.d('Generation start error: $e');
      _updateProgress(0.0);
    }
  }

  Future<void> _startRecursiveGeneration(dynamic id) async {
    try {
      _startProgressAnimation();
      _timeoutTimer = Timer(_timeoutDuration, () {
        log.d('Generation timeout');
        _handleGenerationTimeout();
      });

      await _checkGenerationResult(id);
    } catch (e) {
      log.d('Recursive generation error: $e');
      _updateProgress(0.0);
    }
  }

  void _handleGenerationTimeout() {
    if (_isTimeoutHandled) {
      return;
    }
    _isTimeoutHandled = true;
    _timeoutTimer?.cancel();
    _progressTimer?.cancel();
    RSToast.show(RSTextData.loadingTimeoutWithCreditRefund);
    SmartDialog.dismiss();
  }

  Future<void> _checkGenerationResult(
    int generateId, {
    int retryCount = 0,
  }) async {
    if (retryCount >= maxRetries) {
      _timeoutTimer?.cancel();
      log.d('Generation timeout after $maxRetries attempts');
      _handleGenerationTimeout();
      return;
    }

    try {
      log.d('Checking generation result, attempt: ${retryCount + 1}');

      final result = await ImageAPI.avatarAiGenerateResult(generateId);
      final imageList = result?.imageList;

      if (imageList != null && imageList.isNotEmpty) {
        _hasResult = true;
        _cachedResult = result;
        await _handleResultReceived();
      } else {
        log.d('Generation not ready, waiting for next check...');

        // 使用可中断的延时，每100ms检查一次页面状态
        final checkInterval = Duration(milliseconds: 100);
        final totalChecks =
            _retryInterval.inMilliseconds ~/ checkInterval.inMilliseconds;

        for (int i = 0; i < totalChecks; i++) {
          await Future.delayed(checkInterval);
        }

        await _checkGenerationResult(generateId, retryCount: retryCount + 1);
      }
    } catch (e) {
      log.d('Check generation result error (attempt ${retryCount + 1}): $e');

      // 即使出错也要检查页面状态
      if (retryCount < maxRetries - 1) {
        // 使用可中断的延时
        final checkInterval = Duration(milliseconds: 100);
        final totalChecks =
            _retryInterval.inMilliseconds ~/ checkInterval.inMilliseconds;

        for (int i = 0; i < totalChecks; i++) {
          await Future.delayed(checkInterval);
        }

        await _checkGenerationResult(generateId, retryCount: retryCount + 1);
      }
    }
  }

  Future<void> _handleResultReceived() async {
    // 如果当前进度小于50%，等待到50%
    while (_progress < 0.5) {
      await Future.delayed(const Duration(milliseconds: 100));
    }
    // 等待进度到达70%
    while (_progress < 0.7 && isClosed) {
      await Future.delayed(const Duration(milliseconds: 100));
    }

    _updateProgress(0.95);
    await Future.delayed(const Duration(milliseconds: 500));
    await _handleGenerationComplete(_cachedResult!);
  }

  Future<void> _handleGenerationComplete(RSGenAvatarResult result) async {
    _timeoutTimer?.cancel();
    _updateProgress(1.0);
    RS.login.fetchUserInfo();
    await Future.delayed(const Duration(milliseconds: 1000));

    log.d('Generation complete with result: $result progress: 1.0');
    SmartDialog.dismiss();

    Get.toNamed(RSRouteNames.aiGenerateHistory);
  }

  void _startProgressAnimation() {
    _updateProgress(0.1);
    _currentStep = 1;

    _progressTimer = Timer.periodic(const Duration(milliseconds: 200), (timer) {
      if (isClosed) {
        timer.cancel();
        return;
      }

      _currentStep++;

      // 前50步必须至少10秒 (50步 * 200ms = 10秒)
      // 后续步骤根据是否有结果调整速度
      double newProgress;
      if (_currentStep <= 50) {
        // 前50步：10秒内从10%增长到50% (每步增长0.8%)
        newProgress = 0.1 + (_currentStep * 0.008);
      } else {
        // 50步之后的处理
        if (_hasResult) {
          // 有结果时快速增长到70%
          newProgress = 0.5 + ((_currentStep - 50) * 0.004);
        } else {
          // 没有结果时缓慢增长，避免停滞
          // 从50%开始，每步增长0.1%，最多到65%
          double slowIncrement = (_currentStep - 50) * 0.001;
          newProgress = 0.5 + slowIncrement;
          newProgress = newProgress.clamp(0.5, 0.65); // 限制在50%-65%之间
        }
      }

      _updateProgress(newProgress.clamp(0.1, 0.7));

      // 到达70%时停止，等待结果处理
      if (progress >= 0.7) {
        timer.cancel();
      }
    });
  }

  void _updateProgress(double pro) {
    progress = pro;
    update(["rsaiphoto"]);
  }

  Widget loadingIndicatorWidget() {
    return SizedBox(
      width: 88.w,
      height: 88.w,
      child: LoadingAnimationWidget.hexagonDots(
        color: Colors.white,
        size: 88.w,
      ),
    );
  }

  Widget progressText() {
    return Obx(
      () => Text(
        '${(progress * 100).toInt()}% Generating...',
        style: TextStyle(
          color: Colors.white,
          fontSize: 28.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  void handleSelectStyleImages(RSImageStyle data) {
    selectImageStyleData.value = data;
  }

  void selectImageStyleTab(String type) {
    imageStyleTabs = type;
    imageStyleData.clear();
    if (type == RSTextData.real) {
      imageStyleData.value = imageStyleList
          .where((item) => item.styleType == 0)
          .toList();
      selectImageStyleData.value = imageStyleData.first;
    } else {
      imageStyleData.value = imageStyleList
          .where((item) => item.styleType == 1)
          .toList();
      selectImageStyleData.value = imageStyleData.first;
    }
  }

  @override
  void onInit() {
    super.onInit();
    descriptionController = TextEditingController();
    descriptionController.addListener(() {
      descriptionLength.value = descriptionController.text.length;
    });
  }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }
}
