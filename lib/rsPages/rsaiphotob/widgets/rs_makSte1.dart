import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rose_say/rsCommon/index.dart';
import 'package:video_player/video_player.dart';

class RSMakste1 extends StatefulWidget {
  const RSMakste1({
    super.key,
    this.role,
    required this.isVideo,
    this.hasHistory,
    this.onTapGenRole,
    required this.onTapUpload,
  });

  final ChaterModel? role;
  final bool isVideo;
  final bool? hasHistory;
  final VoidCallback? onTapGenRole;
  final void Function() onTapUpload;

  @override
  State<RSMakste1> createState() => _RSMakste1State();
}

class _RSMakste1State extends State<RSMakste1> {
  VideoPlayerController? _controller;

  String? _localVideoPath;
  String? imageUrl =
      'https://static.zyycfysavbpgfefb.com/rose/3c1dc7a44d979d2aeb02e5d2e46d1ffa3db92600f5a0af15a3dbf695474c6e6f.jpeg';
  String videoUrl =
      'https://static.zyycfysavbpgfefb.com/rose/963001fe1f803a11d75730e53d67253cbcef61baf0f5a6e85129117e99f02c95.mp4';

  @override
  void initState() {
    super.initState();

    FileDownloadService.instance
        .downloadFile(videoUrl, fileType: FileType.video)
        .then((localPath) {
          if (localPath != null) {
            _localVideoPath = localPath;
            if (widget.isVideo) {
              _initVideoPlayer();
            }
          }
        });

    if (widget.isVideo) {
      if (_localVideoPath != null) {
        _initVideoPlayer();
      }
    }
  }

  void _initVideoPlayer() {
    _controller = VideoPlayerController.file(File(_localVideoPath!));
    _controller?.initialize().then((_) {
      _controller?.setLooping(true);
      _controller?.play();
      setState(() {});
    });
  }

  Widget imageErrorWidget() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
      alignment: Alignment.center,
      child: Icon(Icons.photo, size: 90.sp, color: RSAppColors.primaryColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    final text = !widget.isVideo
        ? RSTextData.ai_upload_steps_extra
        : RSTextData.ai_upload_steps;
    final text2 = !widget.isVideo
        ? RSTextData.ai_undress_sweetheart
        : RSTextData.ai_make_photo_animated;

    final imgW = 480.w;
    final imgH = 600.w;

    bool hasRole = widget.role != null;

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Positioned.fill(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: 40.w,
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(48.r),
                    clipBehavior: Clip.hardEdge,
                    child: Container(
                      height: imgH,
                      width: imgW,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(48.r),
                        color: Colors.white,
                      ),
                      child: widget.isVideo
                          ? (_controller?.value.isInitialized ?? false)
                                ? AspectRatio(
                                    aspectRatio: _controller!.value.aspectRatio,
                                    child: VideoPlayer(_controller!),
                                  )
                                : imageErrorWidget()
                          : RSImageWidget(url: imageUrl),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.zero,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 40.w,
                    children: [
                      Container(
                        padding: EdgeInsets.all(32.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22.r),
                          color: const Color(0xff181B28),
                        ),
                        child: Text(
                          text,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          text2,
                          style: TextStyle(
                            color: RSAppColors.primaryColor,
                            fontSize: 36.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 110.w),
              ],
            ),
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            !hasRole
                ? ButtonGradientWidget(
                    height: 100,
                    onTap: widget.onTapUpload,
                    child: Center(
                      child: Text(
                        RSTextData.uploadAPhoto,
                        style: TextStyle(
                          fontSize: 32.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  )
                : ButtonWidget(
                    height: 100.w,
                    onTap: widget.onTapUpload,
                    color: RSAppColors.primaryColor.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(100.r),
                    border: Border.all(color: Colors.white24, width: 2.w),
                    child: Center(
                      child: Text(
                        RSTextData.uploadAPhoto,
                        style: TextStyle(
                          fontSize: 32.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

            if (hasRole) ...[
              SizedBox(height: 16.w),
              ButtonGradientWidget(
                height: 100,
                onTap: widget.onTapGenRole,
                child: Center(
                  child: Text(
                    widget.hasHistory == true
                        ? RSTextData.ai_view_nude
                        : RSTextData.ai_under_character,
                    style: TextStyle(
                      fontSize: 32.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
            SizedBox(height: 32.w),
          ],
        ),
      ],
    );
  }
}
