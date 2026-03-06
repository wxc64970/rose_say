import 'dart:convert';

class RSImageHistroy {
  final int? id;
  final String? url;

  RSImageHistroy({this.id, this.url});

  factory RSImageHistroy.fromRawJson(String str) =>
      RSImageHistroy.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RSImageHistroy.fromJson(Map<String, dynamic> json) =>
      RSImageHistroy(id: json['id'], url: json['url']);

  Map<String, dynamic> toJson() => {'id': id, 'url': url};
}
