import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rose_say/rsCommon/index.dart';

import '../../index.dart';
import 'rs_discover_list.dart';

class RSBodyWidget extends GetView<RsdiscoverController> {
  const RSBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () => Get.toNamed(RSRouteNames.search),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(58.r),
                    child: BackdropFilter(
                      blendMode: BlendMode.srcIn,
                      filter: ImageFilter.blur(
                        sigmaX: 8.w, // 水平模糊度（对应 blur 10px）
                        sigmaY: 8.w, // 垂直模糊度（对应 blur 10px）
                      ),
                      // 关键2：实现 box-shadow + 背景半透（需嵌套 Container）
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 24.w,
                          horizontal: 32.w,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(58.r),
                          color: const Color(0xffCCDEFF).withValues(alpha: 0.1),
                          border: Border.all(
                            width: 1.w,
                            color: const Color(0xff61709D),
                          ),
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/images/rs_05.png",
                              width: 40.w,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(width: 16.w),
                            Container(
                              width: 2.w,
                              height: 32.w,
                              color: const Color(
                                0xffFFFFFF,
                              ).withValues(alpha: 0.4),
                            ),
                            SizedBox(width: 16.w),
                            Text(
                              RSTextData.seach,
                              style: TextStyle(
                                fontSize: 24.sp,
                                color: const Color(
                                  0xffFFFFFF,
                                ).withValues(alpha: 0.4),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 24.w),
              Obx(() {
                return !RS.login.vipStatus.value
                    ? InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          Get.toNamed(
                            RSRouteNames.vip,
                            arguments: VipFrom.homevip,
                          );
                        },
                        child: ClipRect(
                          child: BackdropFilter(
                            blendMode: BlendMode.srcIn,
                            filter: ImageFilter.blur(
                              sigmaX: 8.w, // 水平模糊度（对应 blur 10px）
                              sigmaY: 8.w, // 垂直模糊度（对应 blur 10px）
                            ),
                            // 关键2：实现 box-shadow + 背景半透（需嵌套 Container）
                            child: Container(
                              padding: EdgeInsets.all(8.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100.r),
                                color: const Color(
                                  0xffCCDEFF,
                                ).withValues(alpha: 0.12),
                                border: Border.all(
                                  width: 1.w,
                                  color: Colors.white.withValues(alpha: 0.23),
                                ),
                              ),
                              child: Image.asset(
                                "assets/images/rs_02.png",
                                width: 48.w,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      )
                    : const SizedBox.shrink();
              }),
            ],
          ),
          SizedBox(height: 36.w),
          const Expanded(child: BuildDiscoveryList()),
        ],
      ),
    );
  }
}
