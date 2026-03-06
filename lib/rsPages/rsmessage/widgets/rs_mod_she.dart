import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rose_say/rsCommon/index.dart';

class RSModSheet extends StatelessWidget {
  const RSModSheet({super.key, required this.isLong, required this.onTap});

  final bool isLong;
  final Function(bool) onTap;

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
          width: Get.width,
          padding: EdgeInsets.symmetric(vertical: 24.w, horizontal: 32.w),
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
                        RSTextData.replyMode,
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
              _buildItem(
                RSTextData.shortReply,
                !isLong,
                onTap: () {
                  onTap(false);
                },
              ),
              SizedBox(height: 16.w),
              _buildItem(
                RSTextData.longReply,
                isLong,
                onTap: () {
                  onTap(true);
                },
              ),
              SizedBox(height: 60.w),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildItem(String title, bool isSelected, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 36.w, vertical: 32.w),
        decoration: BoxDecoration(
          color: const Color(0xffFFFFFF).withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(32.r),
          border: Border.all(
            width: 2.w,
            color: isSelected ? RSAppColors.primaryColor : Colors.transparent,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Image.asset(
                  //   "assets/images/sa_31.png",
                  //   width: 64.w,
                  //   fit: BoxFit.contain,
                  // ),
                  // SizedBox(width: 16.w),
                  Text(
                    title,
                    style: TextStyle(
                      color: isSelected
                          ? const Color(0xFFABC4E4)
                          : const Color(0xFF617085),
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            // isSelected
            //     ? Image.asset(
            //         "assets/images/sa_32.png",
            //         width: 40.w,
            //         fit: BoxFit.contain,
            //       )
            //     : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
