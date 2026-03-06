import 'dart:convert';

class RSImgStyle {
  final String? name;
  final String? style;
  final String? icon;

  RSImgStyle({this.name, this.style, this.icon});

  factory RSImgStyle.fromRawJson(String str) =>
      RSImgStyle.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RSImgStyle.fromJson(Map<String, dynamic> json) =>
      RSImgStyle(name: json["name"], style: json["style"], icon: json["icon"]);

  Map<String, dynamic> toJson() => {"name": name, "style": style, "icon": icon};
}
