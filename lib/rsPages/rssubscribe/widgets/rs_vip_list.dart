import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rose_say/rsCommon/index.dart';

import '../index.dart';

/// hello
class RSVListWidget extends GetView<RssubscribeController> {
  const RSVListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final skuList = controller.skuList;

      if (skuList.isEmpty) {
        return _buildEmptyState();
      }

      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [_buildSkuList(skuList)],
      );
    });
  }

  /// 构建空状态
  Widget _buildEmptyState() {
    return Center(
      child: SizedBox(
        height: 100,
        child: Text(
          RSTextData.noSubscriptionAvailable,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  /// 构建SKU列表
  Widget _buildSkuList(List<RSSkModel> skuList) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      controller: controller.scrollController,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (_, index) {
        final sku = skuList[index];
        // final isBest = (sku.defaultSku ?? false) && RS.storage.isRSB;
        final isLifetime = sku.lifetime ?? false;
        final price = sku.productDetails?.price ?? '-';
        // final skuType = sku.skuType;
        // final tagMarginLeft = isBest ? 4.0 : 0.0;

        /// 获取SKU标题
        String getSkuTitle() {
          final skuType = sku.skuType;

          switch (skuType) {
            case 2:
              return RSTextData.monthly;
            case 3:
              return RSTextData.yearly;
            case 4:
              return RSTextData.lifetime;
            default:
              return '';
          }
        }

        return Obx(() {
          final isSelected = controller.selectedProduct.value?.sku == sku.sku;
          return GestureDetector(
            onTap: () {
              controller.selectProduct(sku);
            },
            child: Container(
              width: Get.width,
              // margin: EdgeInsets.only(bottom: 16.w),
              padding: EdgeInsets.symmetric(vertical: 32.w, horizontal: 32.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24.r),
                border: Border.all(
                  width: 2.w,
                  color: isSelected
                      ? const Color(0xffFFFFFF)
                      : const Color(0xffFFFFFF).withValues(alpha: 0.20),
                ),
              ),
              child: RS.storage.isRSB
                  ? RSbWidget(price, isLifetime, sku, getSkuTitle())
                  : RSaWidget(getSkuTitle(), price),
            ),
          );
        });
      },
      separatorBuilder: (_, index) => SizedBox(height: 24.w),
      itemCount: skuList.length,
    );
  }

  Widget RSaWidget(String getSkuTitle, String price) {
    return Row(
      spacing: 24.w,
      children: [
        ClipOval(
          child: Container(width: 16.w, height: 16.w, color: Colors.white),
        ),
        Text(
          getSkuTitle,
          style: TextStyle(fontSize: 28.sp, color: Colors.white),
        ),
        Text(
          '/',
          style: TextStyle(fontSize: 28.sp, color: Colors.white),
        ),
        Row(
          children: [
            Text(
              price,
              style: TextStyle(
                fontSize: 40.sp,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget RSbWidget(String price, bool isLifetime, sku, getSkuTitle) {
    if (isLifetime) {
      return lifetimeContentWidget(price, sku, getSkuTitle);
    } else {
      return subscriptionContentWidget(price, sku, getSkuTitle);
    }
  }

  Widget lifetimeContentWidget(String price, sku, getSkuTitle) {
    String numFixed(dynamic nums, {int position = 2}) {
      double num = nums is double ? nums : double.parse(nums.toString());
      String numString = num.toStringAsFixed(position);

      return numString.endsWith('.0')
          ? numString.substring(0, numString.lastIndexOf('.'))
          : numString;
    }

    final rawPrice = sku.productDetails?.rawPrice ?? 0;
    final symbol = sku.productDetails?.currencySymbol ?? '';
    final originalPrice = '$symbol${numFixed(rawPrice * 6, position: 2)}';
    final title = getSkuTitle;
    return Row(
      spacing: 24.w,
      children: [
        ClipOval(
          child: Container(width: 16.w, height: 16.w, color: Colors.white),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 28.sp,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            Row(
              children: [
                Image.asset(
                  "assets/images/rs_03.png",
                  width: 32.w,
                  fit: BoxFit.contain,
                ),
                SizedBox(width: 8.w),
                Text(
                  '+${sku.number}',
                  style: TextStyle(
                    fontSize: 28.sp,
                    color: RSAppColors.primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
        Text(
          '/',
          style: TextStyle(fontSize: 28.sp, color: Colors.white),
        ),
        Text(
          price,
          style: TextStyle(
            fontSize: 40.sp,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        //  SizedBox(width: 2),
        Text(
          originalPrice,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: const Color(0xff617085),
            fontSize: 24.sp,
            decoration: TextDecoration.lineThrough,
            decorationColor: const Color(0xff617085),
            decorationThickness: 3.w,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget subscriptionContentWidget(String price, sku, getSkuTitle) {
    String numFixed(dynamic nums, {int position = 2}) {
      double num = nums is double ? nums : double.parse(nums.toString());
      String numString = num.toStringAsFixed(position);

      return numString.endsWith('.0')
          ? numString.substring(0, numString.lastIndexOf('.'))
          : numString;
    }

    final rawPrice = sku.productDetails?.rawPrice ?? 0;
    final symbol = sku.productDetails?.currencySymbol ?? '';
    final title = getSkuTitle;

    String originalPrice;
    if (sku.skuType == 2) {
      final weekPrice = numFixed(rawPrice / 4, position: 2);
      originalPrice = '$symbol$weekPrice';
    } else {
      final weekPrice = numFixed(rawPrice / 48, position: 2);
      originalPrice = '$symbol$weekPrice';
    }
    return Row(
      spacing: 24.w,
      children: [
        ClipOval(
          child: Container(width: 16.w, height: 16.w, color: Colors.white),
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white,
            fontSize: 28.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          '/',
          style: TextStyle(fontSize: 28.sp, color: Colors.white),
        ),
        Text(
          price,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white,
            fontSize: 40.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
