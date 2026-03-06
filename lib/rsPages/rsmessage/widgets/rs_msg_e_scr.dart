import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:rose_say/rsCommon/index.dart';

class RSMsgEditScreen extends StatefulWidget {
  const RSMsgEditScreen({
    super.key,
    required this.onInputTextFinish,
    this.content,
    this.subtitle,
    this.height,
  });

  final String? content;
  final Widget? subtitle;
  final double? height;
  final Function(String text) onInputTextFinish;

  @override
  State<RSMsgEditScreen> createState() => _MessageEditScreenState();
}

class _MessageEditScreenState extends State<RSMsgEditScreen> {
  final focusNode = FocusNode();
  final textController = TextEditingController();

  @override
  void initState() {
    // focusNode.requestFocus();
    focusNode.unfocus();
    textController.addListener(_onTextChanged);
    if (widget.content != null && widget.content!.isNotEmpty) {
      textController.text = widget.content!;
    }
    super.initState();
  }

  void _onTextChanged() {
    if (textController.text.length > 500) {
      SmartDialog.showToast(
        RSTextData.maxInputLength,
        displayType: SmartToastType.onlyRefresh,
      );
      // 截断文本到500字符
      textController.text = textController.text.substring(0, 500);
      // 将光标移到文本末尾
      textController.selection = TextSelection.fromPosition(
        TextPosition(offset: textController.text.length),
      );
    }
  }

  void _onSure() {
    focusNode.unfocus();
    // 将值回调出去
    widget.onInputTextFinish(textController.text.trim());
  }

  @override
  void dispose() {
    textController.removeListener(_onTextChanged);
    textController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => focusNode.requestFocus(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  focusNode.unfocus();
                  Get.back();
                },
                child: Image.asset(
                  "assets/images/rs_close.png",
                  width: 56.w,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(width: 32.w),
            ],
          ),
          SizedBox(height: 8.w),
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
                padding: EdgeInsets.symmetric(vertical: 24.w, horizontal: 72.w),
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      widget.subtitle != null
                          ? Padding(
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
                                  widget.subtitle!,
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
                            )
                          : SizedBox(height: 60.w),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white12,
                          borderRadius: BorderRadius.circular(32.r),
                          // border: Border.all(
                          //   color: Color(0xffF4F7F0),
                          //   width: 2.w,
                          // ),
                        ),
                        child: NotificationListener<ScrollNotification>(
                          onNotification: (notification) {
                            // 阻止滚动通知传播到父级，避免与底部表单的拖拽冲突
                            return true;
                          },
                          child: TextField(
                            autofocus: true,
                            textInputAction: TextInputAction.newline, // 修改为换行操作
                            maxLines: widget.height == null ? 8 : 7, // 允许多行输入
                            minLines: widget.height == null ? 8 : 7, // 最小显示5行
                            maxLength: null,
                            enableInteractiveSelection: true, // 确保文本选择功能启用
                            dragStartBehavior: DragStartBehavior.down, // 优化拖拽行为
                            style: TextStyle(
                              height: 1.5, // 增加行高
                              color: const Color(0xffABC4E4),
                              fontSize: 28.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            controller: textController,
                            cursorColor: const Color(0xffABC4E4),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero, // 添加内边距
                              // hintText: LocaleKeys.please_input_custom_text.tr,
                              hintText: RSTextData.pleaseInputCustomText,
                              counterText: '',
                              hintStyle: const TextStyle(
                                color: Color(0xFFB3B3B3),
                              ),
                              fillColor: Colors.transparent,
                              border: InputBorder.none,
                              filled: true,
                              isDense: true,
                            ),
                            focusNode: focusNode,
                          ),
                        ),
                      ),
                      Container(
                        width: Get.width,
                        margin: EdgeInsets.only(
                          top: 32.w,
                          bottom: Get.mediaQuery.viewInsets.bottom,
                        ),
                        child: ButtonGradientWidget(
                          height: 100,
                          width: Get.width,
                          onTap: _onSure,
                          child: Center(
                            child: Text(
                              RSTextData.confirm,
                              style: TextStyle(
                                fontSize: 24.sp,
                                color: Colors.black,
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
            ],
          ),
        ],
      ),
    );
  }
}
