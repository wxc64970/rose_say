import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rose_say/rsCommon/index.dart';
import 'package:rose_say/rsPages/rsmessage/controller.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'widgets.dart';

class RSMsgListWidget extends GetView<RsmessageController> {
  const RSMsgListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const bottom = 20.0;
    final listHeight =
        MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.bottom -
        20;
    final top = RS.storage.isRSB ? listHeight * 0.4 : listHeight * 0.3;
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        GestureDetector(
          onPanDown: (_) {
            try {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (currentFocus.focusedChild != null &&
                  !currentFocus.hasPrimaryFocus) {
                FocusManager.instance.primaryFocus?.unfocus();
              } else {
                SystemChannels.textInput.invokeMethod('TextInput.hide');
              }
            } catch (e) {
              log.e(e.toString());
            }
          },
          child: Obx(() {
            final list = controller.state.list.reversed.toList();
            log.e(list.length);
            return ShaderMask(
              blendMode: BlendMode.dstIn,
              shaderCallback: (rect) {
                return LinearGradient(
                  colors: const [
                    Colors.transparent,
                    Colors.transparent,
                    Colors.white,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: RS.storage.isRSB
                      ? const [0, 0.4, 0.5]
                      : const [0, 0.2, 0.4],
                ).createShader(rect);
              },
              child: ListView.separated(
                controller: controller.autoController,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric().copyWith(
                  top: top,
                  bottom: bottom,
                ),
                reverse: true,
                itemBuilder: (context, index) {
                  var item = list[index];
                  return AutoScrollTag(
                    controller: controller.autoController,
                    index: index,
                    key: ValueKey('${item.id}_${item.source.name}'), // 更稳定的key
                    child: MessageItem(msg: item),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 40.w);
                },
                itemCount: list.length,
              ),
            );
          }),
        ),
      ],
    );
  }
}
