import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rose_say/rsCommon/index.dart';

import '../index.dart';
import 'rs_content_widget.dart';
import 'rs_no_vip_widget.dart';
import 'rs_vip_widget.dart';

class RSBodyWidget extends GetView<RsmeController> {
  const RSBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: Get.height,
      child: Padding(
        padding: EdgeInsets.only(left: 32.w, right: 32.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  "assets/images/rs_53.png",
                  width: 216.w,
                  fit: BoxFit.contain,
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.toNamed(
                          RSRouteNames.gems,
                          arguments: ConsumeFrom.home,
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 8.w,
                          horizontal: 12.w,
                        ),
                        // margin: EdgeInsets.only(left: 24.w),
                        decoration: BoxDecoration(
                          color: const Color(0xffCCDEFF).withValues(alpha: 0.1),
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
                  ],
                ),
              ],
            ),
            SizedBox(height: 54.w),
            Obx(() {
              return RS.login.vipStatus.value
                  ? const RSVipWidget()
                  : const RSNonVipWidget();
            }),
            SizedBox(height: 40.w),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(bottom: 0.w),
                child: const ContentWidget(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
