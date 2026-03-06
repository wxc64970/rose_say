import 'dart:io';

// 在终端中直接运行 main 方法：
/*
dart run /Users/wangchao/Documents/work/rose_say/test/tet.dart
*/
/// 入口方法
void main() {
  // 指定文件夹路径（你的开发机上的绝对路径）
  const String folderPath =
      '/Users/wangchao/Documents/work/rose_say/lib/rsCommon/rs_models';
  // 调用替换方法
  replaceJsonModel(folderPath);

  // 替换 api path 中的字符串
  const String filePath =
      '/Users/wangchao/Documents/work/rose_say/lib/rsCommon/rs_api/rs_api_url.dart';
  replaceApiPath(filePath);
}

/// 替换 api path 路径
void replaceApiPath(String filePath) {
  print('开始处理文件: $filePath');
  // 替换规则
  final Map<String, String> replacementMap = {
    "aipgtv": "insert",
    "amnqfh": "claim",
    "aobfob": "daily-quests",
    "aozwpu": "getGenerateImageResult",
    "aswaiu": "translate",
    "beysan": "saveMessage",
    "blwcsc": "chatLevelConf",
    "blwfww": "getUndressWithResult",
    "byfxlv": "subscription",
    "cbyimx": "getUndressWithVideoResult",
    "cnncgm": "getGenImg",
    "cxdbhy": "user",
    "dapsax": "consumption",
    "djwnbi": "history",
    "doppit": "undress",
    "dpravy": "chatSwitch",
    "dzalrr": "create",
    "eblngj": "roleplay",
    "ejvaco": "info",
    "emekkz": "progress",
    "epvxli": "getRecommendRole",
    "etxnjx": "switch",
    "ewjeha": "noDress",
    "eygyol": "undressOutcome",
    "ezaqwl": "save",
    "fqupgx": "lang",
    "fwpeye": "platformConfig",
    "gdapuq": "getClothingConf",
    "gjrojg": "isNaked",
    "gohgud": "getChatLevel",
    "hdemdd": "undressResult",
    "hfchox": "aiWrite",
    "icigta": "noDressHis",
    "iclrrm": "getUndressWithVideo",
    "igpeel": "getStyleConfig",
    "jfmfaj": "assets",
    "jogbja": "unlock",
    "kfjscd": "giveVip",
    "kpeoli": "config",
    "ktaitb": "deleteMessage",
    "lducfq": "getByRole",
    "lirklm": "getGenerateImagePrice",
    "lrjfxo": "setChatBackground",
    "nemtmr": "characters",
    "nfbbvr": "completed",
    "ngvqkj": "gift",
    "nqiuki": "gems",
    "nrrvei": "appUser",
    "odwmxu": "randomOne",
    "okrsmj": "system",
    "orulgs": "api",
    "pextau": "verify",
    "pfxnjo": "getUndressResult",
    "qjkxet": "clothes",
    "rukysl": "price",
    "rxndxt": "appUserReport",
    "sfmvev": "upinfo",
    "simbzd": "replySuggestions",
    "skeygh": "selectGenImg",
    "svwzqo": "rechargeOrders",
    "tbfqji": "conversation",
    "tciknj": "emotionRetain",
    "vexpdf": "editMsg",
    "vszpwh": "aiChatConversation",
    "wzbbtj": "getGiftConf",
    "xgdnbe": "voices",
    "xlhget": "userProfile",
    "xlsmut": "onboarding",
    "xnorxe": "saveFirebaseToken",
    "xsghjz": "google",
    "yjxxua": "pay",
    "yllzho": "register",
    "ymlmgl": "creationMoreDetails",
    "ytdxli": "creationStyleOptions",
    "ytytys": "characterProfile",
    "yvcjnj": "generateImage",
    "ywsame": "creationCharacter",
    "zdyyny": "randomName",
    "zlyxdl": "characterMedia",
    "zmiggy": "subscriptionTransactions",
    "zndwot": "getUndressWith",
    "znlcgs": "unlockDynamicVideo",
    "zwbokz": "message",
    "zydxxg": "getAll",
    "zzdgxd": "safety-level",
  };

  // 判断文件是否存在
  final File file = File(filePath);
  if (!file.existsSync()) {
    print('文件不存在: $filePath');
    return;
  }
  print('文件存在，开始读取内容');

  String fileContent = file.readAsStringSync();
  String replacedContent = fileContent;

  // 遍历替换：只替换等号后单引号内的路径内容
  for (final entry in replacementMap.entries) {
    final String newPathSegment = entry.value; // 原路径中的片段（如register）
    final String oldPathSegment = entry.key; // 要替换成的片段（如auiasv）
    print('替换 $oldPathSegment 为 $newPathSegment');

    // 正则匹配规则：
    // 匹配 = 后面的单引号内容中包含 oldPathSegment 的部分
    // 只替换单引号内的目标片段，保留其他内容和变量名
    replacedContent = replacedContent.replaceAllMapped(
      RegExp(
        r'=.*?\'
                "'(.*?" +
            oldPathSegment +
            ".*?)'",
      ),
      (match) {
        // 按路径段替换，只替换被 / 包围的完整路径段
        String matchedContent = match.group(1)!;
        String replacedString = matchedContent.replaceAll(
          RegExp(r'(?<=^|/)' + RegExp.escape(oldPathSegment) + r'(?=/|$)'),
          newPathSegment,
        );
        return "= '$replacedString'";
      },
    );
  }

  file.writeAsStringSync(replacedContent);
  print('文件已成功替换: $filePath');
}

