import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rose_say/rsCommon/index.dart';

/// hello
class RSReportSheet extends StatelessWidget {
  const RSReportSheet({Key? key}) : super(key: key);

  Future<void> request() async {
    RSLoading.show();
    await Future.delayed(const Duration(seconds: 1));
    RSLoading.close();
    RSToast.show(RSTextData.reportSuccessful);
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, Function> actsion = {
      RSTextData.spam.tr: request,
      RSTextData.violence.tr: request,
      RSTextData.childAbuse.tr: request,
      RSTextData.copyright.tr: request,
      RSTextData.personalDetails.tr: request,
      RSTextData.illegalDrugs.tr: request,
    };

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: () {
                Get.back();
              },
              child: Image.asset(
                "assets/images/rs_close.png",
                width: 56.w,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(width: 32.w),
          ],
        ),
        SizedBox(height: 12.w),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 32.w),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/rs_24.png"),
              fit: BoxFit.fitWidth,
              alignment: AlignmentGeometry.topCenter,
            ),
            // borderRadius: BorderRadius.only(
            //   topLeft: Radius.circular(32.w),
            //   topRight: Radius.circular(32.w),
            // ),
            // color: Colors.white,
          ),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 24.w, horizontal: 32.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
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
                                    colors: [
                                      Color(0xff43FFF4),
                                      Color(0xffDAF538),
                                    ],
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
                                    colors: [
                                      Color(0xff43FFF4),
                                      Color(0xffDAF538),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ...List.generate(actsion.keys.length, (index) {
                      final fn = actsion.values.toList()[index];
                      return GestureDetector(
                        onTap: () async {
                          await fn.call();
                          Get.back();
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 32.w),
                          padding: EdgeInsets.symmetric(
                            horizontal: 36.w,
                            vertical: 24.w,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(
                              0xffFFFFFF,
                            ).withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(32.r),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Center(
                                  child: Text(
                                    actsion.keys.toList()[index],
                                    style: TextStyle(
                                      color: const Color(0xFFABC4E4),
                                      fontSize: 32.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                    SizedBox(height: Get.mediaQuery.padding.bottom + 20.w),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
