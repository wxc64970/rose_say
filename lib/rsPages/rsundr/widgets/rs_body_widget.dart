import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rose_say/rsCommon/index.dart';
import 'package:rose_say/rsPages/rsaiphotob/widgets/rs_mak_widget.dart';

import '../index.dart';

/// hello
class RSBodyWidget extends GetView<RsundrController> {
  const RSBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        appBar(),
        SizedBox(height: 24.w),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            child: RSMakWidget(
              key: const ValueKey('page'),
              role: controller.role,
              type: RSAiViewType.role,
            ),
          ),
        ),
      ],
    );
  }

  Widget appBar() {
    return Padding(
      padding: EdgeInsets.only(left: 32.w, right: 32.w),
      child: Stack(
        children: [
          SizedBox(
            height: 80.w,
            child: Center(
              child: Text(
                RSTextData.undress,
                style: TextStyle(
                  fontSize: 36.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 0,
            child: GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                width: 80.w,
                height: 80.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.r),
                  color: const Color(0xffCCDEFF).withValues(alpha: 0.1),
                  border: Border.all(
                    width: 1.w,
                    color: const Color(0xff61709D),
                  ),
                ),
                child: Center(
                  child: Image.asset(
                    "assets/images/rs_back.png",
                    width: 32.w,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
