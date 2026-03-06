import 'dart:convert';

class RSLang {
  String? label;
  String? value;

  RSLang({this.label, this.value});

  RSLang copyWith({String? label, String? value}) =>
      RSLang(label: label ?? this.label, value: value ?? this.value);

  factory RSLang.fromRawJson(String str) => RSLang.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RSLang.fromJson(Map<String, dynamic> json) =>
      RSLang(label: json["label"], value: json["value"]);

  Map<String, dynamic> toJson() => {"label": label, "value": value};
}
