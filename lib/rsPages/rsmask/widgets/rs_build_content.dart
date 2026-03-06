import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rose_say/rsCommon/index.dart';

import '../index.dart';

/// hello
class BuildContentWidget extends GetView<RsmaskController> {
  const BuildContentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EasyRefresh.builder(
      controller: controller.refreshController,
      onRefresh: controller.onRefresh,
      onLoad: controller.onLoad,
      childBuilder: (context, physics) {
        return SingleChildScrollView(
          physics: physics,
          padding: EdgeInsets.only(left: 32.w, right: 32.w),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 32.w, horizontal: 24.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40.r),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      const Color(0xff112036).withValues(alpha: 0.59),
                      const Color(0xff1A2E4C),
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          RSTextData.profileMaskDescription,
                          style: TextStyle(
                            fontSize: 24.sp,
                            color: RSAppColors.primaryColor,
                          ),
                        ),
                        SizedBox(height: 16.w),
                        Row(
                          children: [
                            ButtonGradientWidget(
                              width: 272.w,
                              height: 96,
                              onTap: () {
                                controller.pushEditPage();
                              },
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add,
                                      color: Colors.black,
                                      size: 28.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    SizedBox(width: 10.w),
                                    Text(
                                      RSTextData.create,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 28.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Image.asset(
                        "assets/images/rs_35.png",
                        width: 220.w,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.w),
              Obx(() {
                if (controller.state.maskList.isEmpty &&
                    controller.state.emptyType.value != null) {
                  return SizedBox(
                    width: double.infinity,
                    height: 400,
                    child: EmptyWidget(
                      type: controller.state.emptyType.value!,
                      paddingTop: 20,
                      physics: const NeverScrollableScrollPhysics(),
                      onReload:
                          controller.state.emptyType.value ==
                              EmptyType.noNetwork
                          ? () => controller.refreshController.callRefresh()
                          : null,
                    ),
                  );
                }
                if (controller.state.maskList.isNotEmpty) {
                  return _buildGridItems();
                }
                return const SizedBox(height: 400);
              }),
            ],
          ),
        );
      },
    );
  }

  Widget _buildGridItems() {
    return Obx(
      () => ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(0),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.state.maskList.length,
        itemBuilder: (_, index) {
          final item = controller.state.maskList[index];
          return _buildItem(item);
        },
      ),
    );
  }

  Widget _buildItem(RSMaskModel mask) {
    return Obx(() {
      final isSelected = controller.state.selectedMask.value?.id == mask.id;
      return GestureDetector(
        onTap: () {
          controller.selectMask(mask);
        },
        child: Container(
          clipBehavior: Clip.none,
          margin: EdgeInsets.only(top: 24.w),
          padding: EdgeInsets.all(24.w),
          decoration: BoxDecoration(
            color: const Color(0xff181B28),
            borderRadius: BorderRadius.circular(22.r),
            border: Border.all(
              width: 2.w,
              color: isSelected
                  ? RSAppColors.primaryColor
                  : const Color(0xff181B28),
            ),
          ),
          child: Row(
            spacing: 24.w,
            children: [
              Expanded(
                child: Row(
                  spacing: 16.w,
                  children: [
                    Image.asset(
                      Gender.fromValue(mask.gender).icon,
                      height: 40.w,
                      fit: BoxFit.contain,
                    ),
                    Expanded(
                      child: Column(
                        spacing: 8.w,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            mask.profileName ?? '',
                            style: TextStyle(
                              fontSize: 28.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            mask.description ?? '',
                            style: TextStyle(
                              fontSize: 24.sp,
                              color: RSAppColors.primaryColor,
                              fontWeight: FontWeight.w400,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () => controller.pushEditPage(mask: mask),
                child: Container(
                  width: 88.w,
                  height: 88.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.r),
                    border: Border.all(
                      width: 1.w,
                      color: const Color(0xffFFFFFF).withValues(alpha: 0.2),
                    ),
                    color: const Color(0xff181B28),
                  ),
                  child: Center(
                    child: Image.asset(
                      "assets/images/rs_40.png",
                      width: 36.w,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
