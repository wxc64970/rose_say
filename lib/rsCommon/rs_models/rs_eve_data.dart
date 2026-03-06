import 'dart:convert';

import 'package:hive/hive.dart';

part 'rs_eve.data.g.dart';

@HiveType(typeId: 0)
class RSEventData extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String eventType;

  @HiveField(2)
  final String data;

  @HiveField(3)
  final bool isSuccess;

  @HiveField(4)
  final int createTime;

  @HiveField(5)
  final int? uploadTime;

  @HiveField(6)
  final bool isUploaded;

  @HiveField(7)
  final int sequenceId;

  RSEventData({
    required this.id,
    required this.eventType,
    required this.data,
    this.isSuccess = false,
    required this.createTime,
    this.uploadTime,
    this.isUploaded = false,
    required this.sequenceId,
  });

  Map<String, dynamic> toMap() {
    return {
      'oklstx': id,
      'event_type': eventType,
      'data': data,
      'is_success': isSuccess ? 1 : 0,
      'zdcetu': createTime,
      'upload_time': uploadTime,
      'is_uploaded': isUploaded ? 1 : 0,
      'sequence_id': sequenceId,
    };
  }

  factory RSEventData.fromMap(Map<String, dynamic> map) {
    return RSEventData(
      id: map['id'],
      eventType: map['event_type'],
      data: map['data'],
      isSuccess: map['is_success'] == 1,
      createTime: map['create_time'],
      uploadTime: map['upload_time'],
      isUploaded: map['is_uploaded'] == 1,
      sequenceId: map['sequence_id'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory RSEventData.fromJson(String source) =>
      RSEventData.fromMap(json.decode(source));
}
