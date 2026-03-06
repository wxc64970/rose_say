import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rose_say/rsCommon/index.dart';

import '../index.dart';

/// hello
class RSBodyWidget extends GetView<RsaigeneratehistoryController> {
  const RSBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        appBar(),
        SizedBox(height: 24.w),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            child: EasyRefresh.builder(
              controller: controller.refreshCtr,
              onRefresh: () => controller.onRefresh(),
              onLoad: () => controller.onLoad(),
              childBuilder: (context, physics) {
                return Obx(() {
                  final type = controller.type.value;
                  final list = controller.list;
                  if (type != null && list.isEmpty) {
                    return EmptyWidget(type: type);
                  }
                  return _buildList(physics, list);
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildList(ScrollPhysics physics, List<RSCreationsHistory> list) {
    return GridView.builder(
      physics: physics,
      // padding: const EdgeInsets.symmetric(horizontal: 12.0),
      padding: EdgeInsets.zero,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 16.w,
        mainAxisSpacing: 16.w,
        childAspectRatio: 218 / 290,
      ),
      itemCount: list.length,
      itemBuilder: (context, index) {
        return _buildItemCard(list[index]);
      },
    );
  }

  Widget _buildItemCard(RSCreationsHistory item) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          item.type == 1
              ? RSRouteNames.videoPreview
              : RSRouteNames.imagePreview,
          arguments: item.resultUrl,
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: RSImageWidget(
          url: item.type == 1 ? item.originUrl : item.resultUrl ?? '',
        ),
      ),
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
                RSTextData.creations,
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
