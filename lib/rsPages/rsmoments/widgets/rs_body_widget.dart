import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rose_say/rsCommon/index.dart';

import '../controller.dart';
import 'rs_item_widget.dart';

class RSBodyWidget extends GetView<RsmomentsController> {
  const RSBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 48.w),
      child: EasyRefresh.builder(
        controller: controller.cjRefreshController,
        onRefresh: controller.onRefresh,
        onLoad: controller.onLoad,
        childBuilder: (context, physics) {
          return Obx(() {
            if (controller.loading) {
              return EmptyWidget(type: controller.type!, physics: physics);
            } else {
              // 假设 loading 为 false 时返回 ListView.separated
              return ListView.separated(
                physics: physics,
                // padding: EdgeInsets.symmetric(vertical: 16.w),
                padding: EdgeInsets.zero,
                itemCount: controller.list.length,
                itemBuilder: (context, index) {
                  return RSItemWidget(item: controller.list[index]);
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 16.w);
                },
              );
            }
          });
        },
      ),
    );
  }
}
