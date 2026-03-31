import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rose_say/rsCommon/index.dart';
import 'package:rose_say/rsPages/rsdiscover/widgets/rs_discover_list.dart';
import 'package:rose_say/rsPages/rsmessage/widgets/widgets.dart';

import '../index.dart';

/// hello
class RSBodyWidget extends GetView<RsprofileController> {
  const RSBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        RSImageWidget(
          url: controller.role.avatar,
          width: Get.width,
          height: 750.w,
          shape: BoxShape.rectangle,
          cacheWidth: 80,
          cacheHeight: 80,
        ),
        Container(
          width: Get.width,
          height: 750.w,
          padding: EdgeInsets.only(
            top: Get.mediaQuery.padding.top,
            left: 32.w,
            right: 32.w,
            bottom: 72.w,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color(0xff000000).withValues(alpha: 0.8),
                const Color(0xff000000).withValues(alpha: 0.0),
                const Color(0xff000000).withValues(alpha: 0.0),
                const Color(0xff000000).withValues(alpha: 0.9),
              ],
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
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
                  Row(
                    spacing: 16.w,
                    children: [
                      RS.login.vipStatus.value
                          ? const SizedBox.shrink()
                          : GestureDetector(
                              onTap: () {
                                Get.toNamed(
                                  RSRouteNames.vip,
                                  arguments: ConsumeFrom.profile,
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
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(
                            RSRouteNames.gems,
                            arguments: ConsumeFrom.profile,
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
                      GestureDetector(
                        onTap: () {
                          controller.report();
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
                              "assets/images/rs_41.png",
                              width: 40.w,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          width: Get.width,
          height: Get.height,
          margin: EdgeInsets.only(top: 750.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      right: 32.w,
                      top: -26.w,
                      child: Row(
                        spacing: 24.w,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 8.w,
                              horizontal: 32.w,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40.r),
                              color: const Color(0xffEBF4FF),
                            ),
                            child: Text(
                              '${controller.role.sessionCount ?? '0'} ${RSTextData.messages}',
                              style: TextStyle(
                                color: const Color(0xff080817),
                                fontSize: 24.sp,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 8.w,
                              horizontal: 32.w,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40.r),
                              color: const Color(0xffEBF4FF),
                            ),
                            child: Text(
                              '${controller.role.likes ?? '0'} ${RSTextData.liked}',
                              style: TextStyle(
                                color: const Color(0xff080817),
                                fontSize: 24.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      padding: EdgeInsets.all(32.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            spacing: 8.w,
                            children: [
                              ConstrainedBox(
                                constraints: BoxConstraints(maxWidth: 360.w),
                                child: Text(
                                  controller.role.name ?? '',
                                  style: TextStyle(
                                    fontSize: 40.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              controller.role.age == null
                                  ? const SizedBox()
                                  : GradientText(
                                      text: '${controller.role.age}',
                                      fontSize: 20.sp,
                                      // 自定义渐变颜色
                                      gradientColors: const [
                                        Color(0xFF43FFF4),
                                        Color(0xFFDAF538),
                                      ],
                                    ),
                            ],
                          ),
                          SizedBox(height: 16.w),
                          Text(
                            controller.role.aboutMe ?? '',
                            style: TextStyle(
                              fontSize: 24.sp,
                              color: const Color(0xff617085),
                            ),
                          ),
                          if (RS.storage.isRSB) ...[
                            SizedBox(height: 24.w),
                            controller.role.tags == null ||
                                    controller.role.tags!.isEmpty
                                ? const SizedBox()
                                : Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 24.w,
                                      horizontal: 16.w,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(22.r),
                                      color: const Color(0xff181B28),
                                    ),
                                    child: Column(
                                      spacing: 20.w,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          spacing: 12.w,
                                          children: [
                                            Image.asset(
                                              "assets/images/rs_39.png",
                                              width: 30.w,
                                              fit: BoxFit.contain,
                                            ),
                                            Text(
                                              RSTextData.tagsTitle,
                                              style: TextStyle(
                                                fontSize: 28.sp,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: Get.width,
                                          height: 44.w,
                                          child: ListView.builder(
                                            itemCount:
                                                controller.role.tags!.length,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) {
                                              var tag =
                                                  controller.role.tags![index];
                                              return Container(
                                                height: 44.w,
                                                margin: EdgeInsets.only(
                                                  right: 16.w,
                                                ),
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 12.w,
                                                ),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        40.r,
                                                      ),
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      Colors.white.withValues(
                                                        alpha: 0.1,
                                                      ),
                                                      Colors.white.withValues(
                                                        alpha: 0.02,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    tag,
                                                    style: TextStyle(
                                                      fontSize: 24.sp,
                                                      color: Colors.white
                                                          .withValues(
                                                            alpha: 0.8,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                            Obx(() {
                              final images = controller.images;
                              if (images.isEmpty) {
                                return const SizedBox();
                              }
                              final imageCount = images.length;
                              return Container(
                                margin: EdgeInsets.only(top: 18.w),
                                padding: EdgeInsets.symmetric(
                                  vertical: 24.w,
                                  horizontal: 16.w,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(22.r),
                                  color: const Color(0xff181B28),
                                ),
                                child: Column(
                                  spacing: 20.w,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      spacing: 12.w,
                                      children: [
                                        Image.asset(
                                          "assets/images/rs_39.png",
                                          width: 30.w,
                                          fit: BoxFit.contain,
                                        ),
                                        Text(
                                          RSTextData.ai_photos,
                                          style: TextStyle(
                                            fontSize: 28.sp,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: Get.width,
                                      height: 160.w,
                                      child: ListView.separated(
                                        padding: EdgeInsets.zero,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (_, idx) {
                                          final image = images[idx];
                                          final unlocked =
                                              image.unlocked ?? false;
                                          return PhotoAlbumItem(
                                            imageHeight: 160.w,
                                            image: image,
                                            avatar: controller.role.avatar,
                                            unlocked: unlocked,
                                            onTap: () {
                                              if (unlocked) {
                                                controller.msgCtr.onTapImage(
                                                  image,
                                                );
                                              } else {
                                                controller.msgCtr
                                                    .onTapUnlockImage(image);
                                              }
                                            },
                                          );
                                        },
                                        itemCount: imageCount,
                                        separatorBuilder: (_, idx) {
                                          return SizedBox(width: 16.w);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SafeArea(
                top: false,
                child: Row(
                  spacing: 24.w,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ButtonGradientWidget(
                      width: 476.w,
                      height: 100,
                      onTap: () => Get.back(),
                      child: Center(
                        child: Text(
                          RSTextData.chat,
                          style: TextStyle(
                            fontSize: 32.sp,
                            color: const Color(0xff090E57),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    Obx(
                      () => ButtonWidget(
                        width: 186.w,
                        height: 100.w,
                        color: const Color(0xffABC4E4).withValues(alpha: 0.3),
                        border: Border.all(width: 2.w, color: Colors.white24),
                        onTap: () => controller.onCollect(),
                        child: Center(
                          child: Image.asset(
                            controller.state.collect
                                ? "assets/images/rs_collected.png"
                                : "assets/images/rs_collect.png",
                            width: 64.w,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
