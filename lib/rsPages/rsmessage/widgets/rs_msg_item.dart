import 'package:flutter/material.dart';
import 'package:rose_say/rsCommon/index.dart';

import 'widgets.dart';

class RSMsgContainerFactory {
  RSMsgContainerFactory._();

  static final Map<MessageSource, Widget Function(RSMessageModel)>
  _containerBuilders = {
    MessageSource.tips: (msg) => RSTipItem(msg: msg),
    MessageSource.maskTips: (msg) => RSTipItem(msg: msg),
    MessageSource.error: (msg) => RSTipItem(msg: msg),
    MessageSource.welcome: (msg) => RSTItem(msg: msg),
    MessageSource.scenario: (msg) =>
        RSTItem(msg: msg, title: "${RSTextData.scenario}:"),
    MessageSource.intro: (msg) =>
        RSTItem(msg: msg, title: "${RSTextData.intro}:"),
    MessageSource.sendText: (msg) => RSTItem(msg: msg),
    MessageSource.text: (msg) => RSTItem(msg: msg),
    MessageSource.photo: (msg) => RSImgItem(msg: msg),
    MessageSource.clothe: (msg) => RSImgItem(msg: msg),
    MessageSource.video: (msg) => RSVItem(msg: msg),
    MessageSource.audio: (msg) => RSAudItem(msg: msg, key: ValueKey(msg.id)),
  };

  /// 创建消息容器widget
  static Widget createContainer(MessageSource source, RSMessageModel msg) {
    final builder = _containerBuilders[source];
    return builder?.call(msg) ?? const SizedBox.shrink();
  }
}

class MessageItem extends StatelessWidget {
  const MessageItem({super.key, required this.msg});

  final RSMessageModel msg;

  MessageSource get source => msg.source;

  @override
  Widget build(BuildContext context) {
    return RSMsgContainerFactory.createContainer(source, msg);
  }
}
