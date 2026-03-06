import 'package:rose_say/rsCommon/index.dart';

enum SAEnv { dev, prod }

class RSAppConstants {
  // API相关常量
  // 应用名称
  static const appName = 'Rose Say';
  static const String baseUrl = 'https://server.zyycfysavbpgfefb.com';
  // static const String baseUrl = 'https://liuhaipeng3.powerfulclean.net'; //
  static const bool isDebug = true;
  static const String apiVersion = 'v1';
  static const String apiPrefix = 'zyycfysavbpgfefb';
  static const String bundleIdIOS = '';
  static const String bundleIdAndroid = '';
  static const String platformIos = 'rose';
  static const String platformAndroid = 'rose-android';
  static const String adjustId = '9p2ougjvcc1s';
  static const String privacypolicyUrl = 'https://rosesayapp.com/privacy/';
  static const String termsUrl = 'https://rosesayapp.com/terms/';
  static const String email = 'rosesay1@proton.me';
  static const String appId = '6760009267';

  // 本地存储键名
  static const String keyUserInfo = 'S7pR2t';
  static const String keyThemeMode = 'k9Df5G';
  static const String keyLanguage = 'P3sV8n';

  // 安全存储键名（FlutterSecureStorage）
  /// 设备ID
  static const String keyDeviceId = 'g2Bm7Q';

  // SharedPreferences 键名
  /// CLK状态
  static const String keyClkStatus = 'Z5xK1d';

  /// 应用重启标识
  static const String keyAppRestart = 'm4Rf9L';

  /// 聊天背景图片路径
  static const String keyChatBgPath = 'H6jW3s';

  /// 用户信息（JSON）
  static const String keyUserData = 'q1Gz8C';

  /// 发送消息计数
  static const String keySendMsgCount = 'F2nT7v';

  /// 评分计数
  static const String keyRateCount = 'b5Kp2M';

  /// 语言设置
  static const String keyLocale = 'J8dS4h';

  /// 翻译对话框显示标识
  static const String keyTranslationDialog = 'r3Xg6N';

  /// 安装时间戳
  static const String keyInstallTime = 'D7wQ9f';

  /// 上次奖励日期
  static const String keyLastRewardDate = 'y2Gj5B';

  /// 首次点击聊天输入框标识
  static const String keyFirstClickInput = 'V4kR7c';

  /// 翻译消息ID列表
  static const String keyTranslationMsgIds = 'h1Mz9P';

  /// app言列表
  static const String appLangs = 'K6bS2x';

  // 分页相关
  static const int defaultPageSize = 10;

  //好评弹窗
  static const String goodRateShowTime = 's8Fg3D';

  //好评弹窗1
  static const String goodRateShowTime1 = 'C5nJ7z';

  //好评弹窗2
  static const String goodRateShowTime2 = 'p2Ld4W';
}

enum VipFrom {
  locktext,
  lockpic,
  lockvideo,
  lockaudio,
  send,
  homevip,
  mevip,
  chatvip,
  launch,
  relaunch,
  viprole,
  call,
  acceptcall,
  creimg,
  crevideo,
  undrphoto,
  postpic,
  postvideo,
  undrchar,
  videochat,
  trans,
  dailyrd,
  scenario,
  aiImagespeed,
  downloadimage,
  creations,
  aiChar,
}

enum ConsumeFrom {
  home,
  chat,
  send,
  profile,
  text,
  audio,
  call,
  unlcokText,
  undr,
  creaimg,
  creavideo,
  album,
  aiphoto,
  img2v,
  mask,
  generateimage,
  imageAIwrite,
}

enum RewardType { dislike, accept, like, unknown }

String getRewardTypeDesc(RewardType type) {
  switch (type) {
    case RewardType.dislike:
      return RSTextData.dislike;
    case RewardType.accept:
      return RSTextData.accept;
    case RewardType.like:
      return RSTextData.love;
    case RewardType.unknown:
      return '';
  }
}

extension GlobFromExt on ConsumeFrom {
  int get gems {
    switch (this) {
      case ConsumeFrom.text:
        return RS.login.configPrice?.textMessage ?? 2;

      case ConsumeFrom.call:
        return RS.login.configPrice?.callAiCharacters ?? 10;
      default:
        return 0;
    }
  }
}

enum MsgLockLevel {
  normal,
  private;

  String get value => name.toUpperCase();
}

enum CallState { calling, incoming, listening, answering, answered, micOff }

enum Gender {
  male(0),
  female(1),
  nonBinary(2),
  unknown(-1);

  final int code;
  const Gender(this.code);

  // 添加字符串映射 MALE,FEMALE,GENDER_FLUID,UNKNOWN
  static const Map<Gender, String> _stringMap = {
    Gender.male: 'MALE',
    Gender.female: 'FEMALE',
    Gender.nonBinary: 'GENDER_FLUID',
    Gender.unknown: 'UNKNOWN',
  };

  static final Map<int, Gender> _codeMap = {
    for (var g in Gender.values) g.code: g,
  };

  /// 根据数值反查 Gender
  static Gender fromValue(int? code) => _codeMap[code] ?? Gender.unknown;

  /// 获取字符串映射值
  String get stringValue => _stringMap[this] ?? 'UNKNOWN';

  String get display {
    switch (this) {
      case Gender.male:
        return RSTextData.male;
      case Gender.female:
        return RSTextData.female;
      case Gender.nonBinary:
        return RSTextData.nonBinary;
      case Gender.unknown:
        return 'unknown';
    }
  }

  String get icon {
    switch (this) {
      case Gender.male:
        return 'assets/images/rs_36.png';
      case Gender.female:
        return 'assets/images/rs_37.png';
      case Gender.nonBinary:
        return 'assets/images/rs_38.png';
      case Gender.unknown:
        return 'assets/images/rs_38.png';
    }
  }
}
