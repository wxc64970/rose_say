import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RSGemTagWidgets extends StatelessWidget {
  const RSGemTagWidgets({super.key, required this.tag});

  final String tag;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -16.w,
      width: 218.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFFDBEBFF), Color(0xFFABC4E4)],
                  ),
                  borderRadius: BorderRadiusDirectional.only(
                    bottomStart: Radius.circular(24.r),
                    bottomEnd: Radius.circular(24.r),
                  ),
                ),
                child: Center(
                  child: Text(
                    tag,
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff090E57),
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
