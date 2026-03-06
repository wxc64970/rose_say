import 'dart:convert';

class RSPost {
  int? id;
  String? characterAvatar;
  String? characterId;
  String? characterName;
  String? cover;
  dynamic createTime;
  dynamic duration;
  bool? hideCharacter;
  bool? istop;
  String? media;
  dynamic mediaText;
  String? text;
  dynamic updateTime;
  bool? unlocked;
  int? price;

  RSPost({
    this.id,
    this.characterAvatar,
    this.characterId,
    this.characterName,
    this.cover,
    this.createTime,
    this.duration,
    this.hideCharacter,
    this.istop,
    this.media,
    this.mediaText,
    this.text,
    this.updateTime,
    this.unlocked,
    this.price,
  });

  factory RSPost.fromRawJson(String str) => RSPost.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RSPost.fromJson(Map<String, dynamic> json) => RSPost(
    id: json["oklstx"],
    characterAvatar: json["character_avatar"],
    characterId: json["ugniji"],
    characterName: json["essmpm"],
    cover: json["cover"],
    createTime: json["zdcetu"],
    duration: json["ppvgce"],
    hideCharacter: json["mtzbah"],
    istop: json["istop"],
    media: json["bouthu"],
    mediaText: json["qtefih"],
    text: json["text"],
    updateTime: json["biaazj"],
    unlocked: json["unlocked"],
    price: json["mpltqj"],
  );

  Map<String, dynamic> toJson() => {
    "oklstx": id,
    "character_avatar": characterAvatar,
    "ugniji": characterId,
    "essmpm": characterName,
    "cover": cover,
    "zdcetu": createTime,
    "ppvgce": duration,
    "mtzbah": hideCharacter,
    "istop": istop,
    "bouthu": media,
    "qtefih": mediaText,
    "text": text,
    "biaazj": updateTime,
    "unlocked": unlocked,
    "mpltqj": price,
  };
}
