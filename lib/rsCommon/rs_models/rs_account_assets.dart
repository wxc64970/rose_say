import 'dart:convert';

class RSAccountAssets {
  final int? id;
  final String? userId;
  final int? createImgNum;
  final int? infoAiWriteNum;
  final int? imgAiWriteNum;
  final int? recommendNum;
  final int? usePrivateNum;
  final int? privateNum;

  RSAccountAssets({
    this.id,
    this.userId,
    this.createImgNum,
    this.infoAiWriteNum,
    this.imgAiWriteNum,
    this.recommendNum,
    this.usePrivateNum,
    this.privateNum,
  });

  RSAccountAssets copyWith({
    int? id,
    String? userId,
    int? createImgNum,
    int? infoAiWriteNum,
    int? imgAiWriteNum,
    int? recommendNum,
    int? usePrivateNum,
    int? privateNum,
  }) => RSAccountAssets(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    createImgNum: createImgNum ?? this.createImgNum,
    infoAiWriteNum: infoAiWriteNum ?? this.infoAiWriteNum,
    imgAiWriteNum: imgAiWriteNum ?? this.imgAiWriteNum,
    recommendNum: recommendNum ?? this.recommendNum,
    usePrivateNum: usePrivateNum ?? this.usePrivateNum,
    privateNum: privateNum ?? this.privateNum,
  );

  factory RSAccountAssets.fromRawJson(String str) =>
      RSAccountAssets.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RSAccountAssets.fromJson(Map<String, dynamic> json) =>
      RSAccountAssets(
        id: json["id"],
        userId: json["user_id"],
        createImgNum: json["create_img_num"],
        infoAiWriteNum: json["info_ai_write_num"],
        imgAiWriteNum: json["img_ai_write_num"],
        recommendNum: json["recommend_num"],
        usePrivateNum: json["use_private_num"],
        privateNum: json["private_num"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "create_img_num": createImgNum,
    "info_ai_write_num": infoAiWriteNum,
    "img_ai_write_num": imgAiWriteNum,
    "recommend_num": recommendNum,
    "use_private_num": usePrivateNum,
    "private_num": privateNum,
  };
}
