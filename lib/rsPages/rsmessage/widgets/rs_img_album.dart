import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rose_say/rsCommon/index.dart';
import 'package:rose_say/rsPages/rsmessage/controller.dart';

class RSImgAlbum extends StatefulWidget {
  const RSImgAlbum({super.key});

  @override
  State<RSImgAlbum> createState() => _ImageAlbumState();
}

class _ImageAlbumState extends State<RSImgAlbum> {
  final imageHeight = 144.w;
  bool _isExpanded = true;

  final ctr = Get.find<RsmessageController>();

  RxList<RoleImage> images = <RoleImage>[].obs;

  @override
  void initState() {
    super.initState();

    images.value = ctr.state.role.images ?? [];
    RSLogUtil.d('RSImgAlbum initState images: ${images.length}');

    ever(ctr.state.roleImagesChaned, (_) {
      images.value = ctr.state.role.images ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() {
          return _buildImages();
        }),
      ],
    );
  }

  Widget _buildImages() {
    final imageCount = images.length;

    if (!RS.storage.isRSB || imageCount == 0 || images.isEmpty) {
      return Container(
        height: 1.w,
        color: const Color(0xFFFFFFFF).withValues(alpha: 0.3),
      );
    }

    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300), // 动画持续时间
          curve: Curves.easeInOut, // 动画曲线
          margin: EdgeInsets.only(left: 32.w),
          // padding: _isExpanded == true ? EdgeInsets.symmetric(vertical: 16.w) : null,
          height: _isExpanded ? 180.w : 0, // 根据状态动态调整高度
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 1.w,
                color: const Color(0xFFFFFFFF).withValues(alpha: 0.3),
              ),
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 16.w),
              Expanded(
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, idx) {
                    final image = images[idx];
                    final unlocked = image.unlocked ?? false;
                    return PhotoAlbumItem(
                      imageHeight: imageHeight,
                      image: image,
                      avatar: ctr.state.role.avatar,
                      unlocked: unlocked,
                      onTap: () {
                        if (unlocked) {
                          ctr.onTapImage(image);
                        } else {
                          ctr.onTapUnlockImage(image);
                        }
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(width: 16.w);
                  },
                  itemCount: imageCount,
                ),
              ),
              SizedBox(height: 16.w),
            ],
          ),
        ),
        _isExpanded == true
            ? const SizedBox()
            : Container(
                height: 1.w,
                color: const Color(0xFFFFFFFF).withValues(alpha: 0.3),
              ),
        GestureDetector(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Center(
            child: Icon(
              color: Colors.white,
              _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              size: 42.sp,
            ),
          ),
        ),
      ],
    );
  }
}

class PhotoAlbumItem extends StatelessWidget {
  const PhotoAlbumItem({
    super.key,
    required this.imageHeight,
    required this.image,
    required this.unlocked,
    this.onTap,
    this.avatar,
  });

  final double imageHeight;
  final RoleImage image;
  final bool unlocked;
  final void Function()? onTap;
  final String? avatar;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(18.r)),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: imageHeight,
          width: imageHeight,
          color: const Color(0xff1C1C1C).withValues(alpha: 0.5),
          child: Stack(
            children: [
              RSImageWidget(
                url: !unlocked ? avatar : image.imageUrl,
                width: imageHeight,
                height: imageHeight,
                cacheWidth: 800,
                cacheHeight: 800,
                borderRadius: BorderRadius.circular(18.r),
              ),
              if (!unlocked)
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                  child: Container(
                    color: const Color(0xff1C1C1C).withValues(alpha: 0.5),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 10.w,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(58.r),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              spacing: 4.w,
                              children: [
                                Image.asset(
                                  'assets/images/rs_03.png',
                                  width: 32.w,
                                  fit: BoxFit.contain,
                                ),
                                Text(
                                  '${image.gems ?? 0}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24.sp,
                                  ),
                                ),
                              ],
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
      ),
    );
  }
}
