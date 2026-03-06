import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:rose_say/rsCommon/index.dart';

import 'index.dart';

class RslaunchscreenPage extends GetView<RslaunchscreenController> {
  const RslaunchscreenPage({super.key});

  // 主视图
  Widget _buildView() {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset("assets/images/rs_62.png", fit: BoxFit.cover),
        ),
        Positioned.fill(
          child: Column(
            spacing: 16.w,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/rs_63.png",
                width: 160.w,
                fit: BoxFit.contain,
              ),
              Text(
                RSAppConstants.appName,
                style: TextStyle(
                  fontSize: 40.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 24.w),
              Center(
                child: LoadingAnimationWidget.horizontalRotatingDots(
                  color: Colors.white,
                  size: 60.w,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RslaunchscreenController>(
      init: RslaunchscreenController(),
      id: "rslaunchscreen",
      builder: (_) {
        return Scaffold(
          backgroundColor: const Color(0xff0B0B0B),
          body: _buildView(),
        );
      },
    );
  }
}
