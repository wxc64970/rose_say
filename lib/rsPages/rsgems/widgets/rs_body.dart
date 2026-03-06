import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rose_say/rsCommon/index.dart';

import '../index.dart';
import 'widgets.dart';

/// hello
class RSBodyWidget extends GetView<RsgemsController> {
  const RSBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/images/rs_56.png",
          width: Get.width,
          fit: BoxFit.contain,
        ),
        SizedBox(
          width: Get.width,
          height: Get.height,
          child: Padding(
            padding: EdgeInsets.only(
              top: Get.mediaQuery.padding.top + 16.w,
              left: 32.w,
              right: 32.w,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
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
                SizedBox(height: 32.w),
                Center(
                  child: Text(
                    RS.storage.isRSB
                        ? RSTextData.openChatsUnlock
                        : RSTextData.buyGemsOpenChats,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 48.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 80.w),
                const Expanded(child: RSItemListWidget()),
                Text(
                  RSTextData.oneTimePurchaseNote(
                    controller
                            .state
                            .chooseProduct
                            .value
                            .productDetails
                            ?.price ??
                        '--',
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24.sp,
                    color: const Color(0xff617085),
                  ),
                ),
                SizedBox(height: 24.w),
                ButtonGradientWidget(
                  height: 100,
                  width: Get.width,
                  onTap: controller.onTapBuy,
                  child: Center(
                    child: Text(
                      RS.storage.isRSB
                          ? RSTextData.btnContinue
                          : RSTextData.buy,
                      style: TextStyle(
                        fontSize: 32.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40.w),
                PolicyWidget(
                  type: RSPolicyBottomType.gems,
                  onConfirm: controller.help,
                ),
                SizedBox(height: Get.mediaQuery.padding.bottom + 16.w),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
