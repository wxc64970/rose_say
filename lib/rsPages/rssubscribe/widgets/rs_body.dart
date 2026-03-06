import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rose_say/rsCommon/index.dart';

import '../index.dart';
import 'rs_vip_list.dart';

/// hello
class RSBodyWidget extends GetView<RssubscribeController> {
  const RSBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/images/rs_59.png",
          width: Get.width,
          fit: BoxFit.contain,
        ),
        SizedBox(
          height: Get.height,
          width: Get.width,
          child: Padding(
            padding: EdgeInsets.only(
              left: 32.w,
              right: 32.w,
              top: Get.mediaQuery.padding.top + 16.w,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(
                      () => controller.showBackButton.value
                          ? GestureDetector(
                              onTap: () => Get.back(),
                              child: Container(
                                width: 80.w,
                                height: 80.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100.r),
                                  color: const Color(
                                    0xffCCDEFF,
                                  ).withValues(alpha: 0.1),
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
                            )
                          : const SizedBox(),
                    ),
                    GestureDetector(
                      onTap: () => RSPayUtils().restore(),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 8.w,
                          horizontal: 12.w,
                        ),
                        // margin: EdgeInsets.only(left: 24.w),
                        decoration: BoxDecoration(
                          color: const Color(0xffCCDEFF).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(100.r),
                          border: Border.all(
                            width: 1.w,
                            color: Colors.white.withValues(alpha: 0.23),
                          ),
                        ),
                        child: Text(
                          RSTextData.restore,
                          style: TextStyle(
                            fontSize: 28.sp,
                            color: const Color(0xFFFFFFFF),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40.w),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.zero,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          RSTextData.vipUpgrade,
                          style: TextStyle(
                            fontSize: 72.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 40.w),
                        Obx(
                          () => RSRichTextPlaceholder(
                            textKey: controller.contentText.value,
                            placeholders: {
                              'icon': WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: Image.asset(
                                  'assets/images/rs_60.png',
                                  width: 32.w,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            },
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24.sp,
                              height: 1.8,
                            ),
                          ),
                        ),
                        SizedBox(height: 80.w),
                        const RSVListWidget(),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 24.w),
                // if (RS.storage.isRSB) const TimerWidget(),
                if (!RS.storage.isRSB) _buildSubscriptionInfo(),
                SizedBox(height: 24.w),
                _buildPurchaseButton(),
                SizedBox(height: 24.w),
                PolicyWidget(
                  type: RS.storage.isRSB
                      ? RSPolicyBottomType.vip2
                      : RSPolicyBottomType.vip1,
                ),
                SizedBox(height: Get.mediaQuery.padding.bottom + 16.w),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPurchaseButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 52.w),
      child: ButtonGradientWidget(
        height: 100,
        width: Get.width,
        onTap: controller.purchaseSelectedProduct,
        child: Center(
          child: Text(
            RS.storage.isRSB ? RSTextData.btnContinue : RSTextData.subscribe,
            style: TextStyle(
              fontSize: 32.sp,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSubscriptionInfo() {
    return Container(
      constraints: const BoxConstraints(minHeight: 42),
      child: Obx(
        () => Center(
          child: Text(
            controller.subscriptionDescription,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color(0xff617085),
              fontSize: 18.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