/// 替换 model
void replaceJsonModel(String folderPath) {
  // 替换规则
  final Map<String, String> replacementMap = {
    "abhfdl": "is_completed",
    "aoqvaq": "trigger_genimg",
    "aulnpk": "safety_level",
    "awlqoj": "lock_level_media",
    "bcuknq": "visual",
    "bemcgy": "gender",
    "bfibax": "platform",
    "biaazj": "update_time",
    "bmbdwz": "visibility",
    "bmpzmz": "photo_message",
    "bnbclj": "adid",
    "bouthu": "media",
    "btxred": "task_id",
    "bxighm": "reward",
    "caefxu": "undress_count",
    "cainqt": "current_value",
    "cjudpx": "prompt_name",
    "cmewtz": "order_type",
    "ctelts": "time_need",
    "ctzxdo": "gname",
    "cynwpk": "device_id",
    "dahapu": "free_overrun",
    "ddqtcy": "visual_style",
    "deenhq": "source",
    "dgekau": "task_description",
    "dhbdlh": "model_id",
    "dnzjlf": "signature",
    "ecwuho": "free_message",
    "eeusex": "rewards",
    "egspjo": "upgrade",
    "egtcas": "vip",
    "ehlodl": "idfa",
    "eqqbid": "new_user",
    "essmpm": "character_name",
    "fbobwx": "image_path",
    "fcaxdd": "creation_id",
    "fipowb": "taskId",
    "fkoevy": "voice_duration",
    "fomrul": "likes",
    "fszuux": "change_clothing",
    "ftkokl": "dynamic_encry_time",
    "fuvtng": "conv_id",
    "gaaecg": "audit_time",
    "gabpcd": "translate_question",
    "gcvopb": "prompt",
    "gdhats": "key",
    "glxtwp": "question",
    "gzotqd": "text_message",
    "hcuahz": "character_video_chat",
    "hifcvd": "chat",
    "hkcghe": "call_ai_characters",
    "hlpnfc": "fileMd5",
    "hnifxe": "characterId",
    "hnjrmi": "subscription_end",
    "hnynij": "product_id",
    "hptzsl": "nickname",
    "hqgtza": "target_value",
    "hwhekt": "tags",
    "iddcfg": "uid",
    "iimbyk": "more_details",
    "ijvijm": "report_type",
    "iqkroz": "enable_auto_translate",
    "itdslh": "render_style",
    "ivvbrk": "last_message",
    "iwwaes": "card_num",
    "izfikp": "scene",
    "jfsrex": "subscription",
    "joxneb": "choose_env",
    "jpdkbw": "url",
    "jvneyj": "style_type",
    "jvymrj": "sign",
    "jzfwsr": "total",
    "kdbrbi": "style_path",
    "kesoyg": "currency_symbol",
    "kiatrc": "unlock_card_num",
    "kxxxhy": "reply_suggestions_enabled",
    "lbgjox": "lora_path",
    "linsfo": "transaction_id",
    "ljxljh": "deserved_gems",
    "lmdekf": "email",
    "lmehbg": "conversation_id",
    "lnotkh": "audit_status",
    "lpccff": "lora_strength",
    "lutbgw": "reward_gems",
    "mebimu": "scene_change",
    "mkfwlu": "gems",
    "mmgehj": "chat_image_price",
    "mntpzw": "describe_img",
    "molfai": "create_video",
    "mpltqj": "price",
    "mqnhcc": "nsfw",
    "mrafzm": "chat_model",
    "mtzbah": "hide_character",
    "mvxrzy": "recharge_status",
    "mxfsqp": "ctype",
    "mzyuei": "voice_url",
    "nhsipt": "age_max",
    "npbivl": "age_min",
    "obhynv": "greetings",
    "oklstx": "id",
    "okuixa": "chat_video_price",
    "oonagk": "cid",
    "otqcas": "next_msgs",
    "ouumon": "gen_img_id",
    "ovtlro": "avatar",
    "oxpdcm": "auto_translate",
    "pfvnhi": "pay",
    "pibyvt": "modify_time",
    "pjuush": "estimated_time",
    "pkpebi": "gen_photo_tags",
    "plfuka": "generate_video",
    "pnmfqr": "planned_msg_id",
    "ppvgce": "duration",
    "ptumks": "create_img",
    "puzvdk": "gen_video",
    "pwzhvy": "order_num",
    "qajaxe": "retain_text",
    "qllmks": "pages",
    "qrlsvr": "template_id",
    "qtefih": "media_text",
    "ragdkc": "style",
    "rcedpg": "nick_name",
    "rfgsaq": "approved_character_id",
    "rlfbqe": "session_count",
    "sejfee": "title",
    "seqgrz": "name",
    "skhehf": "user_id",
    "skzgin": "message",
    "szlirn": "engine",
    "szsyfo": "dynamic_encry_status",
    "tajrjb": "video_message",
    "teesdx": "about_me",
    "tenlfz": "level",
    "tncwkg": "source_language",
    "tptewe": "is_claimed",
    "tqwymz": "greetings_voice",
    "trgwfa": "password",
    "twugej": "current",
    "uflhrk": "task_name",
    "ugiuri": "amount",
    "ugniji": "character_id",
    "uiozru": "completed",
    "uixpmq": "shelving",
    "ujpjhv": "age",
    "ukjcoh": "token",
    "uzlohq": "thumbnail_url",
    "vbsrud": "currency_code",
    "vdwojj": "video_unlock",
    "vkrwnd": "lock_level",
    "vpsfvf": "receipt",
    "vqkdes": "generate_image",
    "vskpoc": "audio_message",
    "vsogaa": "answer",
    "vvejmf": "gen_photo",
    "waqbwk": "original_transaction_id",
    "wcvsjn": "style_id",
    "wixwfx": "records",
    "wjvdhf": "size",
    "wkocey": "video_chat",
    "wopsry": "character_images",
    "wpumya": "chat_audio_price",
    "xafmdl": "gtype",
    "xbszgn": "generated_images",
    "xfffiu": "profile_id",
    "xjpoob": "cname",
    "xnrwau": "translate_answer",
    "xpgkjv": "height",
    "xqohrb": "value",
    "xwijzw": "price",
    "xycodp": "msg_id",
    "xzzyte": "generated_status",
    "ygmsvt": "task_type",
    "ykodbo": "target_language",
    "yldrdc": "voice_id",
    "yqdnqv": "prompt_description",
    "yqssku": "activate",
    "ytqfkl": "profile_change",
    "yvrtja": "lora_model",
    "zafnvm": "app_user_chat_level",
    "zdcetu": "create_time",
    "zgofyn": "result_path",
    "zobdms": "order_no",
    "zokxcb": "source_message_id",
  };

  // 获取文件夹
  final Directory directory = Directory(folderPath);
  if (!directory.existsSync()) {
    print('文件夹不存在: $folderPath');
    return;
  }
  final List<FileSystemEntity> files = directory.listSync();

  for (final FileSystemEntity entity in files) {
    if (entity is File) {
      String fileContent = entity.readAsStringSync();

      // 使用简单的字符串替换来避免正则表达式格式化问题
      String replacedContent = fileContent;

      // 遍历所有需要替换的值
      for (final entry in replacementMap.entries) {
        final String oldKey = entry.value;
        final String newValue = entry.key;

        // 替换 JSON 对象中的键名: "key": value
        replacedContent = replacedContent.replaceAll(
          '"$newValue":',
          '"$oldKey":',
        );

        // 替换 JSON 访问: json['key'] 和 json["key"]
        replacedContent = replacedContent.replaceAll(
          "json['$newValue']",
          "json['$oldKey']",
        );
        replacedContent = replacedContent.replaceAll(
          'json["$newValue"]',
          'json["$oldKey"]',
        );

        // 替换 Map 字面量中的键名: 'key': value 和 "key": value
        replacedContent = replacedContent.replaceAll(
          "'$newValue':",
          "'$oldKey':",
        );
        replacedContent = replacedContent.replaceAll(
          '"$newValue":',
          '"$oldKey":',
        );
      }

      entity.writeAsStringSync(replacedContent);
      print('文件已成功替换: ${entity.path}');
    }
  }
}
