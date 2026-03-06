import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rose_say/rsCommon/index.dart';

import 'widgets.dart';

class RSVItem extends StatelessWidget {
  const RSVItem({super.key, required this.msg});

  final RSMessageModel msg;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RSTItem(msg: msg),
          const SizedBox(height: 8),
          if (!msg.typewriterAnimated) _buildImageWidget(),
        ],
      ),
    );
  }

  Widget _buildImageWidget() {
    var imageUrl = msg.thumbLink ?? msg.imgUrl ?? '';
    var isLockImage = msg.mediaLock == MsgLockLevel.private.value;
    var imageWidth = 200.0;
    var imageHeight = 240.0;

    var videoUrl = msg.videoUrl ?? '';

    var imageWidget = ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: RSImageWidget(
        url: imageUrl,
        width: imageWidth,
        height: imageHeight,
        borderRadius: BorderRadius.circular(16),
      ),
    );

    return Obx(() {
      var isHide = !RS.login.vipStatus.value && isLockImage;
      return isHide
          ? _buildCover(imageWidth, imageHeight, imageWidget)
          : _buildVideoButton(videoUrl, imageWidget);
    });
  }

  Widget _buildCover(
    double imageWidth,
    double imageHeight,
    Widget imageWidget,
  ) {
    return GestureDetector(
      onTap: _onTapUnlock,
      child: Container(
        width: imageWidth,
        height: imageHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: const Color(0x801C1C1C),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          alignment: Alignment.center,
          children: [
            imageWidget,
            ClipRect(
              child: BackdropFilter(
                blendMode: BlendMode.srcIn,
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  alignment: Alignment.center,
                  height: double.infinity,
                  width: double.infinity,
                  decoration: const BoxDecoration(color: Color(0x801C1C1C)),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 24.w,
              children: [
                // const Icon(Icons.play_circle, size: 32, color: Colors.white),
                Container(
                  width: 68.w,
                  height: 68.w,
                  decoration: BoxDecoration(
                    color: const Color(0xffCCDEFF).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(34.w),
                    border: Border.all(
                      width: 1.w,
                      color: const Color(0xffFFFFFF).withValues(alpha: 0.23),
                    ),
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/images/rs_locked.png',
                      width: 40.w,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      RSTextData.hotVideo,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoButton(String videoUrl, Widget imageWidget) {
    return InkWell(
      onTap: () {
        Get.toNamed(RSRouteNames.videoPreview, arguments: videoUrl);
      },
      child: Stack(
        alignment: Alignment.center,
        children: [imageWidget, const Icon(Icons.play_circle, size: 32)],
      ),
    );
  }

  void _onTapUnlock() async {
    RSlogEvent('c_news_lockvideo');
    final isVip = RS.login.vipStatus.value;
    if (!isVip) {
      Get.toNamed(RSRouteNames.vip, arguments: VipFrom.lockpic);
    }
  }
}
