import 'dart:convert';

class RSPricesModel {
  final int? sceneChange;
  final int? textMessage;
  final int? audioMessage;
  final int? photoMessage;
  final int? videoMessage;
  final int? generateImage;
  final int? generateVideo;
  final int? profileChange;
  final int? callAiCharacters;
  final int? infoAiWritePrice;
  final int? imgAiWritePrice;
  final int? imgAvatarPrice;

  RSPricesModel({
    this.sceneChange,
    this.textMessage,
    this.audioMessage,
    this.photoMessage,
    this.videoMessage,
    this.generateImage,
    this.generateVideo,
    this.profileChange,
    this.callAiCharacters,
    this.infoAiWritePrice,
    this.imgAiWritePrice,
    this.imgAvatarPrice,
  });

  factory RSPricesModel.fromRawJson(String str) =>
      RSPricesModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RSPricesModel.fromJson(Map<String, dynamic> json) => RSPricesModel(
    sceneChange: json["mebimu"],
    textMessage: json["gzotqd"],
    audioMessage: json["vskpoc"],
    photoMessage: json["bmpzmz"],
    videoMessage: json["tajrjb"],
    generateImage: json["vqkdes"],
    generateVideo: json["plfuka"],
    profileChange: json["ytqfkl"],
    callAiCharacters: json["hkcghe"],
    infoAiWritePrice: json["info_ai_write_price"],
    imgAiWritePrice: json["img_ai_write_price"],
    imgAvatarPrice: json["img_avatar_price"],
  );

  Map<String, dynamic> toJson() => {
    "mebimu": sceneChange,
    "gzotqd": textMessage,
    "vskpoc": audioMessage,
    "bmpzmz": photoMessage,
    "tajrjb": videoMessage,
    "vqkdes": generateImage,
    "plfuka": generateVideo,
    "ytqfkl": profileChange,
    "hkcghe": callAiCharacters,
    "info_ai_write_price": infoAiWritePrice,
    "img_ai_write_price": imgAiWritePrice,
    "img_avatar_price": imgAvatarPrice,
  };
}
