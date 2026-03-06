import "dart:convert";

class RSOrderModel {
  final int? id;
  final String? orderNo;

  RSOrderModel({this.id, this.orderNo});

  factory RSOrderModel.fromRawJson(String str) =>
      RSOrderModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RSOrderModel.fromJson(Map<String, dynamic> json) =>
      RSOrderModel(id: json["id"], orderNo: json["order_no"]);

  Map<String, dynamic> toJson() => {"id": id, "order_no": orderNo};
}
