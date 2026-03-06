import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rose_say/rsCommon/index.dart';

import '../index.dart';

class imageStyleItem extends GetView<RsaiphotoController> {
  final RSImageStyle data;
  const imageStyleItem({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () => controller.handleSelectStyleImages(data),
        child: Container(
          margin: EdgeInsets.only(right: 32.w),
          child: Column(
            spacing: 16.w,
            children: [
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(
                        width: 2.w,
                        color:
                            data.id == controller.selectImageStyleData.value.id
                            ? RSAppColors.primaryColor
                            : Colors.transparent,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.r),
                      child: RSImageWidget(
                        width: 120.w,
                        height: 120.w,
                        url: data.cover,
                        shape: BoxShape.rectangle,
                      ),
                    ),
                  ),
                  data.id == controller.selectImageStyleData.value.id
                      ? Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.r),
                              color: RSAppColors.primaryColor.withValues(
                                alpha: 0.15,
                              ),
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
              SizedBox(
                width: 120.w,
                child: Text(
                  data.name ?? '',
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: data.id == controller.selectImageStyleData.value.id
                        ? Colors.white
                        : RSAppColors.primaryColor,
                    fontWeight: FontWeight.w500,
                    height: 1,
                  ),
                  maxLines: 1,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
