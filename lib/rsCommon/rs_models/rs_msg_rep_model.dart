import 'dart:convert';

import 'package:rose_say/rsCommon/index.dart';

class RSMsgReplayModel {
  final String? convId;
  final String? msgId;
  final MessageAnswerModel? answer;

  RSMsgReplayModel({this.convId, this.msgId, this.answer});

  factory RSMsgReplayModel.fromRawJson(String str) =>
      RSMsgReplayModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RSMsgReplayModel.fromJson(Map<String, dynamic> json) =>
      RSMsgReplayModel(
        convId: json['fuvtng'],
        msgId: json['xycodp'],
        answer: json['vsogaa'] == null
            ? null
            : MessageAnswerModel.fromJson(json['vsogaa']),
      );

  Map<String, dynamic> toJson() => {
    'fuvtng': convId,
    'xycodp': msgId,
    'vsogaa': answer?.toJson(),
  };
}

class MessageAnswerModel {
  final String? content;
  final String? src;
  final String? lockLvl;
  final String? lockMed;
  final String? voiceUrl;
  final int? voiceDur;
  final String? resUrl;
  final int? duration;
  final String? thumbUrl;
  final String? translateContent;
  final bool? upgrade;
  final int? rewards;
  final ChatAnserLevel? appUserChatLevel;

  MessageAnswerModel({
    this.content,
    this.src,
    this.lockLvl,
    this.lockMed,
    this.voiceUrl,
    this.voiceDur,
    this.resUrl,
    this.duration,
    this.thumbUrl,
    this.translateContent,
    this.upgrade,
    this.rewards,
    this.appUserChatLevel,
  });

  factory MessageAnswerModel.fromRawJson(String str) =>
      MessageAnswerModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MessageAnswerModel.fromJson(Map<String, dynamic> json) =>
      MessageAnswerModel(
        content: json['content'],
        src: json['deenhq'],
        lockLvl: json['vkrwnd'],
        lockMed: json['awlqoj'],
        voiceUrl: json['mzyuei'],
        voiceDur: json['fkoevy'],
        resUrl: json['res_url'],
        duration: json['ppvgce'],
        thumbUrl: json['uzlohq'],
        translateContent: json['translate_content'],
        upgrade: json['egspjo'],
        rewards: json['eeusex'],
        appUserChatLevel: json['zafnvm'] == null
            ? null
            : ChatAnserLevel.fromJson(json['zafnvm']),
      );

  Map<String, dynamic> toJson() => {
    'content': content,
    'deenhq': src,
    'vkrwnd': lockLvl,
    'awlqoj': lockMed,
    'mzyuei': voiceUrl,
    'fkoevy': voiceDur,
    'res_url': resUrl,
    'ppvgce': duration,
    'uzlohq': thumbUrl,
    'translate_content': translateContent,
    'egspjo': upgrade,
    'eeusex': rewards,
    'zafnvm': appUserChatLevel,
  };
}
