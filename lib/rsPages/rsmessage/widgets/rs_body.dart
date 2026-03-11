import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rose_say/rsCommon/index.dart';

import '../index.dart';
import 'widgets.dart';

/// hello
class RSBodyWidget extends GetView<RsmessageController> {
  const RSBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Stack(
          children: [
            Positioned.fill(
              child: RSImageWidget(
                url:
                    controller.state.session.background ??
                    controller.state.role.avatar,
              ),
            ),
            Positioned.fill(
              child: Container(
                width: Get.width,
                height: Get.height,
                color: Colors.black.withValues(alpha: 0.3),
              ),
            ),
            if (RS.storage.chatBgImagePath.isNotEmpty)
              Positioned.fill(
                child: Image.file(
                  File(RS.storage.chatBgImagePath),
                  fit: BoxFit.cover,
                ),
              ),
            Positioned.fill(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 32.w,
                  right: 32.w,
                  top: Get.mediaQuery.padding.top + 16.w,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.toNamed(
                              RSRouteNames.profile,
                              arguments: controller.state.role,
                            );
                          },
                          child: Row(
                            spacing: 24.w,
                            children: [
                              Container(
                                width: 84.w,
                                height: 84.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(84.r),
                                  border: Border.all(
                                    width: 2.w,
                                    color: const Color(0xffABC4E4),
                                  ),
                                ),
                                child: RSImageWidget(
                                  url: controller.state.role.avatar,
                                  width: 84.w,
                                  height: 84.w,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              ConstrainedBox(
                                constraints: BoxConstraints(maxWidth: 260.w),
                                child: Text(
                                  controller.state.role.name ?? '',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: 32.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          spacing: 16.w,
                          children: [
                            GestureDetector(
                              onTap: () {
                                DialogWidget.showChatLevel();
                              },
                              child: Container(
                                width: 64.w,
                                height: 64.w,
                                // margin: EdgeInsets.only(left: 24.w),
                                decoration: BoxDecoration(
                                  color: const Color(
                                    0xffCCDEFF,
                                  ).withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(100.r),
                                  border: Border.all(
                                    width: 1.w,
                                    color: Colors.white.withValues(alpha: 0.23),
                                  ),
                                ),
                                child: Center(
                                  child: Obx(() {
                                    var data = controller.state.chatLevel.value;
                                    var level = data?.level ?? 1;
                                    final map = controller
                                        .state
                                        .chatLevelConfigs
                                        .firstWhereOrNull(
                                          (element) =>
                                              element['level'] == level,
                                        );
                                    var levelStr = map?['icon'] as String?;
                                    return Text(
                                      levelStr ?? '👋',
                                      style: const TextStyle(fontSize: 17),
                                    );
                                  }),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(
                                  RSRouteNames.gems,
                                  arguments: ConsumeFrom.chat,
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 8.w,
                                  horizontal: 12.w,
                                ),
                                // margin: EdgeInsets.only(left: 24.w),
                                decoration: BoxDecoration(
                                  color: const Color(
                                    0xffCCDEFF,
                                  ).withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(100.r),
                                  border: Border.all(
                                    width: 1.w,
                                    color: Colors.white.withValues(alpha: 0.23),
                                  ),
                                ),
                                child: Center(
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        "assets/images/rs_03.png",
                                        width: 48.w,
                                        fit: BoxFit.contain,
                                      ),
                                      SizedBox(width: 4.w),
                                      Obx(
                                        () => Text(
                                          RS.login.gemBalance.toString(),
                                          style: TextStyle(
                                            fontSize: 28.sp,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: Container(
                                width: 64.w,
                                height: 64.w,
                                // margin: EdgeInsets.only(left: 24.w),
                                decoration: BoxDecoration(
                                  color: const Color(
                                    0xffCCDEFF,
                                  ).withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(100.r),
                                  border: Border.all(
                                    width: 1.w,
                                    color: Colors.white.withValues(alpha: 0.23),
                                  ),
                                ),
                                child: Center(
                                  child: Image.asset(
                                    "assets/images/rs_close1.png",
                                    width: 40.w,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: RSMsgListWidget()),
                          RSInpBar(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: kToolbarHeight + 18.w,
              child: const SafeArea(child: Column(children: [RSLelWidget()])),
            ),
            Obx(() {
              final vip = RS.login.vipStatus.value;
              if (controller.state.role.vip == true && !vip) {
                DialogWidget.show(
                  child: const RSUnLView(),
                  clickMaskDismiss: false,
                );
                // return const Positioned.fill(child: RSUnLView());
              }
              return const Positioned(
                left: 0,
                top: 0,
                child: SizedBox.shrink(),
              );
            }),
          ],
        ),
      ],
    );
  }
}
