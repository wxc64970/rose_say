import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:rose_say/rsCommon/index.dart';

import 'index.dart';

class RsgemsController extends GetxController {
  RsgemsController();

  final state = RsgemsState();

  /// 在 widget 内存中分配后立即调用。
  @override
  void onInit() {
    super.onInit();
    RSInfoUtils.getIdfa();

    _loadData();

    if (Get.arguments != null && Get.arguments is ConsumeFrom) {
      state.from = Get.arguments;
    }

    RSlogEvent('t_paygems');
  }

  Future<void> _loadData() async {
    RSLoading.show();
    await RSPayUtils().query();
    RSLoading.close();

    state.list.addAll(RSPayUtils().consumableList);
    if (RS.storage.isRSB) {
      state.list.removeWhere((element) => element.displayHide == true);
    }
    state.chooseProduct.value = state.list.firstWhereOrNull(
      (e) => e.defaultSku == true,
    )!;
    update();
  }

  Future onTapBuy() async {
    RSlogEvent('c_paygems');
    RSPayUtils().buy(state.chooseProduct.value, consFrom: state.from);
  }

  help() {
    final str = RS.storage.isRSB
        ? RSTextData.textMessageCost
        : RSTextData.textMessageCallCost;
    final processedStr = str.replaceAll('\\n', '\n');
    List<String> strList = processedStr.split('\n');
    SmartDialog.show(
      tag: "help_dialog",
      builder: (_) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 87.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 576.w,
                height: 600.w,
                padding: EdgeInsets.all(48.w),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/rs_57.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: strList.length,
                      itemBuilder: (context, index) {
                        String title = strList[index];
                        return Container(
                          width: Get.width,
                          // padding: EdgeInsets.symmetric(horizontal: 40.w),
                          child: Row(
                            children: [
                              // Image.asset(
                              //   "assets/images/sa_20.png",
                              //   width: 48.w,
                              //   fit: BoxFit.contain,
                              // ),
                              SizedBox(width: 16.w),
                              Expanded(
                                child: Text(
                                  title,
                                  style: TextStyle(
                                    // color: const Color(0xFF617085),
                                    color: Colors.white,
                                    fontSize: 24.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 40.w);
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 48.w),
              InkWell(
                onTap: () {
                  SmartDialog.dismiss(tag: "help_dialog");
                },
                child: Image.asset(
                  "assets/images/rs_close.png",
                  width: 56.w,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        );
      },
    );
    // Get.bottomSheet(
    // );
  }

  onTapChoose(item) {
    state.chooseProduct.value = item;
    update();
  }

  // 根据折扣百分比获取对应的本地化字符串
  String getDiscount(int discountPercent) {
    try {
      return RSTextData.saveNum(discountPercent.toString());
    } catch (e) {
      return 'Save $discountPercent%';
    }
  }

  /// 在 onInit() 之后调用 1 帧。这是进入的理想场所
  @override
  void onReady() {
    super.onReady();
  }

  /// 在 [onDelete] 方法之前调用。
  @override
  void onClose() {
    super.onClose();
  }

  /// dispose 释放内存
  @override
  void dispose() {
    super.dispose();
  }
}
