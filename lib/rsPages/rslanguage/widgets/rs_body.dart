import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rose_say/rsCommon/index.dart';
import 'package:scrollview_observer/scrollview_observer.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

import '../index.dart';
import 'rs_az_view.dart';

/// hello
class RSBodyWidget extends GetView<RslanguageController> {
  const RSBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        appBar(),
        SizedBox(height: 24.w),
        Obx(
          () => Expanded(
            child: controller.emptyType.value != null
                ? EmptyWidget(type: controller.emptyType.value!)
                : Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 32.w),
                            padding: EdgeInsets.symmetric(
                              vertical: 24.w,
                              horizontal: 32.w,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40.r),
                              color: RSAppColors.primaryColor.withValues(
                                alpha: 0.1,
                              ),
                              border: Border.all(
                                width: 2.w,
                                color: Colors.white10,
                              ),
                            ),
                            child: Column(
                              spacing: 16.w,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text.rich(
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 32.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: '${RSTextData.ai_language} ',
                                      ),
                                      TextSpan(
                                        text: controller.choosedName.value,
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  RSTextData.clickSaveToConfirm,
                                  style: TextStyle(
                                    fontSize: 24.sp,
                                    color: RSAppColors.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 32.w),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 32.w),
                              child: SliverViewObserver(
                                controller: controller.observerController,
                                sliverContexts: () {
                                  return controller.sliverContextMap.values
                                      .toList();
                                },
                                child: CustomScrollView(
                                  key: ValueKey(controller.isShowListMode),
                                  controller: controller.scrollController,
                                  slivers: [
                                    ...controller.contactList
                                        .asMap()
                                        .entries
                                        .map((entry) {
                                          final i = entry.key;
                                          final e = entry.value;
                                          return _buildSliver(
                                            index: i,
                                            model: e,
                                          );
                                        }),
                                    SliverToBoxAdapter(
                                      child: Container(height: 140),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        left: 0,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 80.w),
                              child: ButtonGradientWidget(
                                onTap: controller.onSaveButtonTapped,
                                height: 100,
                                borderRadius: BorderRadius.circular(100.r),
                                child: Center(
                                  child: Text(
                                    RSTextData.save,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 32.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: Get.mediaQuery.padding.bottom),
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
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
                RSTextData.language,
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

  Widget _buildSliver({
    required int index,
    required RSAzListContactModel model,
  }) {
    final names = model.names;
    if (names.isEmpty) return const SliverToBoxAdapter();
    Widget resultWidget = SliverList(
      delegate: SliverChildBuilderDelegate((context, itemIndex) {
        if (controller.sliverContextMap[index] == null) {
          controller.sliverContextMap[index] = context;
        }
        return Obx(
          () => RSAzListItemV(
            name: names[itemIndex],
            isChoosed: names[itemIndex] == controller.choosedName.value,
            onTap: () {
              debugPrint('click  - ${model.section} - ${names[itemIndex]}');
              controller.choosedName.value = names[itemIndex];
              // 保存选中的语言对象
              if (model.langs != null && itemIndex < model.langs!.length) {
                controller.selectedLang = model.langs![itemIndex];
                debugPrint(
                  'Selected lang: ${controller.selectedLang?.label} - ${controller.selectedLang?.value}',
                );
              }
            },
          ),
        );
      }, childCount: names.length),
    );
    resultWidget = SliverStickyHeader(
      header: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF0B0B0B),
          // borderRadius: BorderRadius.only(topLeft: Radius.circular(32.r), topRight: Radius.circular(32.r)),
        ),
        padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.w),
        child: Text(
          model.section,
          style: TextStyle(
            color: Colors.white,
            fontSize: 28.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      sliver: resultWidget,
    );
    return resultWidget;
  }
}
