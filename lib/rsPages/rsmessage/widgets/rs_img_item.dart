import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rose_say/rsCommon/index.dart';

import 'widgets.dart';

class RSImgItem extends StatelessWidget {
  const RSImgItem({super.key, required this.msg});

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
          if (!msg.typewriterAnimated) _buildImageWidget(context),
        ],
      ),
    );
  }

  Widget _buildImageWidget(BuildContext context) {
    var imageUrl = msg.imgUrl ?? '';
    if (msg.source == MessageSource.clothe) {
      imageUrl = msg.giftImg ?? '';
    }
    var isLockImage = msg.mediaLock == MsgLockLevel.private.value;
    var imageWidth = 200.0;
    var imageHeight = 240.0;

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
          ? _buildLoackWidge(imageWidth, imageHeight, imageWidget)
          : GestureDetector(
              onTap: () {
                Get.toNamed(RSRouteNames.imagePreview, arguments: imageUrl);
              },
              child: imageWidget,
            );
    });
  }

  GestureDetector _buildLoackWidge(
    double imageWidth,
    double imageHeight,
    Widget imageWidget,
  ) {
    return GestureDetector(
      onTap: _onTapUnlock,
      child: Container(
        width: imageWidth,
        height: imageHeight,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
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
            _buildContentButton(),
          ],
        ),
      ),
    );
  }

  Column _buildContentButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
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

        SizedBox(height: 24.w),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              RSTextData.hotPhoto,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _onTapUnlock() async {
    RSlogEvent('c_news_lockpic');
    final isVip = RS.login.vipStatus.value;
    if (!isVip) {
      Get.toNamed(RSRouteNames.vip, arguments: VipFrom.lockpic);
    }
  }
}
