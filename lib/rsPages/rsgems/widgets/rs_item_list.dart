import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rose_say/rsCommon/index.dart';

import '../index.dart';
import 'widgets.dart';

/// hello
class RSItemListWidget extends GetView<RsgemsController> {
  const RSItemListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.state.list.isEmpty) {
        return Center(
          child: SizedBox(
            height: 200.w,
            child: Text(
              RSTextData.noSubscriptionAvailable,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.black),
            ),
          ),
        );
      }
      return GridView.builder(
        itemCount: controller.state.list.length,
        padding: EdgeInsets.zero,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 46.w,
          crossAxisSpacing: 16.w,
          crossAxisCount: 3,
          childAspectRatio: 218 / 280,
        ),
        itemBuilder: (context, index) {
          final item = controller.state.list[index];
          final bestChoice = item.tag == 1;

          // 根据产品信息计算折扣百分比，从90%到0%以20%为步长递减
          // 使用算法计算：90 - (index * 20)，确保不小于0
          int discountPercent = math.max(0, 90 - (index * 20));

          String discount = controller.getDiscount(discountPercent);
          String numericPart = item.number.toString();
          String price = item.productDetails?.price ?? '--';

          List<Widget>? tags;
          if (bestChoice) {
            tags = [RSGemTagWidgets(tag: RSTextData.bestChoice)];
          }
          return Obx(
            () => InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () => controller.onTapChoose(item),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32.r),
                      color: const Color(0xff181B28),
                      border: Border.all(
                        width: 4.w,
                        color:
                            controller.state.chooseProduct.value.sku == item.sku
                            ? RSAppColors.primaryColor
                            : const Color(0xff181B28),
                      ),
                    ),
                    child: Column(
                      spacing: 26.w,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          spacing: 8.w,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/rs_03.png",
                              width: 48.w,
                              fit: BoxFit.contain,
                            ),
                            Text(
                              numericPart,
                              style: TextStyle(
                                fontSize: 40.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              discount,
                              style: TextStyle(
                                fontSize: 24.sp,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 10.w),
                            Text(
                              price,
                              style: TextStyle(
                                fontSize: 32.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (tags != null) ...tags,
                ],
              ),
            ),
          );
        },
      );
    });
  }
}
