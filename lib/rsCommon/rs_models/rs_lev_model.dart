import 'dart:convert';

class RSLevelModel {
  final int? id;
  final int? level;
  final int? reward;
  final String? title;

  RSLevelModel({this.id, this.level, this.reward, this.title});

  factory RSLevelModel.fromRawJson(String str) =>
      RSLevelModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RSLevelModel.fromJson(Map<String, dynamic> json) => RSLevelModel(
    id: json['id'],
    level: json['level'],
    reward: json['reward'],
    title: json['title'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'level': level,
    'reward': reward,
    'title': title,
  };
}
