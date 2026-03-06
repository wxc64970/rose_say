import 'dart:convert';

class RSAiAvatarOptions {
  int? id;
  String? name;
  List<RSAiAvatarTag>? tags;
  bool? required;

  RSAiAvatarOptions({this.id, this.name, this.tags, this.required});

  RSAiAvatarOptions copyWith({
    int? id,
    String? name,
    List<RSAiAvatarTag>? tags,
    bool? required,
  }) => RSAiAvatarOptions(
    id: id ?? this.id,
    name: name ?? this.name,
    tags: tags ?? this.tags,
    required: required ?? this.required,
  );

  factory RSAiAvatarOptions.fromRawJson(String str) =>
      RSAiAvatarOptions.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RSAiAvatarOptions.fromJson(Map<String, dynamic> json) =>
      RSAiAvatarOptions(
        id: json["id"],
        name: json["name"],
        tags: json["tags"] == null
            ? []
            : List<RSAiAvatarTag>.from(
                json["tags"]!.map((x) => RSAiAvatarTag.fromJson(x)),
              ),
        required: json["required"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "tags": tags == null
        ? []
        : List<dynamic>.from(tags!.map((x) => x.toJson())),
    "required": required,
  };
}

class RSAiAvatarTag {
  String? id;
  String? label;
  String? value;
  bool isSelected; // 添加选中状态字段

  RSAiAvatarTag({
    this.id,
    this.label,
    this.value,
    this.isSelected = false, // 默认未选中
  });

  RSAiAvatarTag copyWith({
    String? id,
    String? label,
    String? value,
    bool? isSelected,
  }) => RSAiAvatarTag(
    id: id ?? this.id,
    label: label ?? this.label,
    value: value ?? this.value,
    isSelected: isSelected ?? this.isSelected,
  );

  factory RSAiAvatarTag.fromRawJson(String str) =>
      RSAiAvatarTag.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RSAiAvatarTag.fromJson(Map<String, dynamic> json) => RSAiAvatarTag(
    id: json["id"],
    label: json["label"],
    value: json["value"],
    isSelected: false, // API数据默认未选中
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "label": label,
    "value": value,
    // isSelected 不需要序列化到API，只用于本地状态管理
  };
}
