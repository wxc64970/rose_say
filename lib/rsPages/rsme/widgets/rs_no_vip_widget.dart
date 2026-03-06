import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rose_say/rsCommon/index.dart';
import 'package:rose_say/rsPages/rsdiscover/widgets/rs_discover_list.dart';

import '../index.dart';

class RSNonVipWidget extends GetView<RsmeController> {
  const RSNonVipWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 686.w,
      height: 480.w,
      padding: EdgeInsets.all(32.w),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/rs_44.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GradientText(
            text: RSTextData.upToVip,
            fontSize: 40.sp,
            fontWeight: FontWeight.w700,
            // 自定义渐变颜色
            gradientColors: const [
              Color(0xFFDAF9FF),
              Color(0xFFB5D4FF),
              Color(0xFFD3E4FF),
            ],
          ),
          SizedBox(height: 24.w),
          Container(
            width: 452.w,
            height: 2.w,
            color: const Color(0xff65A9FF).withValues(alpha: 0.2),
          ),
          SizedBox(height: 24.w),
          RSRichTextPlaceholder(
            textKey: RSTextData.vipGet1,
            placeholders: {
              'icon': WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Image.asset(
                  'assets/images/rs_50.png',
                  width: 32.w,
                  fit: BoxFit.contain,
                ),
              ),
            },
            style: TextStyle(
              fontSize: 24.sp,
              color: Colors.white,
              fontWeight: FontWeight.w400,
              height: 1.8,
            ),
          ),
          SizedBox(height: 32.w),
          ButtonGradientWidget(
            width: 622.w,
            height: 100,
            onTap: controller.onTapExprolreVIP,
            child: Center(
              child: Text(
                RSTextData.upToVip,
                style: TextStyle(
                  fontSize: 32.sp,
                  color: const Color(0xff090E57),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
