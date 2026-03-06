import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:rose_say/rsCommon/index.dart';

class SettingMessageBackground extends StatelessWidget {
  const SettingMessageBackground({
    super.key,
    required this.onTapUpload,
    required this.onTapUseChat,
    required this.isUseChater,
  });

  final VoidCallback onTapUpload;
  final VoidCallback onTapUseChat;
  final bool isUseChater;

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
                SmartDialog.dismiss();
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
          margin: EdgeInsets.symmetric(horizontal: 32.w, vertical: 32.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32.r),
            gradient: LinearGradient(
              begin: AlignmentDirectional.topCenter,
              end: AlignmentDirectional.bottomCenter,
              colors: [
                const Color(0xffFFFFFF).withValues(alpha: 0.3),
                const Color(0xffFFFFFF).withValues(alpha: 0.2),
                const Color(0xff0C3244).withValues(alpha: 0.1),
              ],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(2.w),
            child: Container(
              width: Get.width,
              padding: EdgeInsets.symmetric(vertical: 48.w, horizontal: 32.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32.r),
                gradient: LinearGradient(
                  begin: AlignmentDirectional.topCenter,
                  end: AlignmentDirectional.bottomCenter,
                  colors: [
                    const Color(0xff112036).withValues(alpha: 1.0),
                    const Color(0xff1A2E4C),
                  ],
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
                    child: Center(
                      child: Text(
                        RSTextData.setChatBackground,
                        style: TextStyle(
                          fontSize: 32.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  _buildItem(
                    RSTextData.uploadAPhoto,
                    !isUseChater,
                    onTap: onTapUpload,
                  ),
                  SizedBox(height: 16.w),
                  _buildItem(
                    RSTextData.useAvatar,
                    isUseChater,
                    onTap: onTapUseChat,
                  ),
                  SizedBox(height: 60.w),
                ],
              ),
            ),
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
