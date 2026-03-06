import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rose_say/rsCommon/index.dart';

import '../index.dart';

/// hello
class RSBodyWidget extends GetView<RseditmaskController> {
  const RSBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        appBar(),
        SizedBox(height: 20.w),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(left: 32.w, right: 32.w),
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
                      Obx(
                        () => _buildTitle(
                          RSTextData.yourName,
                          subtitle:
                              '(${controller.nameLength.value}/${RseditmaskController.maxNameLength})',
                        ),
                      ),
                      SizedBox(height: 21.w),
                      _buildTextFieldContainer(
                        child: TextField(
                          controller: controller.nameController,
                          maxLength: RseditmaskController.maxNameLength,
                          inputFormatters: [_NoLeadingSpaceFormatter()],
                          decoration: _buildInputDecoration(
                            RSTextData.nameHint,
                          ),
                          style: _buildTextStyle(),
                        ),
                      ),
                    ],
                  ),
                ),
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
                      _buildTitle(RSTextData.yourGender),
                      SizedBox(height: 21.w),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          _buildGenderOption(Gender.female),
                          SizedBox(width: 18.w),
                          _buildGenderOption(Gender.male),
                          SizedBox(width: 18.w),
                          _buildGenderOption(Gender.nonBinary),
                        ],
                      ),
                    ],
                  ),
                ),
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
                      _buildTitle(RSTextData.yourAge, query: false),
                      SizedBox(height: 21.w),
                      _buildTextFieldContainer(
                        child: TextField(
                          controller: controller.ageController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(5),
                            _AgeInputFormatter(),
                          ],
                          decoration: _buildInputDecoration(RSTextData.ageHint),
                          style: _buildTextStyle(),
                        ),
                      ),
                    ],
                  ),
                ),
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
                      Obx(
                        () => _buildTitle(
                          RSTextData.description,
                          subtitle:
                              '(${controller.descriptionLength.value}/${RseditmaskController.maxDescriptionLength})',
                          query: true,
                        ),
                      ),
                      SizedBox(height: 21.w),
                      _buildMultilineTextFieldContainer(
                        child: TextField(
                          controller: controller.descriptionController,
                          maxLength: RseditmaskController.maxDescriptionLength,
                          maxLines: null,
                          inputFormatters: [_NoLeadingSpaceFormatter()],
                          decoration: _buildInputDecoration(
                            RSTextData.descriptionHint,
                          ),
                          style: _buildTextStyle(),
                        ),
                      ),
                    ],
                  ),
                ),

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
                      Obx(
                        () => _buildTitle(
                          RSTextData.otherInfo,
                          subtitle:
                              '(${controller.otherInfoLength.value}/${RseditmaskController.maxOtherInfoLength})',
                          query: false,
                        ),
                      ),
                      SizedBox(height: 21.w),
                      _buildMultilineTextFieldContainer(
                        child: TextField(
                          controller: controller.otherInfoController,
                          maxLength: RseditmaskController.maxOtherInfoLength,
                          maxLines: null,
                          inputFormatters: [_NoLeadingSpaceFormatter()],
                          decoration: _buildInputDecoration(
                            RSTextData.otherInfoHint,
                          ),
                          style: _buildTextStyle(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 52.w, vertical: 16.w),
              child: ButtonGradientWidget(
                onTap: controller.saveMask,
                height: 96,
                borderRadius: BorderRadius.circular(100.r),
                child: !controller.isEditMode
                    ? Stack(
                        fit: StackFit.expand,
                        alignment: Alignment.center,
                        clipBehavior: Clip.none,
                        children: [
                          // Text(
                          //   '${controller.createCost}',
                          //   style: TextStyle(color: Colors.white, fontSize: 32.sp, fontWeight: FontWeight.w500),
                          // ),
                          Center(
                            child: Text(
                              RSTextData.create,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 28.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      )
                    : Center(
                        child: Text(
                          RSTextData.save,
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
                RSTextData.createProfileMask,
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

  Widget _buildTitle(String title, {String? subtitle, bool query = true}) {
    return Row(
      spacing: 2,
      children: [
        Image.asset(
          "assets/images/rs_39.png",
          width: 30.w,
          fit: BoxFit.contain,
        ),
        SizedBox(width: 12.w),
        Text(
          title,
          style: TextStyle(
            fontSize: 28.sp,
            color: Colors.white.withValues(alpha: 0.8),
            fontWeight: FontWeight.w500,
          ),
        ),
        if (query)
          Text(
            '*',
            style: TextStyle(
              fontSize: 28.sp,
              color: Color(0xFFFF2A75),
              fontWeight: FontWeight.w600,
            ),
          ),
        if (subtitle != null)
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 24.sp,
              color: Colors.white.withValues(alpha: 0.8),
              fontWeight: FontWeight.w500,
            ),
          ),
      ],
    );
  }

  /// 构建文本输入框容器
  Widget _buildTextFieldContainer({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xff333B47),
        borderRadius: BorderRadius.circular(16.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: child,
    );
  }

  /// 构建输入框装饰
  InputDecoration _buildInputDecoration(String hintText) {
    return InputDecoration(
      counterText: '',
      hintText: hintText,
      border: InputBorder.none,
      hintStyle: TextStyle(
        color: const Color(0xFF617085),
        fontSize: 24.sp,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  /// 构建文本样式
  TextStyle _buildTextStyle() {
    return TextStyle(
      color: const Color(0xffFFFFFF),
      fontSize: 24.sp,
      fontWeight: FontWeight.w400,
    );
  }

  /// 构建多行文本输入框容器
  Widget _buildMultilineTextFieldContainer({required Widget child}) {
    return Container(
      constraints: BoxConstraints(minHeight: 192.w),
      decoration: BoxDecoration(
        color: const Color(0xff333B47),
        borderRadius: BorderRadius.circular(16.r),
      ),
      padding: EdgeInsets.all(24.w),
      child: child,
    );
  }

  /// 构建性别选项
  Widget _buildGenderOption(Gender gender) {
    return Obx(() {
      final isSelected = controller.selectedGender.value == gender;
      return GestureDetector(
        onTap: () {
          controller.selectGender(gender);
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16.w, horizontal: 28.w),
          decoration: BoxDecoration(
            color: const Color(0xff333B47),
            borderRadius: BorderRadius.circular(60.r),
            border: Border.all(
              width: 2.w,
              color: isSelected
                  ? RSAppColors.primaryColor
                  : const Color(0xff333B47),
            ),
          ),
          child: Row(
            children: [
              Image.asset(
                gender.icon,
                height: 40.w,
                fit: BoxFit.contain,
                // color: isSelected ? null : Color(0xffB3B3B3),
                // color: isSelected ? Colors.white : Colors.white60,
              ),
              SizedBox(height: 8.w),
              Text(
                gender.display,
                style: TextStyle(
                  // color: isSelected
                  //     ? gender.display == RSTextData.male
                  //           ? RSAppColors.primaryColor
                  //           : gender.display == RSTextData.female
                  //           ? RSAppColors.pinkColor
                  //           : RSAppColors.yellowColor
                  //     : Color(0xffB3B3B3),
                  color: isSelected ? Colors.white : Colors.white60,
                  fontSize: 24.sp,
                ),
              ),
            ],
          ),
        ),
      );
    });
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

class _AgeInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    final int? value = int.tryParse(newValue.text);
    if (value == null || value > 99999) {
      return oldValue;
    }

    return newValue;
  }
}
