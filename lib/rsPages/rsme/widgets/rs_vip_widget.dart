import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rose_say/rsCommon/index.dart';
import 'package:rose_say/rsPages/rsdiscover/widgets/rs_discover_list.dart';

import '../index.dart';

class RSVipWidget extends GetView<RsmeController> {
  const RSVipWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(32.w),
      width: Get.width,
      height: 208.w,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/rs_51.png'),
          fit: BoxFit.contain,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GradientText(
            text: RSTextData.vipMember,
            fontSize: 40.sp,
            fontWeight: FontWeight.w700,
            // 自定义渐变颜色
            gradientColors: const [
              Color(0xFFDAF9FF),
              Color(0xFFB5D4FF),
              Color(0xFFD3E4FF),
            ],
          ),
          SizedBox(height: 22.w),
          Container(
            width: 452.w,
            height: 2.w,
            color: const Color(0xff65A9FF).withValues(alpha: 0.2),
          ),
          SizedBox(height: 22.w),
          Obx(() {
            RS.login.vipStatus.value;
            final timer =
                RS.login.currentUser?.subscriptionEnd ??
                DateTime.now().millisecondsSinceEpoch;
            final date = formatTimestamp(timer);
            return Row(
              spacing: 16.w,
              children: [
                Image.asset(
                  "assets/images/rs_52.png",
                  width: 32.w,
                  fit: BoxFit.contain,
                ),
                Text.rich(
                  style: TextStyle(
                    fontSize: 24.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                  TextSpan(
                    children: [
                      TextSpan(text: RSTextData.deadline('')),
                      TextSpan(
                        text: date,
                        style: TextStyle(fontSize: 24.sp, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}
