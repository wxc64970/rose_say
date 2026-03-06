import 'dart:convert';

class RSPagesModel<T> {
  List<T>? records;
  int? total;
  int? size;
  int? current;
  int? pages;

  RSPagesModel({this.records, this.total, this.size, this.current, this.pages});

  // 新增一个从 JSON 转换的工厂方法，需要传入泛型类型的转换函数
  factory RSPagesModel.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic json) fromJsonT,
  ) => RSPagesModel(
    records: json["wixwfx"] == null
        ? []
        : _parseRecords(json["wixwfx"]!, fromJsonT),
    total: json["jzfwsr"],
    size: json["wjvdhf"],
    current: json["twugej"],
    pages: json["qllmks"],
  );

  // 辅助方法：处理 records 可能是数组或 JSON 字符串的情况
  static List<T> _parseRecords<T>(
    dynamic recordsData,
    T Function(dynamic json) fromJsonT,
  ) {
    if (recordsData == null) {
      return [];
    }

    if (recordsData is String) {
      // 如果是 JSON 字符串，先解析
      final List<dynamic> decoded = json.decode(recordsData);
      return List<T>.from(decoded.map((x) => fromJsonT(x)));
    } else if (recordsData is List) {
      // 如果是数组，直接处理
      return List<T>.from(recordsData.map((x) => fromJsonT(x)));
    } else {
      return [];
    }
  }

  // 从原始 JSON 字符串转换，同样需要传入泛型类型的转换函数
  factory RSPagesModel.fromRawJson(
    String str,
    T Function(dynamic json) fromJsonT,
  ) => RSPagesModel.fromJson(json.decode(str), fromJsonT);

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
    "wixwfx": records == null
        ? []
        : List<dynamic>.from(records!.map((x) => _toJson(x))),
    "jzfwsr": total,
    "wjvdhf": size,
    "twugej": current,
    "qllmks": pages,
  };

  // 处理泛型对象的序列化
  dynamic _toJson(T value) {
    if (value is Map) {
      return value;
    } else if (value is List) {
      return value;
    } else if (value is num || value is bool || value is String) {
      return value;
    } else if (value is dynamic Function()) {
      return value();
    }
    // 如果是自定义对象，假设它有 toJson 方法
    return (value as dynamic).toJson();
  }
}
