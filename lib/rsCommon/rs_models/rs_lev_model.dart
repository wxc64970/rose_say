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
    id: json['oklstx'],
    level: json['tenlfz'],
    reward: json['bxighm'],
    title: json['sejfee'],
  );

  Map<String, dynamic> toJson() => {
    'oklstx': id,
    'tenlfz': level,
    'bxighm': reward,
    'sejfee': title,
  };
}
