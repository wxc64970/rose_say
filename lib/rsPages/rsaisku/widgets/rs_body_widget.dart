import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rose_say/rsCommon/index.dart';
import 'package:rose_say/rsPages/rsgems/widgets/rs_tag_widget.dart';

import '../index.dart';

/// hello
class RSBodyWidget extends GetView<RsaiskuController> {
  const RSBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        appBar(),
        SizedBox(height: 56.w),
        Obx(
          () => Expanded(
            child: GridView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              itemCount: controller.aiSkuList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 16.w,
                crossAxisSpacing: 16.w,
                childAspectRatio: 218 / 280,
              ),
              itemBuilder: (_, index) {
                final model = controller.aiSkuList[index];
                var count = 1;
                var countUni = '';
                var uniPart = '';

                if (controller.from == ConsumeFrom.aiphoto) {
                  count = model.createImg ?? 1;
                  countUni = RSTextData.ai_photos.toUpperCase();
                  uniPart = RSTextData.ai_photo_label;
                } else if (controller.from == ConsumeFrom.img2v) {
                  count = model.createVideo ?? 1;
                  countUni = RSTextData.ai_videos.toUpperCase();
                  uniPart = RSTextData.ai_video_label;
                }

                var rawPrice = model.productDetails?.rawPrice ?? 0;
                var oneRawPrice = rawPrice / count;
                double truncated = (oneRawPrice * 100).truncateToDouble() / 100;
                String formattedNumber = truncated.toStringAsFixed(2);
                var onePrice =
                    '${model.productDetails?.currencySymbol}$formattedNumber/$uniPart';

                List<Widget>? tags;
                if (model.tag == 1) {
                  tags = [RSGemTagWidgets(tag: RSTextData.bestChoice)];
                }
                if (model.tag == 2) {
                  tags = [RSGemTagWidgets(tag: RSTextData.ai_most_popular)];
                }
                return Obx(
                  () => InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      controller.selectedModel.value = model;
                      controller.buy();
                    },
                    child: Opacity(
                      opacity: model.sku == controller.selectedModel.value.sku
                          ? 1
                          : 0.5,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: 218.w,
                            padding: EdgeInsets.only(top: 56.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32.r),
                              color: const Color(0xff181B28),
                              border: Border.all(
                                width: 4.w,
                                color:
                                    controller.selectedModel.value.sku ==
                                        model.sku
                                    ? RSAppColors.primaryColor
                                    : Colors.transparent,
                              ),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  spacing: 6.w,
                                  children: [
                                    Text(
                                      count.toString(),
                                      style: TextStyle(
                                        fontSize: 28.sp,
                                        fontWeight: FontWeight.w600,
                                        color: RSAppColors.primaryColor,
                                      ),
                                    ),
                                    Text(
                                      countUni,
                                      style: TextStyle(
                                        fontSize: 28.sp,
                                        fontWeight: FontWeight.w400,
                                        color: RSAppColors.primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  spacing: 4.w,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "assets/images/rs_03.png",
                                      width: 24.w,
                                      fit: BoxFit.contain,
                                    ),
                                    Text(
                                      '${model.number ?? 0}',
                                      style: TextStyle(
                                        fontSize: 24.sp,
                                        fontWeight: FontWeight.w400,
                                        color: RSAppColors.primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 28.w),
                                Center(
                                  child: Text(
                                    model.productDetails?.price ?? '--',
                                    style: TextStyle(
                                      fontSize: 40.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8.w),
                                Text(
                                  onePrice,
                                  style: TextStyle(
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF617085),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (tags != null) ...tags,
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 52.w, vertical: 16.w),
              child: ButtonGradientWidget(
                onTap: controller.buy,
                height: 100,
                borderRadius: BorderRadius.circular(100.r),
                child: Center(
                  child: Text(
                    RSTextData.btnContinue,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w600,
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
              child: Text(
                RSTextData.ai_purchase_balance,
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
