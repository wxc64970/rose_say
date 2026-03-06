import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:rose_say/rsCommon/index.dart';

class RSUnLView extends StatelessWidget {
  const RSUnLView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        log.d('clicked vip space');
      },
      child: Container(
        color: Colors.transparent,
        margin: EdgeInsets.symmetric(horizontal: 86.w),
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(
                  "assets/images/rs_21.png",
                  width: Get.width,
                  fit: BoxFit.contain,
                ),
                Positioned(
                  top: 70.w,
                  right: 0,
                  left: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 36.w),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              RSTextData.unlockRole,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 32.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 74.w),
                            Text(
                              RSTextData.unlockRoleDescription,
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.8),
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 18.w),
                            Center(
                              child: Image.asset(
                                "assets/images/rs_22.png",
                                width: 192.w,
                                fit: BoxFit.contain,
                              ),
                            ),
                            SizedBox(height: 16.w),
                            ButtonGradientWidget(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    RSTextData.unlockNow,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 28.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () {
                                Get.toNamed(
                                  RSRouteNames.vip,
                                  arguments: VipFrom.viprole,
                                );
                              },
                            ),
                          ],
                        ),
                        // Positioned(
                        //   right: 0,
                        //   top: -150.w,
                        //   child: Image.asset(
                        //     "assets/images/sa_33.png",
                        //     fit: BoxFit.cover,
                        //     width: 200.w,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: SafeArea(
                    child: GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        color: Colors.transparent,
                        width: 60,
                        height: 44,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 48.w),
            InkWell(
              onTap: () {
                SmartDialog.dismiss();
                Get.back();
              },
              child: Image.asset(
                "assets/images/rs_close.png",
                width: 56.w,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
