import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:rose_say/rsCommon/index.dart';

class RSMakLoading extends StatelessWidget {
  const RSMakLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF000000).withValues(alpha: 0.6),
      width: double.infinity,
      padding: EdgeInsets.all(30.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LoadingAnimationWidget.flickr(
            leftDotColor: RSAppColors.primaryColor,
            rightDotColor: Color(0xffDB4ECF),
            size: 40.w,
          ),
          SizedBox(height: 32.w),
          Text(
            RSTextData.ai_generating,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 32.w),
          Text(
            RSTextData.ai_generating_masterpiece,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.8),
              fontSize: 28.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 32.w),
          Text(
            RSTextData.ai_art_consumes_power,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.6),
              fontSize: 28.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
