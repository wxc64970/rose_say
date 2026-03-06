import 'dart:convert';

enum MessageSource {
  text('TEXT_GEN'),
  video('VIDEO'),
  audio('AUDIO'),
  photo('PHOTO'),
  gift('GIFT'),
  clothe('CLOTHE'),

  sendText('sendText'),
  waitAnswer('waitAnswer'),
  tips('tips'),
  scenario('scenario'),
  intro('intro'),
  welcome('welcome'),
  maskTips('maskTips'),
  error('error');

  final String value;
  const MessageSource(this.value);

  static final Map<String, MessageSource> _map = {
    for (var e in MessageSource.values) e.value: e,
  };

  static MessageSource? fromSource(String? source) => _map[source];
}

class RSMessageModel {
  String? answer;
  int? atokens;
  int? audioDuration;
  String? audioUrl;
  String? characterId;
  int? conversationId;
  int? createTime;
  int? deleted;
  String? id;
  String? imgUrl;
  int? likes;
  String? mediaLock;
  String? model;
  int? modifyTime;
  String? msgId;
  String? params;
  String? platform;
  int? qtokens;
  String? question;
  int? templateId;
  String? textLock;
  String? userId;
  int? videoDuration;
  String? videoUrl;
  String? thumbLink;
  String? voiceUrl;
  int? voiceDur;
  ChatAnserLevel? appUserChatLevel;
  bool? upgrade;
  int? rewards;
  String? translateAnswer;
  int? giftId;
  String? giftImg;
  String? src;

  bool? onAnswer;
  bool isRead = false;
  bool showTranslate = false;
  bool typewriterAnimated = false;

  MessageSource _source = MessageSource.text; // 用私有变量来存储 source 的值

  MessageSource get source {
    if (videoUrl != null) {
      return MessageSource.video;
    }
    if (imgUrl != null) {
      return MessageSource.photo;
    }
    if (audioUrl != null) {
      return MessageSource.audio;
    }
    return MessageSource.fromSource(src) ?? _source;
  }

  set source(MessageSource value) {
    _source = value;
  }

  RSMessageModel({
    this.answer,
    this.atokens,
    this.audioDuration,
    this.audioUrl,
    this.characterId,
    this.conversationId,
    this.createTime,
    this.deleted,
    this.id,
    this.imgUrl,
    this.likes,
    this.mediaLock,
    this.model,
    this.modifyTime,
    this.msgId,
    this.params,
    this.platform,
    this.qtokens,
    this.question,
    this.templateId,
    this.textLock,
    this.userId,
    this.videoDuration,
    this.videoUrl,
    this.onAnswer = false,
    this.voiceUrl,
    this.voiceDur,
    this.appUserChatLevel,
    this.upgrade,
    this.rewards,
    this.translateAnswer,
    this.thumbLink,
    this.giftId,
    this.giftImg,
    this.src,
  });

  factory RSMessageModel.fromRawJson(String str) =>
      RSMessageModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RSMessageModel.fromJson(Map<String, dynamic> json) => RSMessageModel(
    answer: json["vsogaa"],
    atokens: json["atokens"],
    audioDuration: json["audio_duration"],
    audioUrl: json["audio_url"],
    characterId: json["char_id"],
    conversationId: json["lmehbg"],
    createTime: json["creat_time"],
    deleted: json["deleted"],
    id: json["oklstx"],
    imgUrl: json["img_url"],
    likes: json["like_cnt"],
    mediaLock: json["media_lock"],
    model: json["model"],
    modifyTime: json["pibyvt"],
    msgId: json["msg_identifier"],
    params: json["params"],
    platform: json["platfrm"],
    qtokens: json["qtokens"],
    question: json["glxtwp"],
    templateId: json["tmpl_id"],
    textLock: json["text_lock"],
    userId: json["usr_id"],
    videoDuration: json["video_duration"],
    videoUrl: json["video_url"],
    thumbLink: json["thumb_link"] ?? json["uzlohq"],
    voiceUrl: json["voice_link"],
    voiceDur: json["voice_dur"],
    appUserChatLevel: json["zafnvm"] == null
        ? null
        : ChatAnserLevel.fromJson(json["zafnvm"]),
    upgrade: json["egspjo"],
    rewards: json["eeusex"],
    translateAnswer: json["xnrwau"],
    giftId: json["gift_id"],
    giftImg: json["gift_img"],
    src: json["deenhq"],
  );

  Map<String, dynamic> toJson() => {
    "vsogaa": answer,
    "atokens": atokens,
    "audio_duration": audioDuration,
    "audio_url": audioUrl,
    "char_id": characterId,
    "lmehbg": conversationId,
    "creat_time": createTime,
    "deleted": deleted,
    "oklstx": id,
    "img_url": imgUrl,
    "like_cnt": likes,
    "media_lock": mediaLock,
    "model": model,
    "pibyvt": modifyTime,
    "msg_identifier": msgId,
    "params": params,
    "platfrm": platform,
    "qtokens": qtokens,
    "glxtwp": question,
    "tmpl_id": templateId,
    "text_lock": textLock,
    "usr_id": userId,
    "video_duration": videoDuration,
    "video_url": videoUrl,
    "voice_link": voiceUrl,
    "voice_dur": voiceDur,
    "zafnvm": appUserChatLevel?.toJson(),
    "egspjo": upgrade,
    "eeusex": rewards,
    "xnrwau": translateAnswer,
    "thumb_link": thumbLink,
    "gift_id": giftId,
    "gift_img": giftImg,
    "deenhq": src,
  };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RSMessageModel && other.id == id && other.source == source;
  }

  @override
  int get hashCode => id.hashCode;
}

class ChatAnserLevel {
  final int? id;
  final String? userId;
  final int? conversationId;
  final String? charId;
  final int? level;
  final double? progress;
  final double? upgradeRequirements;
  final int? rewards;

  ChatAnserLevel({
    this.id,
    this.userId,
    this.conversationId,
    this.charId,
    this.level,
    this.progress,
    this.upgradeRequirements,
    this.rewards,
  });

  ChatAnserLevel copyWith({
    int? id,
    String? userId,
    int? conversationId,
    String? charId,
    int? level,
    double? progress,
    double? upgradeRequirements,
    int? rewards,
  }) => ChatAnserLevel(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    conversationId: conversationId ?? this.conversationId,
    charId: charId ?? this.charId,
    level: level ?? this.level,
    progress: progress ?? this.progress,
    upgradeRequirements: upgradeRequirements ?? this.upgradeRequirements,
    rewards: rewards ?? this.rewards,
  );

  factory ChatAnserLevel.fromRawJson(String str) =>
      ChatAnserLevel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ChatAnserLevel.fromJson(Map<String, dynamic> json) => ChatAnserLevel(
    id: json['oklstx'],
    userId: json['skhehf'],
    conversationId: json['lmehbg'],
    charId: json['char_id'],
    level: json['tenlfz'],
    progress: json['progress'],
    upgradeRequirements: json['upgrade_requirements'],
    rewards: json['eeusex'],
  );

  Map<String, dynamic> toJson() => {
    'oklstx': id,
    'skhehf': userId,
    'lmehbg': conversationId,
    'char_id': charId,
    'tenlfz': level,
    'progress': progress,
    'upgrade_requirements': upgradeRequirements,
    'eeusex': rewards,
  };
}
