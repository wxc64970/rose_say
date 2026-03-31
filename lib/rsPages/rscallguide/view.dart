import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:rose_say/rsCommon/index.dart';
import 'package:video_player/video_player.dart';

import 'index.dart';
import 'widgets/rs_call_button.dart';
import 'widgets/rs_call_title.dart';

class RscallguidePage extends StatefulWidget {
  const RscallguidePage({Key? key}) : super(key: key);

  @override
  State<RscallguidePage> createState() => _RscallguidePageState();
}

class _RscallguidePageState extends State<RscallguidePage> with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    /// 路由订阅
    RoutePages.observer.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    /// 取消路由订阅
    RoutePages.observer.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const _RscallguideViewGetX();
  }
}

class _RscallguideViewGetX extends GetView<RscallguideController> {
  const _RscallguideViewGetX({Key? key}) : super(key: key);

  // 主视图
  Widget _buildView() {
    return Container(
      color: Colors.black,
      child: Stack(
        children: [
          Positioned.fill(child: RSImageWidget(url: controller.role.avatar)),
          FutureBuilder(
            future: controller.initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  controller.videoPlayerController != null) {
                return Positioned.fill(
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: controller.videoPlayerController?.value.size.width,
                      height:
                          controller.videoPlayerController?.value.size.height,
                      child: VideoPlayer(controller.videoPlayerController!),
                    ),
                  ),
                );
              } else {
                // 在加载时显示进度指示器
                return Center(child: RSLoading.activityIndicator());
              }
            },
          ),
          Positioned.fill(
            child: Container(
              width: Get.width,
              height: Get.height,
              color: Colors.black38,
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Obx(() {
              // if (controller.playState.value == PlayState.playing) {

              // }
              if (controller.playState.value == PlayState.finish) {
                return RSCallTitle(
                  role: controller.role,
                  onTapClose: () {
                    Get.back();
                  },
                );
              } else {
                return const SizedBox.shrink();
              }
            }),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Obx(() {
              final vip = RS.login.vipStatus.value;

              switch (controller.playState.value) {
                case PlayState.init:
                case PlayState.playing:
                  return _playingView();

                case PlayState.finish:
                  // return vip ? _playingView() : _playedView();
                  if (!vip) {
                    DialogWidget.show(
                      child: _playedView(),
                      clickMaskDismiss: false,
                    );
                  }
                  return _playingView();
              }
            }),
          ),
        ],
      ),
    );
  }

  Widget _playingView() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 64.w,
      children: [
        Text(
          RSTextData.invitesYouToVideoCall,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 28.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        Row(
          spacing: 64.w,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RSCallButton(
              icon: 'assets/images/call_hugup.png',
              bgColor: const Color(0xffEB4649),
              onTap: () => Get.back(),
            ),
            if (controller.playState.value == PlayState.finish)
              RSCallButton(
                icon: 'assets/images/call_phone.png',
                bgColor: RSAppColors.primaryColor,
                onTap: controller.phoneAccept,
              ),
          ],
        ),
        const SizedBox(height: 32),
      ],
    );
  }

  Widget _playedView() {
    return Container(
      color: Colors.transparent,
      margin: EdgeInsets.symmetric(horizontal: 86.w),
      child: Column(
        children: [
          Stack(
            children: [
              Image.asset(
                "assets/images/rs_21.png",
                width: Get.width,
                fit: BoxFit.contain,
              ),
              Positioned(
                top: 70.w,
                right: 0,
                left: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 36.w),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 300.w,
                            child: Center(
                              child: Text(
                                RSTextData.unlock,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 32.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 74.w),
                          Text(
                            RSTextData.getAiInteractiveVideoChat,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.8),
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 18.w),
                          Center(
                            child: Image.asset(
                              "assets/images/rs_22.png",
                              width: 192.w,
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(height: 16.w),
                          ButtonGradientWidget(
                            onTap: controller.pushVip,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  RSTextData.unlockNow,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 28.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 48.w),
          InkWell(
            onTap: () {
              SmartDialog.dismiss();
              Get.back();
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
    // return Column(
    //   mainAxisSize: MainAxisSize.min,
    //   crossAxisAlignment: CrossAxisAlignment.center,
    //   children: [
    //     Container(
    //       padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 32.w),
    //       margin: EdgeInsets.symmetric(horizontal: 30.w),
    //       decoration: BoxDecoration(
    //         color: const Color(0xff000000).withValues(alpha: 0.6),
    //         borderRadius: BorderRadius.circular(32.r),
    //       ),
    //       child: Column(
    //         children: [
    //           Text(
    //             RSTextData.activateBenefits,
    //             textAlign: TextAlign.center,
    //             style: TextStyle(
    //               color: Colors.white,
    //               fontSize: 30.sp,
    //               fontWeight: FontWeight.w500,
    //             ),
    //           ),
    //           Text(
    //             RSTextData.getAiInteractiveVideoChat,
    //             textAlign: TextAlign.center,
    //             style: TextStyle(
    //               fontSize: 26.sp,
    //               fontWeight: FontWeight.w400,
    //               color: Colors.white,
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),

    //     SizedBox(height: 40.w),
    //     ButtonGradientWidget(
    //       height: 96,
    //       onTap: controller.pushVip,
    //       hasShadow: true,
    //       margin: const EdgeInsets.symmetric(horizontal: 40),
    //       child: Center(
    //         child: Text(
    //           RSTextData.btnContinue,
    //           style: TextStyle(
    //             color: Colors.white,
    //             fontWeight: FontWeight.w600,
    //             fontSize: 32.sp,
    //           ),
    //         ),
    //       ),
    //     ),
    //     SizedBox(height: 80.w),
    //   ],
    // );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RscallguideController>(
      init: RscallguideController(),
      id: "rscallguide",
      builder: (_) {
        return Scaffold(body: _buildView());
      },
    );
  }
}
