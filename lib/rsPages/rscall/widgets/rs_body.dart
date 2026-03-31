import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:rose_say/rsCommon/index.dart';
import 'package:rose_say/rsPages/rscallguide/widgets/rs_call_button.dart';

import '../index.dart';
import 'rs_call_title.dart';

/// hello
class RSBodyWidget extends GetView<RscallController> {
  const RSBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: RSImageWidget(
            url: controller.guideVideo?.gifUrl ?? controller.role.avatar,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
        ),
        Column(
          children: [
            RSCallTitle(
              role: controller.role,
              onTapClose: controller.onTapHangup,
            ),
            SizedBox(height: 24.w),
            Obx(() => _buildTimer()),
            Expanded(child: Container()),
            Obx(() => _buildLoading()),
            Obx(() => _buildAnswering()),
            SizedBox(height: 56.w),
            Obx(
              () => Row(
                spacing: 64.w,
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildButtons(),
              ),
            ),
            SizedBox(height: 80.w),
          ],
        ),
      ],
    );
  }

  List<Widget> _buildButtons() {
    List<Widget> buttons = [
      RSCallButton(
        icon: 'assets/images/call_hugup.png',
        onTap: controller.onTapHangup,
        bgColor: const Color(0xffEB4649),
      ),
    ];

    if (controller.callState.value == CallState.incoming) {
      buttons.add(
        RSCallButton(
          icon: 'assets/images/call_phone.png',
          bgColor: RSAppColors.primaryColor,
          onTap: controller.onTapAccept,
        ),
      );
    }

    if (controller.callState.value == CallState.listening) {
      buttons.add(
        RSCallButton(
          icon: 'assets/images/voice_on.png',
          bgColor: RSAppColors.primaryColor,
          animationColor: RSAppColors.primaryColor,
          onTap: () => controller.onTapMic(false),
        ),
      );
    }

    if (controller.callState.value == CallState.answering ||
        controller.callState.value == CallState.micOff ||
        controller.callState.value == CallState.answered) {
      buttons.add(
        RSCallButton(
          icon: 'assets/images/voice_off.png',
          bgColor: Colors.white.withValues(alpha: 0.2),
          onTap: () => controller.onTapMic(true),
        ),
      );
    }

    return buttons;
  }

  Widget _buildAnswering() {
    final text = controller.callStateDescription(controller.callState.value);
    if (text.isEmpty) {
      return Container();
    }

    return SizedBox(
      width: Get.width - 60,
      child: Center(
        child: DefaultTextStyle(
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.w,
            fontWeight: FontWeight.w400,
          ),
          child: AnimatedTextKit(
            key: ValueKey(controller.callState.value),
            totalRepeatCount: 1,
            animatedTexts: [
              TypewriterAnimatedText(
                text,
                speed: const Duration(milliseconds: 50),
                cursor: '',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoading() {
    if (controller.callState.value == CallState.calling ||
        controller.callState.value == CallState.answering ||
        controller.callState.value == CallState.listening) {
      return LoadingAnimationWidget.progressiveDots(
        color: Colors.white,
        size: 40,
      );
    }
    return Container();
  }

  Widget _buildTimer() {
    if (controller.showFormattedDuration.value) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            spacing: 8.w,
            children: [
              Image.asset(
                "assets/images/rs_68.png",
                width: 28.w,
                fit: BoxFit.contain,
              ),
              Text(
                controller.formattedDuration(controller.callDuration.value),
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      );
    }
    return Container();
  }
}
