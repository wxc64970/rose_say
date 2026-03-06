import 'dart:convert';

class RSConversationModel {
  int? id;
  String? avatar;
  String? userId;
  String? title;
  bool? pinned;
  dynamic pinnedTime;
  String? characterId;
  dynamic model;
  int? templateId;
  String? voiceModel;
  dynamic lastMessage;
  int? updateTime;
  int? createTime;
  bool? collect;
  String? mode;
  dynamic background;
  int? cid;
  String? scene;
  int? profileId;
  String? chatModel;

  RSConversationModel({
    this.id,
    this.avatar,
    this.userId,
    this.title,
    this.pinned,
    this.pinnedTime,
    this.characterId,
    this.model,
    this.templateId,
    this.voiceModel,
    this.lastMessage,
    this.updateTime,
    this.createTime,
    this.collect,
    this.mode,
    this.background,
    this.cid,
    this.scene,
    this.profileId,
    this.chatModel,
  });

  factory RSConversationModel.fromRawJson(String str) =>
      RSConversationModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RSConversationModel.fromJson(Map<String, dynamic> json) =>
      RSConversationModel(
        id: json["oklstx"],
        avatar: json["ovtlro"],
        userId: json["skhehf"],
        title: json["sejfee"],
        pinned: json["pinned"],
        pinnedTime: json["pinned_time"],
        characterId: json["ugniji"],
        model: json["model"],
        templateId: json["qrlsvr"],
        voiceModel: json["voice_model"],
        lastMessage: json["ivvbrk"],
        updateTime: json["biaazj"],
        createTime: json["zdcetu"],
        collect: json["collect"],
        mode: json["mode"],
        background: json["background"],
        cid: json["oonagk"],
        scene: json["izfikp"],
        profileId: json["xfffiu"],
        chatModel: json["mrafzm"],
      );

  Map<String, dynamic> toJson() => {
    "oklstx": id,
    "ovtlro": avatar,
    "skhehf": userId,
    "sejfee": title,
    "pinned": pinned,
    "pinned_time": pinnedTime,
    "ugniji": characterId,
    "model": model,
    "qrlsvr": templateId,
    "voice_model": voiceModel,
    "ivvbrk": lastMessage,
    "biaazj": updateTime,
    "zdcetu": createTime,
    "collect": collect,
    "mode": mode,
    "background": background,
    "oonagk": cid,
    "izfikp": scene,
    "xfffiu": profileId,
    "mrafzm": chatModel,
  };
}
