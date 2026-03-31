import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rose_say/rsCommon/index.dart';
import 'package:rose_say/rsPages/index.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:permission_handler/permission_handler.dart';

import 'rs_observers.dart';

class RoutePages {
  static const INITIAL = RSRouteNames.launch;
  static final RouteObservers<Route> observer = RouteObservers();
  static List<String> history = [];
  // 列表
  static List<GetPage> routes = [
    GetPage(name: RSRouteNames.launch, page: () => const RslaunchscreenPage()),
    GetPage(
      name: RSRouteNames.application,
      page: () => const RsapplicationPage(),
      binding: RsapplicationBinding(),
    ),
    GetPage(
      name: RSRouteNames.search,
      page: () => const RssearchPage(),
      binding: RssearchBinding(),
    ),
    GetPage(
      name: RSRouteNames.message,
      page: () => const RSMessagePage(),
      binding: RsmessageBinding(),
    ),
    GetPage(
      name: RSRouteNames.profile,
      page: () => const RsprofilePage(),
      binding: RsprofileBinding(),
    ),
    GetPage(
      name: RSRouteNames.mask,
      page: () => const RsmaskPage(),
      binding: RsmaskBinding(),
    ),
    GetPage(
      name: RSRouteNames.gems,
      page: () => const RsgemsPage(),
      binding: RsgemsBinding(),
    ),
    GetPage(
      name: RSRouteNames.editMask,
      page: () => const RseditmaskPage(),
      binding: RseditmaskBinding(),
    ),
    GetPage(
      name: RSRouteNames.language,
      page: () => const RslanguagePage(),
      binding: RslanguageBinding(),
    ),
    GetPage(
      name: RSRouteNames.undr,
      page: () => const RsundrPage(),
      binding: RsundrBinding(),
    ),
    GetPage(
      name: RSRouteNames.imagePreview,
      page: () => const RSImagePreviewScreen(),
      transition: Transition.zoom,
      fullscreenDialog: true,
      preventDuplicates: true,
    ),
    GetPage(
      name: RSRouteNames.aiGenerateHistory,
      page: () => const RsaigeneratehistoryPage(),
      binding: RsaigeneratehistoryBinding(),
    ),
    GetPage(
      name: RSRouteNames.vip,
      page: () => const PopScope(
        canPop: false, // 禁止返回键
        child: RssubscribePage(),
      ),
      popGesture: false, // 禁用 iOS 侧滑返回
      preventDuplicates: true,
      binding: RssubscribeBinding(),
    ),
    GetPage(
      name: RSRouteNames.videoPreview,
      page: () => const RSVideoPreviewScreen(),
      fullscreenDialog: true,
      preventDuplicates: true,
    ),

    GetPage(
      name: RSRouteNames.phone,
      page: () => const RscallPage(),
      transition: Transition.downToUp,
      popGesture: false,
      preventDuplicates: true,
      fullscreenDialog: true,
      binding: RscallBinding(),
    ),
    GetPage(
      name: RSRouteNames.phoneGuide,
      page: () => const RscallguidePage(),
      transition: Transition.downToUp,
      popGesture: false,
      preventDuplicates: true,
      fullscreenDialog: true,
    ),
    GetPage(
      name: RSRouteNames.countSku,
      page: () => const RsaiskuPage(),
      transition: Transition.downToUp,
      popGesture: false,
      preventDuplicates: true,
      fullscreenDialog: true,
      binding: RsaiskuBinding(),
    ),
  ];

  static Future<void> pushChat(
    String? roleId, {
    bool showLoading = true,
  }) async {
    if (roleId == null) {
      RSToast.show('roleId is null, please check!');
      return;
    }

    try {
      if (showLoading) {
        RSLoading.show();
      }

      // 使用 Future.wait 来同时执行查角色和查会话
      var results = await Future.wait([
        Api.loadRoleById(roleId), // 查角色
        Api.addSession(roleId), // 查会话
      ]);

      var role = results[0];
      var session = results[1];

      // 检查角色和会话是否为 null
      if (role == null) {
        _dismissAndShowErrorToast('role is null');
        return;
      }
      if (session == null) {
        _dismissAndShowErrorToast('session is null');
        return;
      }

      RSLoading.close();
      Get.toNamed(
        RSRouteNames.message,
        arguments: {'role': role, 'session': session},
      );
    } catch (e) {
      RSLoading.close();
      RSToast.show(e.toString());
    }
  }

