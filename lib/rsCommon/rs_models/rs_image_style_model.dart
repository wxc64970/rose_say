class RSImageStyle {
  int? id;
  String? name;
  String? remark;
  String? cover;
  int? styleType;
  String? modelName;
  String? loraModel;
  double? loraStrength;
  String? loraPath;
  int? orderNum;
  String? platform;
  String? createTime;
  String? updateTime;
  bool? del;

  RSImageStyle({
    this.id,
    this.name,
    this.remark,
    this.cover,
    this.styleType,
    this.modelName,
    this.loraModel,
    this.loraStrength,
    this.loraPath,
    this.orderNum,
    this.platform,
    this.createTime,
    this.updateTime,
    this.del,
  });

  RSImageStyle.fromJson(Map<String, dynamic> json) {
    id = json['oklstx'];
    name = json['seqgrz'];
    remark = json['remark'];
    cover = json['cover'];
    styleType = json['jvneyj'];
    modelName = json['model_name'];
    loraModel = json['yvrtja'];
    loraStrength = json['lpccff'];
    loraPath = json['lbgjox'];
    orderNum = json['pwzhvy'];
    platform = json['bfibax'];
    createTime = json['zdcetu'];
    updateTime = json['biaazj'];
    del = json['del'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['remark'] = remark;
    data['cover'] = cover;
    data['style_type'] = styleType;
    data['model_name'] = modelName;
    data['lora_model'] = loraModel;
    data['lora_strength'] = loraStrength;
    data['lora_path'] = loraPath;
    data['order_num'] = orderNum;
    data['platform'] = platform;
    data['create_time'] = createTime;
    data['update_time'] = updateTime;
    data['del'] = del;
    return data;
  }
}
