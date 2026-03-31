import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rose_say/rsCommon/index.dart';

import '../controller.dart';

class RSBodyWidget extends GetView<RsaiphotobController> {
  const RSBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: Get.height,
      child: Padding(
        padding: EdgeInsets.only(left: 32.w, right: 32.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TabBar(
                    controller: controller.tabController,
                    isScrollable: true, // 关闭均分宽度，支持滑动
                    tabAlignment: TabAlignment.start,
                    labelColor: const Color(0xffABC4E4),
                    unselectedLabelColor: Colors.white.withValues(alpha: 0.8),
                    dividerHeight: 0.0,
                    indicatorSize: TabBarIndicatorSize.label, // 下划线宽度与文字一致
                    indicator: const BoxDecoration(
                      image: DecorationImage(
                        alignment: Alignment.centerRight,
                        image: AssetImage("assets/images/rs_01.png"),
                      ),
                    ),
                    padding: EdgeInsets.zero,
                    labelPadding: EdgeInsets.only(right: 32.w), // Tab 之间的间距
                    unselectedLabelStyle: TextStyle(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w400,
                    ), // 未选中文字样式
                    labelStyle: TextStyle(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w600,
                    ), // 选中文字样式
                    tabs: List.generate(controller.tabs.length, (index) {
                      final data = controller.tabs[index];

                      return SizedBox(
                        height: 48.w,
                        child: Stack(
                          children: [
                            Text(
                              '$data   ',
                              style: TextStyle(
                                fontSize: 28.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.transparent,
                              ),
                            ),
                            Text('$data   '),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
                Obx(
                  () => Row(
                    children: [
                      RS.login.vipStatus.value
                          ? const SizedBox.shrink()
                          : InkWell(
                              onTap: () {
                                // DialogWidget.showLoginReward();
                                Get.toNamed(
                                  RSRouteNames.vip,
                                  arguments: VipFrom.homevip,
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 8.w,
                                  horizontal: 12.w,
                                ),
                                // margin: EdgeInsets.only(left: 24.w),
                                decoration: BoxDecoration(
                                  color: const Color(
                                    0xffCCDEFF,
                                  ).withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(100.r),
                                  border: Border.all(
                                    width: 1.w,
                                    color: Colors.white.withValues(alpha: 0.23),
                                  ),
                                ),
                                child: Center(
                                  child: Image.asset(
                                    "assets/images/rs_02.png",
                                    width: 48.w,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                      SizedBox(width: 16.w),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(
                            RSRouteNames.gems,
                            arguments: ConsumeFrom.home,
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 8.w,
                            horizontal: 12.w,
                          ),
                          // margin: EdgeInsets.only(left: 24.w),
                          decoration: BoxDecoration(
                            color: const Color(
                              0xffCCDEFF,
                            ).withValues(alpha: 0.1),
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
                ),
              ],
            ),
            SizedBox(height: 32.w),
            Expanded(
              child: TabBarView(
                controller: controller.tabController,
                children: controller.tabViews,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
