import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rose_say/rsCommon/index.dart';
import 'package:rose_say/rsPages/rsmessage/widgets/rs_msg_e_scr.dart';

import 'rs_mak_loading.dart';
import 'rs_mak_styles_widget.dart';

class RSMakste2 extends StatefulWidget {
  const RSMakste2({
    super.key,
    required this.onTapGen,
    this.onDeleteImage,
    this.role,
    required this.isVideo,
    required this.onInputTextFinish,
    required this.styles,
    required this.onChooseStyles,
    this.imagePath,
    required this.undressRole,
    required this.isLoading,
    this.selectedStyel,
  });

  final VoidCallback onTapGen;
  final VoidCallback? onDeleteImage;
  final ChaterModel? role;
  final bool isVideo;
  final Function(String text) onInputTextFinish;
  final List<RSImgStyle> styles;
  final Function(RSImgStyle? style) onChooseStyles;
  final String? imagePath;
  final bool undressRole;
  final RSImgStyle? selectedStyel;
  final bool isLoading;

  @override
  State<RSMakste2> createState() => _RSMakste2State();
}

class _RSMakste2State extends State<RSMakste2> {
  RSImgStyle? style;
  String? customPrompt;

  @override
  void initState() {
    style = widget.selectedStyel;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final imgW = 480.w;
    final imgH = 600.w;

    bool hasCustomPrompt = customPrompt != null && customPrompt!.isNotEmpty;
    var avatar = widget.role?.avatar;

    var imagePath = widget.imagePath;

    return Stack(
      children: [
        Positioned.fill(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(48.r),
                    clipBehavior: Clip.hardEdge,
                    child: Stack(
                      children: [
                        Container(
                          color: Colors.white,
                          height: imgH,
                          width: imgW,
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              if (widget.undressRole && avatar != null)
                                Positioned.fill(
                                  child: CachedNetworkImage(
                                    imageUrl: avatar,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              if (imagePath != null && imagePath.isNotEmpty)
                                Positioned.fill(
                                  child: Image.file(
                                    File(imagePath),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              IconButton(
                                onPressed: widget.onDeleteImage,
                                icon: Icon(
                                  Icons.cancel,
                                  color: Colors.white,
                                  size: 48.sp,
                                ),
                              ),
                              if (widget.isLoading) const RSMakLoading(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 24.w),
                if (widget.isVideo == false) ...[
                  RSMakStylesWidget(
                    selectedStyel: style,
                    list: widget.styles,
                    onChooseed: onChooseedStyle,
                  ),
                  const SizedBox(height: 8),
                ],
                Container(
                  padding: EdgeInsets.all(24.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22.r),
                    color: const Color(0xff181B28),
                  ),
                  child: Column(
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
                            RSTextData.ai_custom_prompt,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 22.w),
                      InkWell(
                        onTap: onTapInput,
                        borderRadius: BorderRadius.circular(16.r),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 30.w,
                            vertical: 24.w,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xff333B47),
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          alignment: AlignmentDirectional.centerStart,
                          child: RSAutoHeightScrollText(
                            text: hasCustomPrompt
                                ? customPrompt!
                                : widget.isVideo
                                ? RSTextData.ai_prompt_examples_video
                                : RSTextData.ai_prompt_examples_img,
                            style: TextStyle(
                              color: hasCustomPrompt
                                  ? const Color(0xFFFFFFFF)
                                  : const Color(0xFF617085),
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w400,
                              height: 1.5,
                            ),
                            preciseHeight: true,
                            maxLines: 3,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 200.w),
              ],
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 10,
          child: Column(
            children: [
              const SizedBox(height: 8),
              Obx(() {
                var createImg = RS.login.imgCreationCount.value;
                var createVideo = RS.login.videoCreationCount.value;
                return Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: RSTextData.ai_balance,
                        style: TextStyle(
                          color: const Color(0xFF81858A),
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const WidgetSpan(child: SizedBox(width: 4)),
                      TextSpan(
                        text: widget.isVideo ? '$createVideo' : '$createImg',
                        style: TextStyle(
                          color: RSAppColors.primaryColor,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const WidgetSpan(child: SizedBox(width: 4)),
                      TextSpan(
                        text: widget.isVideo
                            ? RSTextData.ai_videos
                            : RSTextData.ai_photos,
                        style: TextStyle(
                          color: const Color(0xFF81858A),
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                );
              }),
              const SizedBox(height: 8),
              ButtonGradientWidget(
                onTap: widget.onTapGen,
                height: 96,
                child: Center(
                  child: Text(
                    RSTextData.ai_generate,
                    style: TextStyle(
                      fontSize: 32.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void onTapInput() {
    if (widget.isLoading) return;
    Get.bottomSheet(
      RSMsgEditScreen(
        content: customPrompt,
        onInputTextFinish: (v) {
          customPrompt = v;

          style = v.isEmpty ? widget.styles.firstOrNull : null;
          widget.onChooseStyles(style);

          widget.onInputTextFinish(v);
          setState(() {});
          Get.back();
        },
        subtitle: Row(
          spacing: 4,
          children: [
            Text(
              RSTextData.ai_custom_prompt,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
      enableDrag: false, // 禁用底部表单拖拽，避免与文本选择冲突
      isScrollControlled: true,
      isDismissible: true,
      ignoreSafeArea: false,
    );
  }

  void onChooseedStyle(RSImgStyle data) {
    if (widget.isLoading) return;
    style = data;
    customPrompt = null;
    widget.onChooseStyles(data);
    widget.onInputTextFinish('');
    setState(() {});
  }
}
