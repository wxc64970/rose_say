import 'dart:convert';

class RSImageHistroy {
  final int? id;
  final String? url;

  RSImageHistroy({this.id, this.url});

  factory RSImageHistroy.fromRawJson(String str) =>
      RSImageHistroy.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RSImageHistroy.fromJson(Map<String, dynamic> json) =>
      RSImageHistroy(id: json['oklstx'], url: json['jpdkbw']);

  Map<String, dynamic> toJson() => {'oklstx': id, 'jpdkbw': url};
}
