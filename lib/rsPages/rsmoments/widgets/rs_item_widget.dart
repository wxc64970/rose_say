import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rose_say/rsCommon/index.dart';

import '../index.dart';

/// hello
class RSItemWidget extends GetView<RsmomentsController> {
  const RSItemWidget({Key? key, required this.item}) : super(key: key);

  final RSPost item;

  @override
  Widget build(BuildContext context) {
    var isVideo = item.cover != null && item.duration != null;
    var imgUrl = isVideo ? item.cover : item.media;
    var istop = item.istop ?? false;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            controller.onItemClick(item);
          },
          child: Row(
            spacing: 22.w,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: RSAppColors.primaryColor,
                  borderRadius: BorderRadius.circular(100.r),
                ),
                child: Padding(
                  padding: EdgeInsets.all(2.w), // 边框厚度
                  child: RSImageWidget(
                    url: item.characterAvatar,
                    width: 100.w,
                    height: 100.w,
                    shape: BoxShape.circle,
                    cacheWidth: 100,
                    cacheHeight: 100,
                    borderRadius: BorderRadius.circular(100.r),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  spacing: 8.w,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.characterName ?? '-',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      item.text ?? '',
                      style: TextStyle(
                        color: const Color(0xFFA2B3BA),
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20.w),
        Stack(
          children: [
            GestureDetector(
              onTap: () {
                controller.onPlay(item);
              },
              child: RSImageWidget(
                url: imgUrl,
                height: 360.w,
                width: double.infinity,
                borderRadius: BorderRadius.circular(32.r),
                shape: BoxShape.rectangle,
              ),
            ),
            Positioned.fill(child: _buildLock(istop, isVideo, item)),
            Positioned(
              left: 16.w,
              top: 16.w,
              child: isVideo
                  ? Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 4.w,
                            horizontal: 16.w,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.r),
                            color: const Color(
                              0xff000000,
                            ).withValues(alpha: 0.6),
                          ),
                          child: Text(
                            formatVideoDuration(item.duration ?? 0),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLock(bool istop, bool isVideo, RSPost data) {
    Widget widget = GestureDetector(
      onTap: () {
        Get.toNamed(
          RSRouteNames.vip,
          arguments: isVideo ? VipFrom.postvideo : VipFrom.postpic,
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32.r),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 18.0, sigmaY: 18.0),
          child: Container(
            width: double.infinity,
            height: 188,
            color: const Color(0xff000000).withValues(alpha: 0.2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Container(
                //   width: 64.w,
                //   height: 64.w,
                //   padding: EdgeInsets.all(16.w),
                //   decoration: BoxDecoration(
                //     color: const Color(0xff212121).withValues(alpha: 0.5),
                //     borderRadius: BorderRadius.circular(100.r),
                //   ),
                //   child: Image.asset(
                //     'assets/images/sa_35.png',
                //     width: 32.w,
                //     fit: BoxFit.contain,
                //   ),
                // ),
                SizedBox(height: 24.w),
                ButtonWidget(
                  height: 64.w,
                  margin: EdgeInsets.symmetric(horizontal: 128.w),
                  color: Color(0xff212121).withValues(alpha: 0.5),
                  child: Center(
                    child: Text(
                      'Subscribe to unlock posts',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    Widget play = Center(
      child: GestureDetector(
        onTap: () {
          controller.onPlay(data);
        },
        // child: Center(
        //   child: Image.asset('assets/images/sa_74.png', width: 64.w),
        // ),
      ),
    );

    return Obx(() {
      var isVip = RS.login.vipStatus.value;
      if (isVip || istop) {
        return isVideo ? play : const SizedBox();
      } else {
        return widget;
      }
    });
  }
}
