import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rose_say/rsCommon/index.dart';
import 'package:rose_say/rsPages/rsmessage/controller.dart';

import 'widgets.dart';

/// 文本消息容器组件
class RSTItem extends StatefulWidget {
  const RSTItem({super.key, required this.msg, this.title});

  final RSMessageModel msg;
  final String? title;

  @override
  State<RSTItem> createState() => _TextItemState();
}

class _TextItemState extends State<RSTItem> {
  // 性能优化：使用AppColors统一颜色管理
  static final Color _bgColor = const Color(0xff333B47).withValues(alpha: 0.9);
  static final BorderRadius borderRadius = BorderRadius.only(
    topRight: Radius.circular(24.r),
    bottomRight: Radius.circular(24.r),
    bottomLeft: Radius.circular(24.r),
  );

  // 控制器缓存，避免重复查找
  late final RsmessageController _ctr;

  @override
  void initState() {
    super.initState();
    _ctr = Get.find<RsmessageController>();
  }

  @override
  Widget build(BuildContext context) {
    final msg = widget.msg;

    // 错误隔离设计：安全获取消息内容
    final sendText = _getSendTextSafely(msg);
    final receivText = _getReceiveTextSafely(msg);

    // 优化后的显示逻辑判断
    final shouldShowSend = _shouldShowSendMessage(msg, sendText);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (shouldShowSend)
          Padding(
            padding: EdgeInsets.only(bottom: 24.w),
            child: RSSItem(msg: widget.msg),
          ),
        if (receivText != null) _buildReceiveText(context),
      ],
    );
  }

  /// 错误隔离设计：安全获取发送文本
  String? _getSendTextSafely(RSMessageModel msg) {
    try {
      return msg.question;
    } catch (e) {
      debugPrint('[TextContainer] 获取发送文本失败: $e');
      return null;
    }
  }

  /// 错误隔离设计：安全获取接收文本
  String? _getReceiveTextSafely(RSMessageModel msg) {
    try {
      return msg.answer;
    } catch (e) {
      debugPrint('[TextContainer] 获取接收文本失败: $e');
      return null;
    }
  }

  /// 优化后的发送消息显示判断逻辑
  bool _shouldShowSendMessage(RSMessageModel msg, String? sendText) {
    try {
      if (msg.source == MessageSource.clothe) {
        return false;
      }

      return msg.source == MessageSource.sendText ||
          (sendText != null && msg.onAnswer != true);
    } catch (e) {
      debugPrint('[TextContainer] 判断发送消息显示失败: $e');
      return false;
    }
  }

  Widget _buildReceiveText(BuildContext context) {
    return Obx(() {
      final isVip = _getVipStatusSafely();
      final isLocked = _isMessageLocked();

      if (!isVip && isLocked) {
        return RSTLockItem(textContent: widget.msg.answer ?? '');
      }

      return _buildText(context);
    });
  }

  bool _getVipStatusSafely() {
    return RS.login.vipStatus.value;
  }

  bool _isMessageLocked() {
    return widget.msg.textLock == MsgLockLevel.private.value;
  }

  Widget _buildText(BuildContext context) {
    final msg = widget.msg;

    final textContent =
        msg.translateAnswer ??
        msg.answer ??
        "Hmm… we lost connection for a bit. Please try again!";

    final maxWidth = MediaQuery.of(context).size.width * 0.8;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(24.w),
          decoration: BoxDecoration(
            color: _bgColor,
            borderRadius: borderRadius,
          ),
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.title != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    widget.title!,
                    style: TextStyle(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w700,
                      color: RSAppColors.primaryColor,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              RSRicTItem(
                text: textContent,
                isSend: false,
                isTypingAnimation: msg.typewriterAnimated == true,
                onAnimationComplete: () => _handleAnimationComplete(msg),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        if (!_isTypingAnimationActive(msg))
          _buildActionButtons(
            msg: msg,
            showTranslate: false,
            showTransBtn: false,
          ),
      ],
    );
  }

  /// 处理打字动画完成事件
  void _handleAnimationComplete(RSMessageModel msg) {
    try {
      if (msg.typewriterAnimated == true) {
        setState(() {
          msg.typewriterAnimated = false;
          _ctr.state.list.refresh();
        });
      }
    } catch (e) {
      debugPrint('[TextContainer] 处理动画完成失败: $e');
    }
  }

  /// 检查打字动画是否激活
  bool _isTypingAnimationActive(RSMessageModel msg) {
    try {
      return msg.typewriterAnimated == true;
    } catch (e) {
      debugPrint('[TextContainer] 检查动画状态失败: $e');
      return false;
    }
  }

  /// 构建操作按钮行
  Widget _buildActionButtons({
    required RSMessageModel msg,
    required bool showTranslate,
    required bool showTransBtn,
  }) {
    // return Wrap(
    //   spacing: 16.w,
    //   crossAxisAlignment: WrapCrossAlignment.center,
    //   children: [
    //     // 只有最后一条消息才显示消息操作按钮
    //     if (_isLastMessage(msg)) ..._buildMsgActions(msg),

    //     // 举报按钮（非大屏模式下显示）
    //     if (!RS.storage.isRSB) _buildReportButton(),
    //   ],
    // );
    return Row(
      children: [
        if (_isLastMessage(msg) || !RS.storage.isRSB)
          ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 10.w, // 水平模糊度（对应 blur 10px）
                sigmaY: 10.w, // 垂直模糊度（对应 blur 10px）
              ),
              // 关键2：实现 box-shadow + 背景半透（需嵌套 Container）
              child: Container(
                height: 68.w,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Row(
                  spacing: 16.w,
                  children: [
                    if (_isLastMessage(msg)) ..._buildMsgActions(msg),
                    if (!RS.storage.isRSB)
                      Row(
                        spacing: 16.w,
                        children: [
                          if (_isLastMessage(msg))
                            Container(
                              width: 2.w,
                              height: 20.w,
                              color: Colors.white24,
                            ),
                          _buildReportButton(),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  /// 检查是否为最后一条消息
  bool _isLastMessage(RSMessageModel msg) {
    try {
      return widget.msg == _ctr.state.list.lastOrNull;
    } catch (e) {
      debugPrint('[TextContainer] 检查最后消息失败: $e');
      return false;
    }
  }

  /// 构建举报按钮
  Widget _buildReportButton() {
    return InkWell(
      onTap: RoutePages.report,
      child: Image.asset(
        'assets/images/rs_19.png',
        width: 60.w,
        fit: BoxFit.contain,
      ),
    );
  }

  /// 构建消息操作按钮组
  List<Widget> _buildMsgActions(RSMessageModel msg) {
    final hasEditAndRefresh = _hasEditAndRefreshActions(msg);

    return [
      // 续写按钮
      _buildContinueButton(),
      // 编辑和刷新按钮（仅特定消息类型）
      if (hasEditAndRefresh) ...[
        Container(width: 2.w, height: 20.w, color: Colors.white24),
        _buildEditButton(msg),
        Container(width: 2.w, height: 20.w, color: Colors.white24),
        _buildRefreshButton(msg),
      ],
    ];
  }

  /// 判断消息是否支持编辑和刷新操作
  bool _hasEditAndRefreshActions(RSMessageModel msg) {
    try {
      return msg.source == MessageSource.text ||
          msg.source == MessageSource.video ||
          msg.source == MessageSource.audio ||
          msg.source == MessageSource.photo;
    } catch (e) {
      debugPrint('[TextContainer] 检查编辑刷新权限失败: $e');
      return false;
    }
  }

  /// 构建续写按钮
  Widget _buildContinueButton() {
    return RepaintBoundary(
      child: InkWell(
        splashColor: Colors.transparent,
        onTap: () => _handleContinueWriting(),
        child: Image.asset(
          'assets/images/rs_16.png',
          width: 60.w,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  /// 处理续写事件
  void _handleContinueWriting() {
    try {
      _ctr.continueWriting();
    } catch (e) {
      debugPrint('[TextContainer] 续写失败: $e');
    }
  }

  /// 构建编辑按钮
  Widget _buildEditButton(RSMessageModel msg) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () => _handleEditMessage(msg),
      child: Image.asset(
        'assets/images/rs_17.png',
        width: 60.w,
        fit: BoxFit.contain,
      ),
    );
  }

  /// 处理编辑消息事件
  void _handleEditMessage(RSMessageModel msg) {
    FocusManager.instance.primaryFocus?.unfocus();
    Future.delayed(const Duration(milliseconds: 300), () {
      try {
        Get.bottomSheet(
          RSMsgEditScreen(
            content: msg.answer ?? '',
            onInputTextFinish: (value) {
              Get.back();
              _ctr.editMsg(value, msg);
            },
            height: 500.w,
          ),
          enableDrag: false, // 禁用底部表单拖拽，避免与文本选择冲突
          isScrollControlled: true,
          isDismissible: true,
          ignoreSafeArea: false,
        );
      } catch (e) {
        debugPrint('[TextContainer] 编辑消息失败: $e');
      }
    });
  }

  /// 构建刷新按钮
  Widget _buildRefreshButton(RSMessageModel msg) {
    return RepaintBoundary(
      child: InkWell(
        splashColor: Colors.transparent,
        onTap: () => _handleResendMessage(msg),
        child: Image.asset(
          'assets/images/rs_18.png',
          width: 60.w,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  /// 处理重发消息事件
  void _handleResendMessage(RSMessageModel msg) {
    try {
      _ctr.resendMsg(msg);
    } catch (e) {
      debugPrint('[TextContainer] 重发消息失败: $e');
    }
  }
}
