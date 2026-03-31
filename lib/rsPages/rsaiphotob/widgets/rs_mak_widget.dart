import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rose_say/rsCommon/index.dart';

import 'rs_makSte1.dart';
import 'rs_makSte2.dart';
import 'rs_makSte3.dart';

enum RSAiStep { step1, step2, step3 }

enum RSAiViewType { image, video, role }

class RSMakWidget extends StatefulWidget {
  const RSMakWidget({super.key, required this.type, this.role});

  final RSAiViewType type;
  final ChaterModel? role;

  @override
  State<RSMakWidget> createState() => _RSMakWidgetState();
}

class _RSMakWidgetState extends State<RSMakWidget> {
  RSAiStep step = RSAiStep.step1;
  String imagePath = '';
  String? customPrompt;

  bool isLoading = false;
  bool undressRole = false;

  List<RSImgStyle> styles = [];
  RSImgStyle? selectedStyel;

  List<RSImageHistroy>? records;
  bool hasHistory = false;

  ChaterModel? role;

  String? imageUrl;

  bool get isVideo => widget.type == RSAiViewType.video;

  @override
  void initState() {
    super.initState();

    role = widget.role;

    fetchStyles();
    if (widget.role != null) {
      fetchHistory();
    }
    RS.login.fetchUserInfo();
  }

  Future fetchStyles() async {
    try {
      final list = await ImageAPI.fetchStyleConf();
      styles.assignAll(list);
      setState(() {});
    } catch (e) {
      debugPrint('fetchStyles ❌: $e');
    }
  }

  Future fetchHistory() async {
    var characterId = role?.id;
    if (characterId == null) {
      return;
    }
    RSLoading.show();
    final list = await ImageAPI.getHistory(characterId);
    records = list;
    hasHistory = records != null && records!.isNotEmpty;
    RSLoading.close();
  }

  void onTapUpload() async {
    RSLoading.show();
    var file = await RSImageUtils.pickImageFromGallery();
    RSLoading.close();
    if (file == null) return;
    imagePath = file.path;

    if (styles.isEmpty) {
      await fetchStyles();
    }
    step = RSAiStep.step2;
    undressRole = false;
    selectedStyel = styles.firstOrNull;
    setState(() {});
  }

  void onTapGenRole() async {
    await fetchStyles();
    if (hasHistory) {
      var res = records?.firstOrNull;
      imageUrl = res?.url;
      step = RSAiStep.step3;
      setState(() {});
    } else {
      final roleId = role?.id;
      if (roleId == null) return;
      undressRole = true;
      step = RSAiStep.step2;
      selectedStyel = styles.firstOrNull;
      setState(() {});
    }
  }

  void onTapGen() async {
    if (isLoading) return;
    RSlogEvent('c_un_generate');
    RSLoading.show();
    await RS.login.fetchUserInfo();
    RSLoading.close();

    if (widget.type == RSAiViewType.video) {
      genVideo();
    } else {
      genImage();
    }
  }

  void stopLoading({bool showToast = false}) {
    setState(() {
      isLoading = false;
    });
    if (showToast) {
      RSToast.show(" Generation failed, please try again later.");
    }
  }

  void genSucc() {
    RS.login.fetchUserInfo();

    step = RSAiStep.step3;
    RSlogEvent('un_gen_suc');
    stopLoading();
  }

  void buySku() async {
    stopLoading();

    final from = isVideo ? ConsumeFrom.img2v : ConsumeFrom.aiphoto;
    Get.toNamed(RSRouteNames.countSku, arguments: from); //WXC
  }

  void genImage() {
    var undressCount = RS.login.imgCreationCount.value;
    if (undressCount <= 0) {
      buySku();
      return;
    }
    RS.login.imgCreationCount.value -= 1;
    if (undressRole) {
      undrRole();
    } else {
      undreImg();
    }
  }

  Future<String> getStyle() async {
    var style = '';
    if (customPrompt != null && customPrompt!.isNotEmpty) {
      String? enText = await Api.translateText(customPrompt!, tlan: 'en');
      style = enText ?? '';
    } else {
      style = selectedStyel?.style ?? '';
    }
    return style;
  }

