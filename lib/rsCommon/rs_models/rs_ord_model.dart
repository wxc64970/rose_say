import "dart:convert";

class RSOrderModel {
  final int? id;
  final String? orderNo;

  RSOrderModel({this.id, this.orderNo});

  factory RSOrderModel.fromRawJson(String str) =>
      RSOrderModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RSOrderModel.fromJson(Map<String, dynamic> json) =>
      RSOrderModel(id: json["oklstx"], orderNo: json["zobdms"]);

  Map<String, dynamic> toJson() => {"oklstx": id, "zobdms": orderNo};
}
