import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rose_say/rsCommon/index.dart';
import 'package:rose_say/rsPages/rsdiscover/widgets/rs_discover_list.dart';

class RSCallTitle extends StatelessWidget {
  const RSCallTitle({super.key, required this.role, this.onTapClose});

  final ChaterModel role;
  final VoidCallback? onTapClose;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 32.w,
        right: 32.w,
        top: Get.mediaQuery.padding.top + 16.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            spacing: 16.w,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2.w,
                    color: RSAppColors.primaryColor,
                  ),
                  borderRadius: BorderRadius.circular(100.r),
                ),
                child: RSImageWidget(
                  url: role.avatar,
                  width: 84.w,
                  height: 84.w,
                  shape: BoxShape.circle,
                  cacheWidth: 80,
                  cacheHeight: 80,
                  // borderRadius: BorderRadius.circular(10),
                ),
              ),
              Expanded(
                child: Row(
                  spacing: 16.w,
                  children: [
                    Container(
                      constraints: BoxConstraints(maxWidth: 300.w),
                      child: Text(
                        role.name ?? '',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 36.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    if (role.age != null)
                      GradientText(
                        text: RSTextData.ageYearsOlds(role.age.toString()),
                        fontSize: 20.sp,
                        // 自定义渐变颜色
                        gradientColors: const [
                          Color(0xFF43FFF4),
                          Color(0xFFDAF538),
                        ],
                      ),
                  ],
                ),
              ),
              InkWell(
                onTap: onTapClose,
                child: Container(
                  width: 64.w,
                  height: 64.w,
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
    );
  }
}
