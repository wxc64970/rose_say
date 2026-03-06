import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:rose_say/rsCommon/index.dart';
import 'package:url_launcher/url_launcher.dart';

import 'widgets/rs_setting_message_background.dart';

class RsmeController extends GetxController {
  RsmeController();

  final FocusNode _focusNode = FocusNode();
  late TextEditingController _textEditingController;
  var version = ''.obs;
  var chatbgImagePath = ''.obs;
  final _nickname = ''.obs;
  String get nickname => _nickname.value;
  set nickname(String value) => _nickname.value = value;

  _initData() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version.value = "V${packageInfo.version}";
    update(["me"]);
  }

  void onTapExprolreVIP() {
    Get.toNamed(RSRouteNames.vip, arguments: VipFrom.mevip);
  }

  void handleCreations() {
    RSlogEvent('me_creations_click');
    Get.toNamed(RSRouteNames.aiGenerateHistory);
  }

  void changeNickName() {
    nickname = RS.login.currentUser?.nickname ?? '';
    _textEditingController = TextEditingController(text: nickname);

    DialogWidget.input(
      title: RSTextData.nickname,
      message: RSTextData.howToCallYou,
      hintText: RSTextData.inputYourNickname,
      focusNode: _focusNode,
      textEditingController: _textEditingController,
      onConfirm: () async {
        if (_textEditingController.text.trim().isEmpty) {
          RSToast.show(RSTextData.inputYourNickname);
          return;
        }
        nickname = _textEditingController.text.trim();
        RSLoading.show();
        await RS.login.modifyUserNickname(nickname);
        RSLoading.close();
        DialogWidget.dismiss();
      },
    );
  }

  void feedback() async {
    final version = await RSInfoUtils.version();
    final device = await RS.storage.getDeviceId();
    final uid = RS.login.currentUser?.id;

    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: RSAppConstants.email, // 收件人
      query:
          "subject=Feedback&body=version: $version\ndevice: $device\nuid: $uid\nPlease input your problem:\n", // 设置默认主题和正文内容
    );
    if (await canLaunchUrl(emailUri)) {
      launchUrl(emailUri);
    } else {
      RSToast.show('Could not launch email client');
    }
  }

  void changeChatBackground() {
    DialogWidget.show(
      alignment: Alignment.bottomCenter,
      child: SettingMessageBackground(
        onTapUpload: uploadImage,
        onTapUseChat: resetChatBackground,
        isUseChater: chatbgImagePath.isEmpty,
      ),
    );
  }

  PrivacyPolicy() {
    launchUrl(Uri.parse(RSAppConstants.privacypolicyUrl));
  }

  TermsOfUse() {
    launchUrl(Uri.parse(RSAppConstants.termsUrl));
  }

  void resetChatBackground() async {
    await DialogWidget.dismiss();

    RS.storage.setChatBgImagePath('');
    chatbgImagePath.value = '';
  }

  void uploadImage() async {
    await DialogWidget.dismiss();

    var pickedFile = await RSImageUtils.pickImageFromGallery();

    if (pickedFile != null) {
      RSLoading.show();
      final directory = await getApplicationDocumentsDirectory();
      final fileName = path.basename(pickedFile.path);
      final cachedImagePath = path.join(directory.path, fileName);
      final File cachedImage = await File(
        pickedFile.path,
      ).copy(cachedImagePath);
      RS.storage.setChatBgImagePath(cachedImage.path);
      chatbgImagePath.value = cachedImage.path;
      await Future.delayed(const Duration(seconds: 2));
      RSLoading.close();
      RSToast.show(RSTextData.backUpdatedSucc);
    }
  }

  Future<void> openAppStore() async {
    try {
      if (Platform.isIOS) {
        String appId = RSAppConstants.appId;
        final Uri url = Uri.parse('https://apps.apple.com/app/id$appId');
        if (await canLaunchUrl(url)) {
          await launchUrl(url, mode: LaunchMode.externalApplication);
        } else {
          RSToast.show('Could not launch $url');
        }
      } else if (Platform.isAndroid) {
        String packageName = await RSInfoUtils.packageName();
        final Uri url = Uri.parse(
          'https://play.google.com/store/apps/details?id=$packageName',
        );

        if (await canLaunchUrl(url)) {
          await launchUrl(url, mode: LaunchMode.externalApplication);
        } else {
          RSToast.show('Could not launch $url');
        }
      } else {
        RSToast.show('Unsupported platform');
      }
    } catch (e) {
      RSToast.show('Could not launch ${e.toString()}');
    }
  }

  //跳转语言设置页面
  pushChooseLang() {
    Get.toNamed(RSRouteNames.language);
  }

  @override
  void onInit() {
    super.onInit();
    nickname = RS.login.currentUser?.nickname ?? '';
    _initData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}
