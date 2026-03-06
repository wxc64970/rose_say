import 'dart:convert';

class RSUsersModel {
  String? id;
  String? deviceId;
  String? token;
  String? platform;
  int? gems;
  dynamic audioSwitch;
  dynamic subscriptionEnd;
  String? nickname;
  String? idfa;
  String? adid;
  String? androidId;
  String? gpsAdid;
  bool? autoTranslate;
  bool? enableAutoTranslate;
  String? sourceLanguage;
  String? targetLanguage;
  int createImg;
  int createVideo;

  RSUsersModel({
    this.id,
    this.deviceId,
    this.token,
    this.platform,
    this.gems,
    this.audioSwitch,
    this.subscriptionEnd,
    this.nickname,
    this.idfa,
    this.adid,
    this.androidId,
    this.gpsAdid,
    this.autoTranslate,
    this.enableAutoTranslate,
    this.sourceLanguage,
    this.targetLanguage,
    this.createImg = 0,
    this.createVideo = 0,
  });

  factory RSUsersModel.fromRawJson(String str) =>
      RSUsersModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RSUsersModel.fromJson(Map<String, dynamic> json) => RSUsersModel(
    id: json["oklstx"],
    deviceId: json["cynwpk"],
    token: json["ukjcoh"],
    platform: json["bfibax"],
    gems: json["mkfwlu"],
    audioSwitch: json["audio_switch"],
    subscriptionEnd: json["hnjrmi"],
    nickname: json["hptzsl"],
    idfa: json["ehlodl"],
    adid: json["bnbclj"],
    androidId: json["android_id"],
    gpsAdid: json["gps_adid"],
    autoTranslate: json["oxpdcm"],
    enableAutoTranslate: json["iqkroz"],
    sourceLanguage: json["tncwkg"],
    targetLanguage: json["ykodbo"],
    createImg: json["ptumks"] ?? 0,
    createVideo: json["molfai"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "oklstx": id,
    "cynwpk": deviceId,
    "ukjcoh": token,
    "bfibax": platform,
    "mkfwlu": gems,
    "audio_switch": audioSwitch,
    "hnjrmi": subscriptionEnd,
    "hptzsl": nickname,
    "ehlodl": idfa,
    "bnbclj": adid,
    "android_id": androidId,
    "gps_adid": gpsAdid,
    "oxpdcm": autoTranslate,
    "iqkroz": enableAutoTranslate,
    "tncwkg": sourceLanguage,
    "ykodbo": targetLanguage,
    "ptumks": createImg,
    "molfai": createVideo,
  };
}
