import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget rsBaseScaffold({Widget? body}) {
  return Scaffold(
    backgroundColor: const Color(0xff0B0B0B),
    resizeToAvoidBottomInset: true, // 确保键盘弹出时正确调整布局
    body: Stack(
      children: [
        Image.asset(
          'assets/images/rs_04.png',
          width: Get.width,
          fit: BoxFit.contain,
        ),
        SizedBox(
          width: Get.width,
          height: Get.height,
          child: Padding(
            padding: EdgeInsets.only(top: Get.mediaQuery.padding.top + 16.w),
            child: body,
          ),
        ),
      ],
    ),
  );
}

Widget rsBaseScaffold2({Widget? body}) {
  return Scaffold(
    backgroundColor: const Color(0xff0B0B0B),
    resizeToAvoidBottomInset: true, // 确保键盘弹出时正确调整布局
    body: Stack(
      children: [
        Image.asset(
          'assets/images/rs_07.png',
          width: Get.width,
          fit: BoxFit.contain,
        ),
        SizedBox(
          width: Get.width,
          height: Get.height,
          child: Padding(
            padding: EdgeInsets.only(top: Get.mediaQuery.padding.top + 16.w),
            child: body,
          ),
        ),
      ],
    ),
  );
}
