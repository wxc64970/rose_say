import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rose_say/rsCommon/index.dart';

import '../../index.dart';
import 'rs_image_style_item.dart';

class RSBodyWidget extends GetView<RsaiphotoController> {
  const RSBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                "assets/images/rs_58.png",
                width: 200.w,
                fit: BoxFit.contain,
              ),
              Row(
                spacing: 16.w,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RSRouteNames.aiGenerateHistory);
                    },
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
                      child: Center(
                        child: Row(
                          children: [
                            // Image.asset(
                            //   "assets/images/rs_03.png",
                            //   width: 48.w,
                            //   fit: BoxFit.contain,
                            // ),
                            // SizedBox(width: 4.w),
                            Text(
                              RSTextData.creations,
                              style: TextStyle(
                                fontSize: 28.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(
                        RSRouteNames.gems,
                        arguments: ConsumeFrom.generateimage,
                      );
                    },
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
                      child: Center(
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/images/rs_03.png",
                              width: 48.w,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(width: 4.w),
                            Obx(
                              () => Text(
                                RS.login.gemBalance.toString(),
                                style: TextStyle(
                                  fontSize: 28.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 24.w),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(24.w),
                    margin: EdgeInsets.only(bottom: 24.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22.r),
                      color: const Color(0xff181B28),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              spacing: 2,
                              children: [
                                Image.asset(
                                  "assets/images/rs_39.png",
                                  width: 30.w,
                                  fit: BoxFit.contain,
                                ),
                                SizedBox(width: 12.w),
                                Text(
                                  RSTextData.description,
                                  style: TextStyle(
                                    fontSize: 28.sp,
                                    color: Colors.white.withValues(alpha: 0.8),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () => controller.clearDescription(),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 8.w,
                                  horizontal: 12.w,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.r),
                                  color: const Color(0xff333B47),
                                ),
                                child: Row(
                                  spacing: 8.w,
                                  children: [
                                    const Icon(
                                      Icons.delete_outline,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      RSTextData.clear,
                                      style: TextStyle(
                                        fontSize: 24.sp,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 21.w),
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xff333B47),
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(
                                () => TextField(
                                  controller: controller.descriptionController,
                                  maxLength:
                                      RseditmaskController.maxOtherInfoLength,
                                  maxLines: 5,
                                  minLines: 5,
                                  cursorColor: Colors.white,
                                  inputFormatters: [_NoLeadingSpaceFormatter()],
                                  decoration: _buildInputDecoration(),
                                  style: _buildTextStyle(),
                                ),
                              ),
                              SizedBox(height: 16.w),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () => controller.handleAIWrite(),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 8.w,
                                        horizontal: 12.w,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          16.r,
                                        ),
                                        color: const Color(
                                          0xffFFFFFF,
                                        ).withValues(alpha: 0.2),
                                      ),
                                      child: Row(
                                        spacing: 8.w,
                                        children: [
                                          const Icon(
                                            Icons.edit_note_outlined,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            RSTextData.aiWrite,
                                            style: TextStyle(
                                              fontSize: 24.sp,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Obx(
                                    () => Text(
                                      '${controller.descriptionLength.value}/${controller.maxDescriptionLength}',
                                      style: TextStyle(
                                        fontSize: 24.sp,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16.w),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(24.w),
                    margin: EdgeInsets.only(bottom: 24.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24.r),
                      color: const Color(0xff181B28),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              spacing: 2,
                              children: [
                                Image.asset(
                                  "assets/images/rs_39.png",
                                  width: 30.w,
                                  fit: BoxFit.contain,
                                ),
                                SizedBox(width: 12.w),
                                Text(
                                  RSTextData.imageStyle,
                                  style: TextStyle(
                                    fontSize: 28.sp,
                                    color: Colors.white.withValues(alpha: 0.8),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: (120 * 2).w,
                              height: 40.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                color: const Color(0xff333B47),
                              ),
                              child: Row(
                                children: [
                                  _buildImagesStyleOption(RSTextData.real),
                                  _buildImagesStyleOption(RSTextData.fantasy),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 21.w),
                        Obx(
                          () => SizedBox(
                            width: Get.width,
                            height: 168.w,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: controller.imageStyleData.length,
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index) {
                                return imageStyleItem(
                                  data: controller.imageStyleData[index],
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(24.w),
                    margin: EdgeInsets.only(bottom: 24.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24.r),
                      color: const Color(0xff181B28),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              spacing: 2,
                              children: [
                                Image.asset(
                                  "assets/images/rs_39.png",
                                  width: 30.w,
                                  fit: BoxFit.contain,
                                ),
                                SizedBox(width: 12.w),
                                Text(
                                  RSTextData.numberofimages,
                                  style: TextStyle(
                                    fontSize: 28.sp,
                                    color: Colors.white.withValues(alpha: 0.8),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: (100 * 2).w,
                              height: 40.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                color: const Color(0xff333B47),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  _buildMinusWidget(),
                                  Obx(
                                    () => Text(
                                      controller.numberOfImages.toString(),
                                      style: TextStyle(
                                        fontSize: 28.sp,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  _buildPlusWidget(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(24.w),
                    margin: EdgeInsets.only(bottom: 24.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24.r),
                      color: const Color(0xff181B28),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              spacing: 2,
                              children: [
                                Image.asset(
                                  "assets/images/rs_39.png",
                                  width: 30.w,
                                  fit: BoxFit.contain,
                                ),
                                SizedBox(width: 12.w),
                                Text(
                                  RSTextData.imageRatio,
                                  style: TextStyle(
                                    fontSize: 28.sp,
                                    color: Colors.white.withValues(alpha: 0.8),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 21.w),
                        _buildImageRatioWidget(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          ButtonGradientWidget(
            onTap: controller.createImage,
            height: 100,
            borderRadius: BorderRadius.circular(100.r),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  RSTextData.create,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 32.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 16.w),
                Image.asset(
                  "assets/images/rs_03.png",
                  width: 32.w,
                  fit: BoxFit.contain,
                ),
                Obx(
                  () => Text(
                    controller.coins,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: Get.mediaQuery.padding.bottom),
        ],
      ),
    );
  }

  Widget _buildImageRatioWidget() {
    return SizedBox(
      width: Get.width,
      height: 60.w,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: controller.imageRatioList.length,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          var item = controller.imageRatioList[index];
          return Obx(
            () => GestureDetector(
              onTap: () {
                controller.selectImageRatio = item;
              },
              child: Container(
                width: 140.w,
                height: 60.w,
                margin: index + 1 != controller.imageRatioList.length
                    ? EdgeInsets.only(right: 20.w)
                    : null,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  color: const Color(0xff333B47),
                  border: controller.selectImageRatio == item
                      ? Border.all(width: 2.w, color: Colors.white)
                      : null,
                ),
                child: Row(
                  spacing: 8.w,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.image,
                      color: controller.selectImageRatio == item
                          ? Colors.white
                          : RSAppColors.primaryColor,
                      size: 30.sp,
                    ),
                    Text(
                      item,
                      style: TextStyle(
                        fontSize: 28.sp,
                        color: controller.selectImageRatio == item
                            ? Colors.white
                            : RSAppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMinusWidget() {
    return GestureDetector(
      onTap: () => controller.handleNumberOfImages(0),
      child: Container(
        height: 40.w,
        padding: EdgeInsets.symmetric(horizontal: 16.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: const Color(0xff617085),
        ),
        child: Obx(
          () => Center(
            child: Icon(
              Icons.remove,
              color: controller.numberOfImages == 1
                  ? Colors.white38
                  : Colors.white,
              size: 32.sp,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlusWidget() {
    return GestureDetector(
      onTap: () => controller.handleNumberOfImages(1),
      child: Container(
        height: 40.w,
        padding: EdgeInsets.symmetric(horizontal: 16.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: const Color(0xff617085),
        ),
        child: Obx(
          () => Center(
            child: Icon(
              Icons.add,
              color: controller.numberOfImages == 4
                  ? Colors.white38
                  : Colors.white,
              size: 32.sp,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImagesStyleOption(imageStyle) {
    return Obx(() {
      final isSelected = controller.imageStyleTabs == imageStyle;
      return GestureDetector(
        onTap: () {
          controller.selectImageStyleTab(imageStyle);
        },
        child: Container(
          width: 120.w,
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xff617085)
                : const Color(0xff333B47),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Center(
            child: Text(
              imageStyle,
              style: TextStyle(
                color: isSelected ? Colors.white : RSAppColors.primaryColor,
                fontSize: 22.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      );
    });
  }

  /// 构建文本样式
  TextStyle _buildTextStyle() {
    return TextStyle(
      color: const Color(0xffFFFFFF),
      fontSize: 24.sp,
      fontWeight: FontWeight.w400,
    );
  }

  InputDecoration _buildInputDecoration() {
    return InputDecoration(
      counterText: '',
      hintText: controller.defaultDescription,
      border: InputBorder.none,
      hintStyle: TextStyle(
        color: const Color(0xFF617085),
        fontSize: 24.sp,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}

class _NoLeadingSpaceFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // 如果新值为空，直接返回
    if (newValue.text.isEmpty) {
      return newValue;
    }

    // 只阻止第一个字符前面的空格
    // 如果文本以空格开头，且这是新输入的空格，则阻止
    if (newValue.text.startsWith(' ') && !oldValue.text.startsWith(' ')) {
      return oldValue;
    }

    return newValue;
  }
}
