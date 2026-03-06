import 'package:get/get.dart';
import 'package:rose_say/rsCommon/index.dart';

class RsmessageState {
  var list = <RSMessageModel>[].obs;

  RxList inputTags = [].obs;

  late ChaterModel role;
  late RSConversationModel session;
  int? get sessionId => session.id;

  bool isNewChat = false;

  // 相册变动
  var roleImagesChaned = 0.obs;

  // 聊天等级变动
  Rx<ChatAnserLevel?> chatLevel = Rx<ChatAnserLevel?>(null);

  List<Map<String, dynamic>> chatLevelConfigs = [];

  List<Map<String, dynamic>> chatLevelList = [
    {'icon': '👋', 'text': 'Level 1 Reward', 'level': 1, 'gems': 0},
    {'icon': '🥱', 'text': 'Level 2 Reward', 'level': 2, 'gems': 0},
    {'icon': '😊', 'text': 'Level 3 Reward', 'level': 3, 'gems': 0},
    {'icon': '💓', 'text': 'Level 4 Reward', 'level': 4, 'gems': 0},
  ];

  // 发送id
  var tmpSendId = '894896144';
  RSMessageModel? tmpSendMsg;

  bool isRecieving = false; // 正在接收消息
}
