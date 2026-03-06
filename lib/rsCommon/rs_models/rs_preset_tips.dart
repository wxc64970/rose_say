class PresetTips {
  int? id;
  String? titleEn;
  String? titleCn;
  String? category;
  String? prompt;

  PresetTips({this.id, this.titleEn, this.titleCn, this.category, this.prompt});

  PresetTips.fromJson(Map<String, dynamic> json) {
    id = json['oklstx'];
    titleEn = json['title_en'];
    titleCn = json['title_cn'];
    category = json['category'];
    prompt = json['gcvopb'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title_en'] = titleEn;
    data['title_cn'] = titleCn;
    data['category'] = category;
    data['prompt'] = prompt;
    return data;
  }
}