  Future undrRole() async {
    try {
      var characterId = widget.role?.id;
      if (characterId == null) return;

      setState(() {
        isLoading = true;
      });

      var style = await getStyle();
      final data = await ImageAPI.uploadRoleImage(
        style: style,
        characterId: characterId,
      );

      final img = data?.uid;

      if (img != null && img.contains('http')) {
        imageUrl = img;
        RS.login.fetchUserInfo();

        await Future.delayed(const Duration(seconds: 10));
        genSucc();
        fetchHistory();
        return;
      }

      final taskId = data?.uid;
      if (taskId == null) {
        stopLoading();
        return;
      }

      // 预估时间
      final estimateTime = data?.estimatedTime ?? 0;
      await Future.delayed(Duration(seconds: estimateTime));

      final result = await ImageAPI.getImageResult(taskId);
      var status = result?.status ?? 0;
      if (status != 2) {
        stopLoading(showToast: true);
        return;
      }

      imageUrl = result?.results?.first;

      if (imageUrl == null) {
        stopLoading(showToast: true);
        return;
      }
      genSucc();

      fetchHistory();
    } catch (e) {
      stopLoading();
    }
  }

  Future undreImg() async {
    try {
      setState(() {
        isLoading = true;
      });

      // 上传图片
      final uploadRes = await ImageAPI.uploadAiImage(
        imagePath: imagePath,
        style: await getStyle(),
      );
      if (uploadRes == null) {
        stopLoading(showToast: true);
        return;
      }

      final taskId = uploadRes.uid;
      if (taskId == null) {
        stopLoading(showToast: true);
        return;
      }

      if (taskId.contains('http')) {
        imageUrl = taskId;
        await Future.delayed(const Duration(seconds: 10));
        genSucc();
        return;
      }
      // 预估时间
      final estimateTime = uploadRes.estimatedTime ?? 0 + 10;
      await Future.delayed(Duration(seconds: estimateTime));

      final res = await ImageAPI.getImageResult(taskId);
      imageUrl = res?.results?.first;

      if (imageUrl == null) {
        stopLoading(showToast: true);
        return;
      }
      genSucc();
    } catch (e) {
      stopLoading(showToast: true);
    }
  }

  void genVideo() async {
    var undressCount = RS.login.videoCreationCount.value;
    if (undressCount <= 0) {
      buySku();
      return;
    }
    if (customPrompt == null || customPrompt!.isEmpty) {
      RSToast.show("Please enter a custom prompt");
      stopLoading();
      return;
    }

    setState(() {
      isLoading = true;
    });
    RS.login.videoCreationCount.value -= 1;

    // 翻译 customPrompt：
    String? enText = await Api.translateText(customPrompt!, tlan: 'en');

    // 上传图片，开始任务
    var uploadRes = await ImageAPI.uploadImgToVideo(
      imagePath: imagePath,
      enText: enText ?? '',
    );
    // 获取结果
    if (uploadRes == null) {
      stopLoading();
      return;
    }

    final taskId = uploadRes.uid;
    if (taskId == null) {
      stopLoading();
      return;
    }

    if (taskId.contains('http')) {
      imageUrl = taskId;
      await Future.delayed(const Duration(seconds: 10));
      genSucc();
      return;
    }

    // 预估时间
    final estimateTime = uploadRes.estimatedTime ?? 0;
    await Future.delayed(Duration(seconds: estimateTime));

    ImageVideoResItem? res = await ImageAPI.getVideoResult(taskId);
    var videoUrl = res?.resultPath;
    if (videoUrl == null) {
      stopLoading(showToast: true);
      return;
    }

    imageUrl = await FileDownloadService.instance.downloadFile(
      videoUrl,
      fileType: FileType.video,
    );

    genSucc();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: SafeArea(top: false, child: _body())),
        // if (isLoading) const RSMakLoading(),
      ],
    );
  }

  Widget _body() {
    if (step == RSAiStep.step1) {
      return RSMakste1(
        role: widget.role,
        isVideo: isVideo,
        hasHistory: hasHistory,
        onTapGenRole: onTapGenRole,
        onTapUpload: onTapUpload,
      );
    }
    if (step == RSAiStep.step2) {
      return RSMakste2(
        onTapGen: onTapGen,
        isLoading: isLoading,
        onDeleteImage: () {
          imagePath = '';
          step = RSAiStep.step1;
          setState(() {});
        },
        role: widget.role,
        isVideo: isVideo,
        onInputTextFinish: (String text) {
          customPrompt = text;
        },
        styles: styles,
        onChooseStyles: (value) {
          selectedStyel = value;
        },
        imagePath: imagePath,
        undressRole: undressRole,
        selectedStyel: selectedStyel,
      );
    }

    if (step == RSAiStep.step3) {
      return RSMakste3(
        onTapGen: onTapUpload,
        onDeleteImage: () {
          imagePath = '';
          step = RSAiStep.step1;
          setState(() {});
        },
        role: widget.role,
        resultUrl: imageUrl ?? '',
        isVideo: isVideo,
      );
    }

    return Container();
  }
}
