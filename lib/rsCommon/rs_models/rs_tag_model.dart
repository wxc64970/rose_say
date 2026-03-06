import 'dart:convert';

class RSTagsModel {
  final String? labelType;
  final List<TagModel>? tags;

  RSTagsModel({this.labelType, this.tags});

  factory RSTagsModel.fromRawJson(String str) =>
      RSTagsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RSTagsModel.fromJson(Map<String, dynamic> json) => RSTagsModel(
    labelType: json["label_type"],
    tags: json["tags"] == null
        ? []
        : List<TagModel>.from(json["tags"]!.map((x) => TagModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "label_type": labelType,
    "tags": tags == null
        ? []
        : List<dynamic>.from(tags!.map((x) => x.toJson())),
  };
}

class TagModel {
  final int? id;
  final String? name;
  String? labelType;
  bool? remark;

  TagModel({this.id, this.name, this.labelType, this.remark});

  factory TagModel.fromRawJson(String str) =>
      TagModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TagModel.fromJson(Map<String, dynamic> json) => TagModel(
    id: json["id"],
    name: json["name"],
    labelType: json["label_type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "label_type": labelType,
  };
}
