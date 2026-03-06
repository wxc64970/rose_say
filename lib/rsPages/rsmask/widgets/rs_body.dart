import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rose_say/rsCommon/index.dart';

import '../index.dart';
import 'rs_build_content.dart';

/// hello
class RSBodyWidget extends GetView<RsmaskController> {
  const RSBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        appBar(),
        SizedBox(height: 24.w),
        const Expanded(child: BuildContentWidget()),
        Column(
          children: [
            Obx(
              () => Padding(
                padding: EdgeInsets.symmetric(horizontal: 52.w),
                child:
                    controller.state.maskList.isEmpty ||
                        controller.state.selectedMask.value == null
                    ? Container(
                        height: 100.w,
                        margin: EdgeInsets.symmetric(horizontal: 50.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100.r),
                          border: Border.all(
                            width: 2.w,
                            color: const Color(
                              0xffFFFFFF,
                            ).withValues(alpha: 0.2),
                          ),
                          color: const Color(0xffABC4E4).withValues(alpha: 0.3),
                        ),
                        child: Center(
                          child: Text(
                            RSTextData.pickIt,
                            style: TextStyle(
                              fontSize: 28.sp,
                              color: const Color(0xffABC4E4),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      )
                    : ButtonGradientWidget(
                        onTap: controller.handleChangeMask,
                        height: 100,
                        borderRadius: BorderRadius.circular(100.r),
                        child: Center(
                          child: Text(
                            RSTextData.pickIt,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 32.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
              ),
            ),
            SizedBox(height: Get.mediaQuery.padding.bottom),
          ],
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
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 500.w),
                child: Text(
                  RSTextData.selectProfileMask,
                  style: TextStyle(
                    fontSize: 36.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
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
