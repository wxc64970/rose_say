import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:rose_say/rsCommon/index.dart';

const String loginRewardTag = '9sK7pR2t';
const String giftLoadingTag = 'Df5Gz8Q1';
const String rateUsTag = 'V8nS3kL9';
const String rechargeSuccTag = 'Bm7q2Xz5';
const String chatLevelUpTag = 'K1dR6fH4';
const String positiveReviewTag = 'W3sJ7gP2';
const String undrDialog = 'Gz8c5Nt9';

class DialogWidget {
  static Future<void> dismiss({String? tag}) {
    return SmartDialog.dismiss(status: SmartStatus.dialog, tag: tag);
  }

  static Future<void> show({
    required Widget child,
    bool? clickMaskDismiss = true,
    String? tag,
    bool? showCloseButton = true,
    Alignment? alignment,
  }) async {
    final completer = Completer<void>();

    SmartDialog.show(
      clickMaskDismiss: clickMaskDismiss,
      keepSingle: true,
      debounce: true,
      alignment: alignment,
      tag: tag,
      maskWidget: ClipPath(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
          child: Container(color: Colors.black.withValues(alpha: 0.6)),
        ),
      ),
      builder: (context) {
        if (showCloseButton == true) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            spacing: 20,
            children: [
              child,
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [_buildCloseButton()],
              // ),
            ],
          );
        } else {
          return child;
        }
      },
      onDismiss: () {
        completer.complete();
      },
    );

    await completer.future;
  }

  static Future<void> alert({
    String? title,
    String? message,
    Widget? messageWidget,
    bool? clickMaskDismiss = false,
    String? cancelText,
    String? confirmText,
    void Function()? onCancel,
    void Function()? onConfirm,
  }) async {
    return show(
      clickMaskDismiss: false,
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32.r),
              gradient: LinearGradient(
                begin: AlignmentDirectional.topCenter,
                end: AlignmentDirectional.bottomCenter,
                colors: [
                  const Color(0xffFFFFFF).withValues(alpha: 0.3),
                  const Color(0xffFFFFFF).withValues(alpha: 0.2),
                  const Color(0xff0C3244).withValues(alpha: 0.1),
                ],
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(2.w),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 64.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32.r),
                  color: const Color(0xff1A2E4C),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  spacing: 12,
                  children: [
                    _buildText(
                      title ?? RSTextData.tips,
                      40.sp,
                      FontWeight.w500,
                    ),
                    if (title?.isNotEmpty == true) const SizedBox(height: 16),
                    _buildText(message, 28.sp, FontWeight.w500),
                    if (messageWidget != null) messageWidget,
                    SizedBox(height: 40.w),
                    Row(
                      spacing: 32.w,
                      children: [
                        if (cancelText?.isNotEmpty == true)
                          ButtonWidget(
                            onTap: () {
                              onCancel ?? SmartDialog.dismiss();
                            },
                            width: 303.w,
                            height: 96.w,
                            color: const Color(
                              0xffABC4E4,
                            ).withValues(alpha: 0.3),
                            border: Border.all(
                              width: 2.w,
                              color: Colors.white24,
                            ),
                            child: Center(
                              child: Text(
                                RSTextData.cancel,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 32.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ButtonGradientWidget(
                          onTap: onConfirm,
                          width: 303.w,
                          height: 96,
                          borderRadius: BorderRadius.circular(100.r),
                          child: Center(
                            child: Text(
                              confirmText ?? RSTextData.confirm,
                              style: TextStyle(
                                color: const Color(0xff090E57),
                                fontSize: 32.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Future input({
    String? title,
    String? message,
    String? hintText,
    Widget? messageWidget,
    bool? clickMaskDismiss = false,
    String? cancelText,
    String? confirmText,
    void Function()? onCancel,
    void Function()? onConfirm,
    FocusNode? focusNode,
    TextEditingController? textEditingController,
  }) async {
    final focusNode1 = focusNode ?? FocusNode();
    final textController1 = textEditingController ?? TextEditingController();

    return SmartDialog.show(
      clickMaskDismiss: clickMaskDismiss,
      useAnimation: false,
      maskWidget: ClipPath(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
          child: Container(color: Colors.black.withValues(alpha: 0.8)),
        ),
      ),
      builder: (context) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          focusNode1.requestFocus();
        });

        double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

        return AnimatedPadding(
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeOut,
          padding: EdgeInsets.only(bottom: keyboardHeight),
          child: Material(
            type: MaterialType.transparency,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildCloseButton(),
                  SizedBox(height: 48.w),
                  Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 32.w),
                        child: Image.asset(
                          "assets/images/rs_23.png",
                          width: Get.width,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 24.w,
                          horizontal: 72.w,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 0,
                                horizontal: 0,
                              ).copyWith(bottom: 30.w),
                              child: Row(
                                spacing: 8.w,
                                children: [
                                  Transform(
                                    // 核心：skewX(角度)，角度单位为弧度（π/180 × 角度值）
                                    // 示例：斜切20°（π/180×20≈0.349），负数为反向斜切
                                    transform: Matrix4.skewX(-0.349),
                                    // 对齐方式：避免变换后位置偏移
                                    alignment: Alignment.center,
                                    child: Container(
                                      width: 10.w,
                                      height: 13.w,
                                      decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0xff43FFF4),
                                            Color(0xffDAF538),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    title ?? '',
                                    style: TextStyle(
                                      fontSize: 32.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Transform(
                                    // 核心：skewX(角度)，角度单位为弧度（π/180 × 角度值）
                                    // 示例：斜切20°（π/180×20≈0.349），负数为反向斜切
                                    transform: Matrix4.skewX(-0.349),
                                    // 对齐方式：避免变换后位置偏移
                                    alignment: Alignment.center,
                                    child: Container(
                                      width: 10.w,
                                      height: 13.w,
                                      decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0xff43FFF4),
                                            Color(0xffDAF538),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (title?.isNotEmpty == true)
                              SizedBox(height: 40.w),
                            _buildText(message, 32.sp, FontWeight.w500),
                            if (messageWidget != null) messageWidget,
                            const SizedBox(height: 16),
                            Container(
                              height: 100.w,
                              padding: EdgeInsets.symmetric(horizontal: 32.w),
                              decoration: BoxDecoration(
                                color: const Color(
                                  0xffFFFFFF,
                                ).withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(32.r),
                              ),
                              child: Center(
                                child: TextField(
                                  autofocus: true,
                                  textInputAction: TextInputAction.done,
                                  onEditingComplete: () {},
                                  minLines: 1,
                                  maxLength: 20,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    height: 1,
                                    color: RSAppColors.primaryColor,
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  controller: textController1,
                                  decoration: InputDecoration(
                                    hintText: hintText ?? 'input',
                                    counterText: '', // 去掉字数显示
                                    hintStyle: const TextStyle(
                                      color: Color(0xFFA5A5B9),
                                    ),
                                    fillColor: Colors.transparent,
                                    border: InputBorder.none,
                                    filled: true,
                                    isDense: true,
                                  ),
                                  focusNode: focusNode1,
                                ),
                              ),
                            ),
                            SizedBox(height: 56.w),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: ButtonGradientWidget(
                                    onTap: onConfirm,
                                    height: 100,
                                    borderRadius: BorderRadius.circular(100.r),
                                    child: Center(
                                      child: Text(
                                        RSTextData.confirm,
                                        style: TextStyle(
                                          fontFamily: "Montserrat",
                                          color: Colors.black,
                                          fontSize: 28.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
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
        );
      },
    );
  }

  static Widget _buildCloseButton({void Function()? onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: () {
            SmartDialog.dismiss();
            onTap?.call();
          },
          child: Image.asset(
            "assets/images/rs_close.png",
            width: 56.w,
            fit: BoxFit.contain,
          ),
        ),
        SizedBox(width: 32.w),
      ],
    );
  }

  static Widget _buildText(
    String? text,
    double fontSize,
    FontWeight fontWeight,
  ) {
    if (text?.isNotEmpty != true) return const SizedBox.shrink();
    return Text(
      text!,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }

  static Future showChatLevel() async {
    return show(child: const RSLevelDialog(), clickMaskDismiss: false);
  }

  static bool _isChatRSLevelDialogVisible = false;

  static Future<void> showChatLevelUp(int rewards) async {
    // 防止重复弹出
    if (_isChatRSLevelDialogVisible) return;

    // 设置标记为显示中
    _isChatRSLevelDialogVisible = true;

    try {
      await showLevelUpToast(rewards);
    } finally {
      _isChatRSLevelDialogVisible = false;
    }
  }

  static Future<void> showLevelUpToast(int rewards) async {
    final completer = Completer<void>();

    SmartDialog.show(
      displayTime: const Duration(milliseconds: 1500),
      maskColor: Colors.transparent,
      clickMaskDismiss: false,
      onDismiss: () => completer.complete(),
      builder: (context) {
        return Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xff1A2E4C),
                  borderRadius: BorderRadius.circular(44.r),
                  border: Border.all(
                    width: 2.w,
                    color: const Color(0xffABC4E4),
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.w),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 8.w,
                  children: [
                    Image.asset(
                      'assets/images/rs_03.png',
                      width: 48.w,
                      fit: BoxFit.contain,
                    ),
                    Text(
                      '+ $rewards',
                      style: TextStyle(
                        fontSize: 32.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static Future showLoginReward() async {
    if (checkExist(loginRewardTag)) {
      return;
    }
    return show(
      tag: loginRewardTag,
      clickMaskDismiss: false,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 672.w,
            // padding: EdgeInsets.only(left: 52.w, right: 72.w, top: 100.w),
            // margin: EdgeInsets.only(bottom: 76.w),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/rs_33.png'),
                fit: BoxFit.contain,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 192.w),
                Container(
                  margin: EdgeInsets.only(left: 400.w),
                  padding: EdgeInsets.symmetric(
                    vertical: 4.w,
                    horizontal: 12.w,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24.r),
                      topRight: Radius.circular(24.r),
                      bottomRight: Radius.circular(24.r),
                    ),
                    color: Colors.white,
                  ),
                  child: Text(
                    RS.login.vipStatus.value ? '+50' : '+20',
                    style: TextStyle(
                      fontSize: 24.sp,
                      color: const Color(0xff090E57),
                    ),
                  ),
                ),

                SizedBox(height: 340.w),
                !RS.login.vipStatus.value
                    ? Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Pro',
                                style: TextStyle(
                                  fontSize: 24.sp,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                ' 50 ',
                                style: TextStyle(
                                  fontSize: 24.sp,
                                  color: Colors.white,
                                ),
                              ),
                              Image.asset(
                                'assets/images/rs_03.png',
                                width: 32.w,
                                fit: BoxFit.contain,
                              ),
                              Text(
                                '/day',
                                style: TextStyle(
                                  fontSize: 24.sp,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 24.w),
                        ],
                      )
                    : const SizedBox.shrink(),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () async {
                        RSLoading.show();
                        await Api.getDailyReward();
                        await RS.login.fetchUserInfo();
                        RSLoading.close();
                        dismiss(tag: loginRewardTag);
                      },
                      child: Container(
                        width: !RS.login.vipStatus.value ? 248.w : 528.w,
                        height: 96.w,
                        decoration: BoxDecoration(
                          color: const Color(0xffABC4E4).withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(100.r),
                          border: Border.all(
                            width: 2.w,
                            color: const Color(
                              0xffFFFFFF,
                            ).withValues(alpha: 0.2),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            RSTextData.collect,
                            style: TextStyle(
                              fontSize: 32.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (!RS.login.vipStatus.value)
                      ButtonGradientWidget(
                        onTap: () {
                          Get.toNamed(
                            RSRouteNames.vip,
                            arguments: VipFrom.dailyrd,
                          );
                        },
                        width: 248.w,
                        height: 96,
                        margin: EdgeInsets.only(left: 32.w),
                        borderRadius: BorderRadius.circular(100.r),
                        child: Center(
                          child: Text(
                            RSTextData.gotToPro,
                            style: TextStyle(
                              color: const Color(0xff090E57),
                              fontSize: 32.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: Center(
              child: InkWell(
                onTap: () {
                  dismiss(tag: loginRewardTag);
                },
                child: Image.asset(
                  'assets/images/rs_close.png',
                  width: 56.w,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Future showPositiveReview() async {
    if (checkExist(positiveReviewTag)) {
      return;
    }
    Rx<RewardType> review = RewardType.unknown.obs;
    // return Get.bottomSheet(
    //   positiveReviewWidget(),
    //   isDismissible: false,
    //   isScrollControlled: true,
    //   enableDrag: false,
    // );
    return show(
      tag: positiveReviewTag,
      clickMaskDismiss: false,
      child: Column(
        children: [
          Container(
            width: Get.width,
            height: 548.w,
            margin: EdgeInsets.only(left: 85.w, right: 85.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32.r),
              image: const DecorationImage(
                image: AssetImage('assets/images/rs_29.png'),
                fit: BoxFit.contain,
              ),
            ),
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 70.w),
                  Padding(
                    padding: EdgeInsets.only(left: 40.w),
                    child: Text(
                      RSTextData.positiveReviewTitle,
                      style: TextStyle(
                        fontSize: 36.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 70.w),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            review.value = RewardType.dislike;
                          },
                          child: Image.asset(
                            review.value == RewardType.dislike
                                ? 'assets/images/rs_30.png'
                                : 'assets/images/rs_26.png',
                            width: 106.w,
                            fit: BoxFit.contain,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            review.value = RewardType.accept;
                          },
                          child: Image.asset(
                            review.value == RewardType.accept
                                ? 'assets/images/rs_31.png'
                                : 'assets/images/rs_27.png',
                            width: 106.w,
                            fit: BoxFit.contain,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            review.value = RewardType.like;
                          },
                          child: Image.asset(
                            review.value == RewardType.like
                                ? 'assets/images/rs_32.png'
                                : 'assets/images/rs_28.png',
                            width: 106.w,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 44.w),
                  review.value == RewardType.unknown
                      ? SizedBox(height: 54.w)
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 54.w,
                              padding: EdgeInsets.symmetric(horizontal: 24.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16.r),
                                  topRight: Radius.circular(16.r),
                                ),
                                color: const Color(0xff617085),
                              ),
                              child: Center(
                                child: Text(
                                  getRewardTypeDesc(review.value),
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                  review.value == RewardType.unknown
                      ? Container(
                          height: 88.w,
                          margin: EdgeInsets.symmetric(horizontal: 50.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.r),
                            border: Border.all(
                              width: 2.w,
                              color: const Color(
                                0xffFFFFFF,
                              ).withValues(alpha: 0.2),
                            ),
                            color: const Color(
                              0xffABC4E4,
                            ).withValues(alpha: 0.3),
                          ),
                          child: Center(
                            child: Text(
                              RSTextData.submit,
                              style: TextStyle(
                                fontSize: 28.sp,
                                color: const Color(0xffABC4E4),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.symmetric(horizontal: 50.w),
                          child: ButtonGradientWidget(
                            onTap: () {
                              SmartDialog.dismiss();
                              if (review.value == RewardType.like) {
                                RoutePages.openAppStoreReview();
                              } else {
                                RoutePages.toEmail();
                              }
                            },
                            height: 88,
                            width: Get.width,
                            borderRadius: BorderRadius.circular(100.r),
                            child: Center(
                              child: Text(
                                review.value == RewardType.like
                                    ? RSTextData.submit
                                    : RSTextData.subFeedback,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 32.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
          SizedBox(height: 52.w),
          InkWell(
            onTap: () {
              SmartDialog.dismiss();
            },
            child: Image.asset(
              'assets/images/rs_close.png',
              width: 56.w,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }

  static Future hiddenGiftLoading() {
    return SmartDialog.dismiss(tag: giftLoadingTag);
  }

  static bool rateLevel3Shoed = false;

  static bool rateCollectShowd = false;

  static bool checkExist(String tag) {
    return SmartDialog.checkExist(tag: tag);
  }

  static Future<void> showRechargeSuccess(int number) async {
    if (checkExist(rechargeSuccTag)) {
      return;
    }
    return show(
      tag: rechargeSuccTag,
      clickMaskDismiss: false,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 672.w,
            height: 672.w,
            // padding: EdgeInsets.only(left: 52.w, right: 72.w, top: 100.w),
            // margin: EdgeInsets.only(bottom: 76.w),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/rs_34.png'),
                fit: BoxFit.contain,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 192.w),
                Container(
                  margin: EdgeInsets.only(left: 400.w),
                  padding: EdgeInsets.symmetric(
                    vertical: 4.w,
                    horizontal: 12.w,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24.r),
                      topRight: Radius.circular(24.r),
                      bottomRight: Radius.circular(24.r),
                    ),
                    color: Colors.white,
                  ),
                  child: Text(
                    '+$number',
                    style: TextStyle(
                      fontSize: 24.sp,
                      color: const Color(0xff090E57),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: Center(
              child: InkWell(
                onTap: () {
                  SmartDialog.dismiss(tag: rechargeSuccTag);
                },
                child: Image.asset(
                  'assets/images/rs_close.png',
                  width: 56.w,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Future<void> showUndrDialog({
    String? title,
    String? message,
    Widget? messageWidget,
    bool? clickMaskDismiss = false,
    String? cancelText,
    String? confirmText,
    void Function()? onCancel,
    void Function()? onConfirm,
  }) async {
    return DialogWidget.show(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: onCancel,
            child: Image.asset(
              "assets/images/close.png",
              width: 48.w,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: 32.w),
          Container(
            width: 640.w,
            padding: EdgeInsets.symmetric(vertical: 32.w, horizontal: 52.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.r),
              gradient: LinearGradient(
                begin: AlignmentDirectional.topCenter,
                end: AlignmentDirectional.bottomCenter,
                colors: [const Color(0xFFEBFFCC), const Color(0xFFFFFFFF)],
                stops: const [0.0, 0.3],
              ),
            ),
            child: Column(
              children: [
                Text(
                  RSTextData.tips,
                  style: TextStyle(
                    fontSize: 40.sp,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff000000),
                  ),
                ),
                SizedBox(height: 32.w),
                Stack(
                  children: [
                    Image.asset(
                      "assets/images/rs_68.png",
                      width: 198.w,
                      fit: BoxFit.contain,
                    ),
                    Positioned(
                      bottom: 0,
                      width: 198.w,
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 4.w,
                            horizontal: 16.w,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(26.r),
                              bottomRight: Radius.circular(26.r),
                            ),
                            color: Color(0xff1A2608),
                          ),
                          child: Text(
                            RSTextData.nice,
                            style: TextStyle(
                              fontFamily: "Montserrat",
                              fontSize: 24.sp,
                              color: RSAppColors.primaryColor,
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 32.w),
                Text(
                  message ?? '',
                  style: TextStyle(
                    fontSize: 28.sp,
                    color: Color(0xff4D4D4D),
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 64.w),
                ButtonGradientWidget(
                  height: 88,
                  onTap: onConfirm,
                  child: Center(
                    child: Text(
                      confirmText ?? RSTextData.confirm,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      clickMaskDismiss: clickMaskDismiss,
      tag: undrDialog,
    );
  }
}
