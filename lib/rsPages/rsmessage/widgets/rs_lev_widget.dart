import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rose_say/rsCommon/index.dart';

import '../index.dart';

/// hello
class RSLelWidget extends GetView<RsmessageController> {
  const RSLelWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final data = controller.state.chatLevel.value;
      if (data == null) {
        return const SizedBox();
      }

      var level = data.level ?? 1;
      var progress = (data.progress ?? 0) / 100.0;
      var rewards = '+${data.rewards ?? 0}';

      var value = controller.formatNumber(data.progress);
      // var total = data.upgradeRequirements?.toInt() ?? 0;
      // var proText = '$value/$total';

      return GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
          // AppRoutes.pushProfile(ctr.role);
          Get.toNamed(RSRouteNames.profile, arguments: controller.state.role);
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 32.w),
          padding: EdgeInsets.symmetric(vertical: 12.w, horizontal: 24.w),
          decoration: BoxDecoration(
            border: Border.all(
              width: 2.w,
              color: const Color(0xffFFFFFF).withValues(alpha: 0.23),
            ),
            borderRadius: BorderRadius.circular(32.r),
            color: const Color(0xff181B28).withValues(alpha: 0.9),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Lv $level',
                              style: TextStyle(
                                fontSize: 28.sp,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 16.w),
                            Text(
                              '$value%',
                              style: TextStyle(
                                fontSize: 22.sp,
                                fontWeight: FontWeight.w500,
                                color: const Color.fromARGB(255, 146, 146, 146),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 19.w),
                    RSAnimationProgress(
                      progress: progress,
                      height: 12.w,
                      borderRadius: 24.w,
                      // width: Get.width,
                    ),
                    SizedBox(height: 12.w),
                  ],
                ),
              ),
              SizedBox(width: 60.w),
              Container(
                padding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 16.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(58.r),
                  color: const Color(0xffCCDEFF).withValues(alpha: 0.1),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/images/rs_03.png",
                      width: 32.w,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      rewards,
                      style: TextStyle(
                        fontSize: 28.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
