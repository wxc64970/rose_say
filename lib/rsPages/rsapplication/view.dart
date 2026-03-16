import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rose_say/rsCommon/index.dart';
import 'package:rose_say/rsPages/index.dart';

import 'index.dart';

class RsapplicationPage extends GetView<RsapplicationController> {
  const RsapplicationPage({super.key});

  Widget _buildBottomNavigationBar() {
    return Obx(
      () => Container(
        // 给容器添加一些底部内边距，使其不会紧贴屏幕边缘（可选）
        padding: const EdgeInsets.only(bottom: 0),
        // 外层容器的背景色
        color: const Color(0xff0B0B0B),
        child: Container(
          clipBehavior: Clip.antiAlias,
          padding: EdgeInsets.only(top: 20.w),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: const Color(0xffffffff).withValues(alpha: 0.26),
                width: 2.w,
              ),
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32.r),
              topRight: Radius.circular(32.r),
            ),
            color: const Color(0xff010007),
          ),

          child: BottomNavigationBar(
            backgroundColor: const Color(0xff010007),
            items: controller.bottomTabs,
            currentIndex: controller.state.page,
            fixedColor: RSAppColors.primaryColor,
            type: BottomNavigationBarType.fixed,
            onTap: controller.handleNavBarTap,
            iconSize: 48.w,
            unselectedItemColor: Colors.white.withValues(alpha: 0.4),
            unselectedLabelStyle: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w400,
              color: Colors.white.withValues(alpha: 0.4),
              height: 2.5,
            ),
            selectedLabelStyle: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w400,
              color: RSAppColors.primaryColor,
              height: 2.5,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPageView() {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: controller.pageController,
      onPageChanged: controller.handlePageChanged,

      children: const [
        RsdiscoverPage(),
        RsaiphotoPage(),
        RschatPage(),
        RsmePage(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RsapplicationController>(
      init: RsapplicationController(),
      id: "rsapplication",
      builder: (_) {
        return WillPopScope(
          onWillPop: () {
            if (Platform.isAndroid) {
              // AndroidBackTop.backDeskTop(); //设置为返回不退出app
              return Future.value(false);
            } else {
              return Future.value(true);
            }
          },
          child: Scaffold(
            body: _buildPageView(),
            bottomNavigationBar: _buildBottomNavigationBar(),
          ),
        );
      },
    );
  }
}
