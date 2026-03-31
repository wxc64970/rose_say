import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:rose_say/rsCommon/index.dart';

import '../index.dart';

/// hello
class RSFilterWidget extends GetView<RsdiscoverController> {
  const RSFilterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: () {
                SmartDialog.dismiss();
              },
              child: Image.asset(
                "assets/images/rs_close.png",
                width: 56.w,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(width: 32.w),
          ],
        ),
        SizedBox(height: 8.w),
        Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: Image.asset(
                "assets/images/rs_64.png",
                width: Get.width,
                fit: BoxFit.contain,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 24.w, horizontal: 56.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 0,
                    ).copyWith(bottom: 30.w),
                    child: Row(
                      spacing: 8.w,
                      children: [
                        Transform(
                          // 核心：skewX(角度)，角度单位为弧度（π/180 × 角度值）
                          // 示例：斜切20°（π/180×20≈0.349），负数为反向斜切
                          transform: Matrix4.skewX(-0.349),
                          // 对齐方式：避免变换后位置偏移
                          alignment: Alignment.center,
                          child: Container(
                            width: 10.w,
                            height: 13.w,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xff43FFF4), Color(0xffDAF538)],
                              ),
                            ),
                          ),
                        ),
                        Text(
                          RSTextData.chooseYourTags,
                          style: TextStyle(
                            fontSize: 32.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Transform(
                          // 核心：skewX(角度)，角度单位为弧度（π/180 × 角度值）
                          // 示例：斜切20°（π/180×20≈0.349），负数为反向斜切
                          transform: Matrix4.skewX(-0.349),
                          // 对齐方式：避免变换后位置偏移
                          alignment: Alignment.center,
                          child: Container(
                            width: 10.w,
                            height: 13.w,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xff43FFF4), Color(0xffDAF538)],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  tagTitleWidget(),
                  SizedBox(height: 32.w),
                  SizedBox(
                    height: 350.w,
                    child: SingleChildScrollView(
                      padding: EdgeInsets.zero,
                      child: Obx(() => tagsItemWidget()),
                    ),
                  ),
                  SizedBox(height: 40.w),
                  ButtonGradientWidget(
                    height: 96,
                    width: 536.w,
                    onTap: controller.handleFilterSubmit,
                    child: Center(
                      child: Text(
                        RSTextData.confirm,
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 32.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget tagTitleWidget() {
    var tags = controller.roleTags;
    if (tags.isEmpty) {
      return const SizedBox.shrink();
    }
    List<RSTagsModel> result = (tags.length > 2) ? tags.take(2).toList() : tags;

    RSTagsModel type1 = result[0];

    RSTagsModel? type2;
    if (result.length > 1) {
      type2 = result[1];
    }
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            spacing: 32.w,
            children: [
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  controller.selectedType.value = type1;
                },
                child: Obx(() => buildTitleItem(type1)),
              ),
              if (type2 != null)
                InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    controller.selectedType.value = type2;
                  },
                  child: Obx(() => buildTitleItem(type2!)),
                ),
            ],
          ),
          Obx(() {
            final tags = controller.selectedType.value?.tags;

            bool containsAll = false;
            if (tags != null && tags.isNotEmpty) {
              containsAll = controller.selectTags.containsAll(tags);
            }
            return TextButton(
              onPressed: () {
                if (containsAll) {
                  controller.selectTags.removeAll(tags ?? []);
                } else {
                  controller.selectTags.addAll(tags ?? []);
                }
              },
              child: Text(
                containsAll ? RSTextData.unselectAll : RSTextData.selectAll,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget buildTitleItem(RSTagsModel type) {
    bool isSelected = type == controller.selectedType.value;
    return Stack(
      children: [
        isSelected
            ? Positioned(
                bottom: 0,
                right: -10.w,
                width: 66.w,
                child: Center(
                  child: Image.asset(
                    "assets/images/rs_01.png",
                    fit: BoxFit.contain,
                  ),
                ),
              )
            : const SizedBox.shrink(),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              type.labelType ?? '',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: isSelected ? RSAppColors.primaryColor : Colors.white,
                fontSize: 28.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget tagsItemWidget() {
    final tags = controller.selectedType.value?.tags;
    if (tags == null || tags.isEmpty) {
      return const SizedBox();
    }
    return GridView.builder(
      itemCount: tags.length,
      shrinkWrap: true,
      padding: const EdgeInsets.all(0),
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 32.w,
        crossAxisSpacing: 16.w,
        childAspectRatio: 208 / 80,
      ),
      itemBuilder: (context, index) {
        var tag = tags[index];
        return GestureDetector(
          onTap: () {
            if (controller.selectTags.contains(tag)) {
              controller.selectTags.remove(tag);
            } else {
              controller.selectTags.add(tag);
            }
            controller.update();
          },
          child: buildItem(tag),
        );
      },
    );
  }

  Widget buildItem(TagModel tag) {
    return Obx(() {
      var isSelected = controller.selectTags.contains(tag);
      return Container(
        height: 80.w,
        width: 208.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16.r)),
          color: isSelected ? const Color(0xff617085) : const Color(0xff333B47),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Center(
              child: Text(
                tag.name ?? '',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isSelected ? Colors.white : RSAppColors.primaryColor,
                  fontSize: 28.sp,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            // if (isSelected)
            //   Positioned(
            //     top: -12.w,
            //     right: -12.w,
            //     child: Image.asset("assets/images/choose@2x.png", width: 48.w, height: 48.w),
            //   ),
          ],
        ),
      );
    });
  }
}