  static Future<T?>? pushPhone<T>({
    required int sessionId,
    required ChaterModel role,
    required bool showVideo,
    CallState callState = CallState.calling,
  }) async {
    // 检查 Mic 权限 和 语音权限
    if (!await checkPermissions()) {
      showNoPermissionDialog();
      return null;
    }

    return Get.toNamed(
      RSRouteNames.phone,
      arguments: {
        'sessionId': sessionId,
        'role': role,
        'callState': callState,
        'showVideo': showVideo,
      },
    );
  }

  static Future<T?>? offPhone<T>({
    required ChaterModel role,
    required bool showVideo,
    CallState callState = CallState.calling,
  }) async {
    // 检查 Mic 权限 和 语音权限
    if (!await checkPermissions()) {
      showNoPermissionDialog();
      return null;
    }
    var seesion = await Api.addSession(role.id ?? ''); // 查会话
    final sessionId = seesion?.id;
    if (sessionId == null) {
      RSToast.show('sessionId is null, please check!');
      return null;
    }

    return Get.offNamed(
      RSRouteNames.phone,
      arguments: {
        'sessionId': sessionId,
        'role': role,
        'callState': callState,
        'showVideo': showVideo,
      },
    );
  }

  /// 检查麦克风和语音识别权限，返回是否已授予所有权限
  static Future<bool> checkPermissions() async {
    PermissionStatus status = await Permission.microphone.request();
    PermissionStatus status2 = await Permission.speech.request();
    return status.isGranted && status2.isGranted;
  }

  // 没有权限提示
  static Future<void> showNoPermissionDialog() async {
    DialogWidget.alert(
      message: RSTextData.micPermission,
      onConfirm: () async {
        await openAppSettings();
      },
      cancelText: RSTextData.cancel,
      confirmText: RSTextData.openSettings,
    );
  }

  static void _dismissAndShowErrorToast(String message) {
    RSLoading.close();
    RSToast.show(message);
  }

  static void report() {
    Get.bottomSheet(RSReportSheet(), isScrollControlled: true);
  }

  static void _showError(String message) {
    RSToast.show(message);
  }

  static Future<void> openAppStoreReview() async {
    if (Platform.isIOS) {
      String appId = RSAppConstants.appId;
      final Uri url = Uri.parse(
        'https://apps.apple.com/app/id$appId?action=write-review',
      );

      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        _showError('Could not launch $url');
      }
    } else if (Platform.isAndroid) {
      String packageName = await RSInfoUtils.packageName();
      final Uri url = Uri.parse(
        'https://play.google.com/store/apps/details?id=$packageName',
      );

      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        _showError('Could not launch $url');
      }
    } else {
      _showError('Unsupported platform');
    }
  }

  static Future<void> openAppStore() async {
    try {
      if (Platform.isIOS) {
        String appId = RSAppConstants.appId;
        final Uri url = Uri.parse('https://apps.apple.com/app/id$appId');
        if (await canLaunchUrl(url)) {
          await launchUrl(url, mode: LaunchMode.externalApplication);
        } else {
          _showError('Could not launch $url');
        }
      } else if (Platform.isAndroid) {
        String packageName = await RSInfoUtils.packageName();
        final Uri url = Uri.parse(
          'https://play.google.com/store/apps/details?id=$packageName',
        );

        if (await canLaunchUrl(url)) {
          await launchUrl(url, mode: LaunchMode.externalApplication);
        } else {
          _showError('Could not launch $url');
        }
      } else {
        _showError('Unsupported platform');
      }
    } catch (e) {
      _showError('Could not launch ${e.toString()}');
    }
  }

  static void toEmail() async {
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
      _showError('Could not launch email client');
    }
  }
}
