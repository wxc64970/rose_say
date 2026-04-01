import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rose_say/rsCommon/index.dart';

import '../index.dart';

/// hello
class RSOptionSheet extends GetView<RsprofileController> {
  const RSOptionSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: () {
                Get.back();
              },
              child: Padding(
                padding: EdgeInsets.all(32.w),
                child: Image.asset(
                  "assets/images/rs_close.png",
                  width: 56.w,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
        Container(
          width: Get.width,
          padding: EdgeInsets.symmetric(vertical: 24.w, horizontal: 32.w),
          margin: EdgeInsets.symmetric(horizontal: 32.w),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/rs_42.png"),
              fit: BoxFit.fitWidth,
              alignment: AlignmentGeometry.topCenter,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 0,
                ).copyWith(bottom: 88.w),
                child: SizedBox(
                  width: 300.w,
                  child: Row(
                    spacing: 8.w,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Transform(
                        // 核心：skewX(角度)，角度单位为弧度（π/180 × 角度值）
                        // 示例：斜切20°（π/180×20≈0.349），负数为反向斜切
                        transform: Matrix4.skewX(-0.349),
                        // 对齐方式：避免变换后位置偏移
                        alignment: Alignment.center,
                        child: Container(
                          width: 10.w,
                          height: 13.w,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xff43FFF4), Color(0xffDAF538)],
                            ),
                          ),
                        ),
                      ),
                      Text(
                        RSTextData.optionTitle,
                        style: TextStyle(
                          fontSize: 32.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      Transform(
                        // 核心：skewX(角度)，角度单位为弧度（π/180 × 角度值）
                        // 示例：斜切20°（π/180×20≈0.349），负数为反向斜切
                        transform: Matrix4.skewX(-0.349),
                        // 对齐方式：避免变换后位置偏移
                        alignment: Alignment.center,
                        child: Container(
                          width: 10.w,
                          height: 13.w,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xff43FFF4), Color(0xffDAF538)],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 32.w),
              GestureDetector(
                onTap: controller.clearHistory,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 32.w),
                  decoration: BoxDecoration(
                    color: Colors.white12,
                    borderRadius: BorderRadius.circular(32.r),
                  ),
                  child: Center(
                    child: Text(
                      RSTextData.clearHistory,
                      style: TextStyle(
                        color: RSAppColors.primaryColor,
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 32.w),
              GestureDetector(
                onTap: controller.handleReport,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 32.w),
                  decoration: BoxDecoration(
                    color: Colors.white12,
                    borderRadius: BorderRadius.circular(32.r),
                  ),
                  child: Center(
                    child: Text(
                      RSTextData.report,
                      style: TextStyle(
                        color: RSAppColors.primaryColor,
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40.w),
              ButtonGradientWidget(
                height: 96,
                width: Get.width,
                onTap: controller.deleteChat,
                borderRadius: BorderRadius.circular(78.r),
                child: Center(
                  child: Text(
                    RSTextData.deleteChat,
                    style: TextStyle(
                      fontSize: 32.sp,
                      color: const Color(0xff090E57),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 60.w),
            ],
          ),
        ),
        // SizedBox(height: 32.w),
      ],
    );
  }
}
