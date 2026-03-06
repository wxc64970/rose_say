import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rose_say/rsCommon/index.dart';
import 'package:rose_say/rsPages/rsmessage/index.dart';

import 'widgets.dart';

class RSInpBar extends StatefulWidget {
  const RSInpBar({super.key});

  @override
  State<RSInpBar> createState() => _InputBarState();
}

class _InputBarState extends State<RSInpBar> {
  late TextEditingController textEditingController;
  bool isSend = false;
  final FocusNode focusNode = FocusNode();
  final RsmessageController ctr = Get.find<RsmessageController>();

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
    textEditingController.addListener(_onInputChange);
  }

  @override
  void dispose() {
    super.dispose();
    textEditingController.removeListener(_onInputChange);
    focusNode.dispose();
  }

  void firstClickChatInputBox() async {
    focusNode.unfocus();
    RS.storage.setFirstClickChatInputBox(false);
    setState(() {}); // 更新UI，移除覆盖层

    await DialogWidget.alert(
      message: RSTextData.createMaskProfileDescription,
      cancelText: RSTextData.cancel,
      confirmText: RSTextData.confirm,
      clickMaskDismiss: false,
      onConfirm: () {
        DialogWidget.dismiss();
        Get.toNamed(RSRouteNames.mask);
      },
    );
  }

  void _onInputChange() async {
    if (textEditingController.text.length > 500) {
      RSToast.show(RSTextData.maxInputLength);
      // 截断文本到500字符
      textEditingController.text = textEditingController.text.substring(0, 500);
      // 将光标移到文本末尾
      textEditingController.selection = TextSelection.fromPosition(
        TextPosition(offset: textEditingController.text.length),
      );
    }
    isSend = textEditingController.text.isNotEmpty;
    setState(() {});
  }

  // 0  tease, 1 undress, 2 gift, 3 mask, 100 screen, 101 sortlong
  void onTapTag(int index) {
    if (index == 100) {
      FocusManager.instance.primaryFocus?.unfocus();
      Future.delayed(Duration(milliseconds: 300), () {
        editScene(500.w);
      });
    } else if (index == 101) {
      // 聊天模型 chat_model short / long
      showChatModel();
    } else {
      final item = ctr.state.inputTags[index];
      final id = item['id'];

      if (id == 0) {
        List<String> list = item['list'];
        textEditingController.text = list.randomOrNull ?? '';
        onSend();
      } else if (id == 1) {
        Get.toNamed(RSRouteNames.undr, arguments: ctr.state.role);
      } else if (id == 2) {
        // showGift();
      } else if (id == 3) {
        Get.toNamed(RSRouteNames.mask);
      } else {
        RSToast.show(RSTextData.notSupport);
      }
    }
  }

  void editScene(heigth) {
    Get.bottomSheet(
      RSMsgEditScreen(
        content: ctr.state.session.scene ?? '',
        onInputTextFinish: (v) {
          if (v == ctr.state.session.scene) {
            Get.back();
            return;
          }
          if (!RS.login.vipStatus.value) {
            Get.toNamed(RSRouteNames.vip, arguments: VipFrom.scenario);
            return;
          }
          Get.back();
          ctr.editScene(v);
        },
        subtitle: Row(
          spacing: 4,
          children: [
            Text(
              RSTextData.editScenario,
              style: TextStyle(
                color: const Color(0xffFFFFFF),
                fontSize: 32.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        height: heigth,
      ),
      enableDrag: false, // 禁用底部表单拖拽，避免与文本选择冲突
      isScrollControlled: true,
      isDismissible: true,
      ignoreSafeArea: false,
    );
  }

  void showChatModel() {
    final isLong = ctr.state.session.chatModel == 'long';
    Get.bottomSheet(
      RSModSheet(
        isLong: isLong,
        onTap: (bool v) {
          ctr.editChatMode(v);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          ctr.state.inputTags.isEmpty
              ? const SizedBox()
              : MsgInputButtons(tags: ctr.state.inputTags, onTap: onTapTag),
          Container(
            padding: EdgeInsets.only(bottom: 28.w),
            child: Stack(
              children: [
                SafeArea(
                  top: false,
                  left: false,
                  right: false,
                  child: Row(
                    spacing: 16.w,
                    children: [
                      Expanded(
                        child: Container(
                          constraints: BoxConstraints(maxHeight: 88.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.r),
                            border: Border.all(
                              width: 1.w,
                              color: const Color(
                                0xffFFFFFF,
                              ).withValues(alpha: 0.2),
                            ),
                            color: const Color(0xff181B28),
                          ),
                          child: Row(
                            children: [
                              SizedBox(width: 16.w),
                              _buildSpecialButton(),
                              Flexible(child: _buildTextField()),
                              SizedBox(width: 16.w),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: onSend,
                        child: Container(
                          width: 88.w,
                          height: 88.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.r),
                            border: Border.all(
                              width: 1.w,
                              color: const Color(
                                0xffFFFFFF,
                              ).withValues(alpha: 0.2),
                            ),
                            color: const Color(0xff181B28),
                          ),
                          child: Center(
                            child: Image.asset(
                              "assets/images/rs_10.png",
                              width: 48.w,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // 第一次使用时的覆盖层
                if (RS.storage.firstClickChatInputBox)
                  Positioned.fill(
                    child: GestureDetector(onTap: firstClickChatInputBox),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField() {
    return TextField(
      textInputAction: TextInputAction.send,
      onEditingComplete: onSend,
      minLines: 1,
      maxLines: null,
      style: TextStyle(
        height: 1.2,
        color: Colors.white,
        fontSize: 28.sp,
        fontWeight: FontWeight.w400,
      ),
      controller: textEditingController,
      enableInteractiveSelection: true, // 确保文本选择功能启用
      dragStartBehavior: DragStartBehavior.down, // 优化拖拽行为
      cursorColor: Colors.white,
      decoration: InputDecoration(
        // hintText: LocaleKeys.type_here.tr,
        hintText: RSTextData.typeHere,
        hintStyle: const TextStyle(color: Color(0xFF617085)),
        fillColor: Colors.transparent,
        border: InputBorder.none,
        filled: true,
        isDense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 24.w),
      ),
      autofocus: false,
      focusNode: focusNode,
    );
  }

  void onSend() async {
    String content = textEditingController.text.trim();
    if (content.isNotEmpty) {
      focusNode.unfocus();
      ctr.sendMsg(content);
      textEditingController.clear();
    } else {
      textEditingController.clear();
      return;
    }
    RSlogEvent('c_chat_send');
  }

  Widget _buildSpecialButton() {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(focusNode);

        final text = textEditingController.text;
        final selection = textEditingController.selection;

        // Insert "**" at the current cursor position
        final newText = text.replaceRange(selection.start, selection.end, '**');

        // Update the text and set the cursor between the two asterisks
        textEditingController.value = TextEditingValue(
          text: newText,
          selection: TextSelection.fromPosition(
            TextPosition(offset: selection.start + 1),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.only(top: 4),
        width: 20,
        height: 32,
        child: Center(
          child: Text(
            '*',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class MsgInputButtons extends StatelessWidget {
  const MsgInputButtons({super.key, required this.tags, required this.onTap});

  final List<dynamic> tags;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.w, top: 20.w),
      alignment: Alignment.bottomCenter,
      height: 52.w,
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 52.w,
              alignment: Alignment.center,
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final item = tags[index];
                  int color = item['color'] ?? Colors.black;

                  return GestureDetector(
                    onTap: () => onTap(index),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(40.r),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xff181B28),
                          border: Border.all(
                            width: 1.w,
                            color: const Color(
                              0xffFFFFFF,
                            ).withValues(alpha: 0.2),
                          ),
                        ),

                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.symmetric(
                          vertical: 10.w,
                          horizontal: 16.w,
                        ),
                        child: Row(
                          spacing: 8.w,
                          children: [
                            Image.asset(
                              "${item['icon']}",
                              width: 32.w,
                              fit: BoxFit.contain,
                            ),
                            Text(
                              item['name'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20.sp,
                                color: Color(color),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(width: 12),
                itemCount: tags.length,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              onTap(100);
            },
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xff181B28),
                border: Border.all(
                  width: 1.w,
                  color: const Color(0xffFFFFFF).withValues(alpha: 0.2),
                ),
                borderRadius: BorderRadius.circular(40.r),
              ),

              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 24.w),
              child: Image.asset(
                'assets/images/rs_14.png',
                width: 36.w,
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(width: 8.w),
          GestureDetector(
            onTap: () {
              onTap(101);
            },
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xff181B28),
                border: Border.all(
                  width: 1.w,
                  color: const Color(0xffFFFFFF).withValues(alpha: 0.2),
                ),
                borderRadius: BorderRadius.circular(40.r),
              ),

              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 24.w),
              child: Image.asset(
                'assets/images/rs_15.png',
                width: 36.w,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
