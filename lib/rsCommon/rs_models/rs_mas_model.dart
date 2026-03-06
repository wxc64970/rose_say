import 'dart:convert';

class RSMaskModel {
  final int? id;
  final String? userId;
  final String? profileName;
  final int? gender;
  final int? age;
  final String? description;
  final String? otherInfo;

  RSMaskModel({
    this.id,
    this.userId,
    this.profileName,
    this.gender,
    this.age,
    this.description,
    this.otherInfo,
  });

  factory RSMaskModel.fromRawJson(String str) =>
      RSMaskModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RSMaskModel.fromJson(Map<String, dynamic> json) => RSMaskModel(
    id: json["id"],
    userId: json["user_id"],
    profileName: json["profile_name"],
    gender: json["gender"],
    age: json["age"],
    description: json["description"],
    otherInfo: json["other_info"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "profile_name": profileName,
    "gender": gender,
    "age": age,
    "description": description,
    "other_info": otherInfo,
  };
}
