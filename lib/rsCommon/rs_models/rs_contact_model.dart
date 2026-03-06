import 'package:flutter/material.dart';
import 'package:rose_say/rsCommon/index.dart';

class RSAzListContactModel {
  final String section;
  final List<String> names;
  final List<RSLang>? langs; // 添加 lang 属性来保存语言数据

  RSAzListContactModel({
    required this.section,
    required this.names,
    this.langs,
  });
}

class AzListCursorInfoModel {
  final String title;
  final Offset offset;

  AzListCursorInfoModel({required this.title, required this.offset});
}
