import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RsBackWidget extends StatelessWidget {
  const RsBackWidget({super.key, this.child, this.onBackPressed});

  final Widget? child;
  final Function()? onBackPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onBackPressed,
      child: Container(
        width: 80.w,
        height: 80.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.r),
          color: const Color(0xffCCDEFF).withValues(alpha: 0.1),
          border: Border.all(width: 1.w, color: const Color(0xff61709D)),
        ),
        child: Center(
          child: Image.asset(
            "assets/images/rs_back.png",
            width: 32.w,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
