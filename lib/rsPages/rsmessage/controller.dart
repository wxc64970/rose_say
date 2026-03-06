import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rose_say/rsCommon/index.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import 'index.dart';

class RsmessageController extends GetxController {
  RsmessageController();

  final state = RsmessageState();

  late AutoScrollController autoController;
  String get languageCode => RS.login.sessionLang.value?.value ?? 'en';

  /// 在 widget 内存中分配后立即调用。
  @override
  void onInit() {
    super.onInit();
    // 获取传递的参数
    var arguments = Get.arguments;
    if (arguments != null) {
      state.role = arguments['role'];
      state.session = arguments['session'];
    }
    setupTease();

    loadMsg();

    loadChatLevel();

    autoController = AutoScrollController(
      viewportBoundaryGetter: () =>
          Rect.fromLTRB(0, 0, 0, Get.mediaQuery.padding.bottom),
      axis: Axis.vertical,
    );

    RS.login.loadPriceConfig();
    RS.login.fetchUserInfo();
  }

  void setupTease() {
    state.inputTags.clear();
    if (RS.storage.isRSB) {
      state.inputTags.add({
        'id': 0,
        'name': RSTextData.tease,
        'icon': 'assets/images/rs_12.png',
        'color': 0xFFFFFFFFF,
        "list": RSTextData.inputTagsTest,
      });
    }
    state.inputTags.add({
      'id': 3,
      'name': RSTextData.mask,
      'icon': 'assets/images/rs_11.png',
      'color': 0xFFFFFFFFF,
      'list': [],
    });
    if (RS.storage.isRSB) {
      final count = RS.storage.sendMsgCount;
      final showClothingCount = RSThirdPartyService.showClothingCount;
      if (count >= showClothingCount) {
        state.inputTags.add({
          'id': 1,
          'name': RSTextData.undress,
          'icon': 'assets/images/rs_13.png',
          'color': 0xFFFFFFFFF,
          'list': [],
        });
      }
    }
    update();
  }

  Future loadMsg() async {
    if (state.sessionId == null) {
      return;
    }
    state.list.clear();
    _addDefaaultTips();
    final records = await Api.messageList(1, 10000, state.sessionId!) ?? [];

    // 获取已翻译消息 id
    final Set<String> ids = RS.storage.translationMsgIds;
    // 遍历消息列表，赋值 showTranslate
    for (var msg in records) {
      if (msg.id != null && ids.contains(msg.id)) {
        msg.showTranslate = true;
      }
      if (RS.login.currentUser?.autoTranslate == true &&
          msg.translateAnswer != null) {
        msg.showTranslate = true;
      }
    }

    state.list.addAll(records);

    print(state.list.length);
    update();
  }

  void _addDefaaultTips() {
    final tips = RSMessageModel();
    tips.source = MessageSource.tips;
    tips.answer = RSTextData.answer;
    state.list.add(tips);

    var scenario = state.session.scene ?? state.role.scenario;

    if (scenario != null && scenario.isNotEmpty) {
      final intro = RSMessageModel();
      intro.source = MessageSource.scenario;
      intro.answer = scenario;
      state.list.add(intro);
    } else {
      if (state.role.aboutMe != null && state.role.aboutMe!.isNotEmpty) {
        final intro = RSMessageModel();
        intro.source = MessageSource.intro;
        intro.answer = state.role.aboutMe;
        state.list.add(intro);
      }
    }
    _addRandomGreetings();
  }

  Future<void> _addRandomGreetings() async {
    final greetings = state.role.greetings;
    if (greetings == null || greetings.isEmpty) {
      return;
    }
    int randomIndex = Random().nextInt(greetings.length);
    var str = greetings[randomIndex];

    final msg = RSMessageModel();
    msg.id = '${DateTime.now().millisecondsSinceEpoch}';
    msg.answer = str;
    // msg.voiceUrl = voiceUrl;
    // msg.voiceDur = voiceDur;
    msg.source = MessageSource.welcome;
    state.list.add(msg);
  }

  Future<void> loadChatLevel() async {
    if (state.chatLevelConfigs.isNotEmpty) {
      return;
    }
    try {
      final configs = await Api.getChatLevelConfig() ?? [];
      state.chatLevelConfigs = configs.isEmpty
          ? state.chatLevelList
          : configs.map((c) {
              return {
                'icon': c.title ?? '👋',
                'level': c.level ?? 1,
                'text': 'Level ${c.level} Reward',
                'gems': c.reward ?? 0,
              };
            }).toList();

      final roleId = state.role.id;
      final userId = RS.login.currentUser?.id;
      if (roleId == null || userId == null) {
        return;
      }
      var res = await Api.fetchChatLevel(charId: roleId, userId: userId);
      state.chatLevel.value = res;
    } catch (e) {
      debugPrint('[MessageController] : $e');
    }
  }

  /// 续写
  Future<void> continueWriting() async {
    final msg = state.list.last;
    bool canSend = await canSendMsg(msg.answer ?? '');
    if (!canSend) {
      return;
    }
    await sendMsgRequest(path: RSApiUrl.continueWrite, isLoading: true);
  }

  Future<bool> canSendMsg(String text) async {
    if (state.isRecieving) {
      RSToast.show(RSTextData.waitForResponse);
      return false;
    }

    RSMessageModel lastMsg = state.list.last;
    if (lastMsg.typewriterAnimated) {
      RSToast.show(RSTextData.waitForResponse);
      return false;
    }

    if (text.isEmpty) {
      RSToast.show(RSTextData.pleaseInput);
      return false;
    }
    final roleId = state.role.id;
    if (roleId == null) {
      return false;
    }
    if (!RS.login.vipStatus.value) {
      if (state.role.gems == true) {
        final flag = RS.login.checkBalance(ConsumeFrom.text);
        if (!flag) {
          rechage();
          return false;
        }
      } else {
        /// 免费角色 - 最大免费条数
        int maxCount = RSThirdPartyService.maxFreeChatCount;

        final sencCount = RS.storage.sendMsgCount;

        if (sencCount > maxCount) {
          DialogWidget.alert(
            message: RSTextData.freeChatUsed,
            confirmText: RSTextData.upgradeTochat,
            onConfirm: () {
              RSlogEvent('t_chat_send');
              Get.toNamed(RSRouteNames.vip, arguments: VipFrom.send);
            },
          );
          return false;
        }
      }
    }
    return true;
  }

  Future<void> sendMsgRequest({
    required String path,
    String? text,
    bool? isLoading,
    String? msgId,
  }) async {
    try {
      final charId = state.role.id;
      final conversationId = state.sessionId ?? 0;
      final uid = RS.login.currentUser?.id;
      if (charId == null || uid == null || conversationId == 0) {
        RSToast.show(RSTextData.someErrorTryAgain);
        return;
      }

      var body = {
        'character_id': charId,
        'conversation_id': conversationId,
        'user_id': uid,
        'auto_translate': true,
        'target_language': languageCode,
      };
      if (text != null) {
        body['message'] = text;
      }
      if (msgId != null) {
        body['msg_id'] = msgId;
      }

      state.isRecieving = true;
      if (isLoading == true) {
        RSLoading.show();
      }
      final res = await Api.sendMsg(path: path, body: body);
      RSLoading.close();

      final msg = res?.data;
      if (res?.code == 20003) {
        rechage();
        return;
      }
      if (msg != null) {
        await progressReceived(msg);
      } else {
        progressSSEError();
      }
    } catch (e) {
      progressSSEError();
    } finally {
      RSLoading.close();
      state.isRecieving = false;
    }
  }

  void progressSSEError() {
    state.tmpSendMsg?.onAnswer = false;

    RSMessageModel msg = RSMessageModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      answer: RSTextData.someErrorTryAgain,
    );
    msg.source = MessageSource.error;
    msg.answer = RSTextData.someErrorTryAgain;
    state.list.add(msg);
  }

  Future<void> progressReceived(RSMessageModel msg) async {
    if (msg.conversationId != state.sessionId) {
      return;
    }
    if (msg.textLock == MsgLockLevel.private.value) {
      msg.typewriterAnimated = RS.login.vipStatus.value;
    } else {
      msg.typewriterAnimated = true;
    }

    // 删除最后一条tmpSendMsg
    if (state.list.isNotEmpty &&
        state.list.last.id == state.tmpSendId &&
        msg.question == state.list.last.question) {
      state.list.removeLast();
    }

    final index = state.list.indexOf(msg);
    if (index != -1) {
      state.list[index] = msg;
    } else {
      state.list.add(msg);
    }
    _checkChatLevel(msg);

    await RS.login.fetchUserInfo();

    state.tmpSendMsg = null;
  }

  void _checkChatLevel(RSMessageModel msg) async {
    bool upgrade = msg.upgrade ?? false;
    int rewards = msg.rewards ?? 0;
    var level = msg.appUserChatLevel;
    state.chatLevel.value = level;
    if (upgrade) {
      // 升级了
      await _showChatLevelUp(rewards);

      if ((level?.level ?? 0) == 2) {
        if (!RS.storage.isShowGoodCommentDialog2) {
          DialogWidget.showPositiveReview();
          RS.storage.setShowGoodCommentDialog2(true);
        }
        // if (DialogWidget.rateLevel3Shoed == false) {
        //   DialogWidget.showRateUs(RSTextData.rateUsMsg);
        //   DialogWidget.rateLevel3Shoed = true;
        // }
      }
    } else {
      checkSendCount();
    }
  }

  Future _showChatLevelUp(int rewards) async {
    await DialogWidget.showChatLevelUp(rewards);

    checkSendCount();
  }

  void checkSendCount() async {
    // 发送成功后，更新发送次数

    await RS.storage.setSendMsgCount(RS.storage.sendMsgCount + 1);
    setupTease();
    if (RS.storage.isRSB) {
      var count = RS.storage.sendMsgCount;
      if (count == RSThirdPartyService.showClothingCount) {
        DialogWidget.showUndrDialog(
          message: RSTextData.undrMessage,
          confirmText: RSTextData.tryNow,
          clickMaskDismiss: false,
          onConfirm: () {
            DialogWidget.dismiss();
            Get.toNamed(RSRouteNames.undr, arguments: state.role);
          },
          onCancel: () {
            DialogWidget.dismiss();
          },
        );
      } else {
        checkRateMsgCount();
      }
    } else {
      checkRateMsgCount();
    }
  }

  void checkRateMsgCount() async {
    RS.storage.setRateCount(RS.storage.rateCount + 1);
    final roleId = state.role.id;
    var map = RS.storage.messageCountMap;

    if (!RS.storage.isShowGoodCommentDialog1 && roleId != null) {
      final sendCount = map[roleId] ?? 0;

      if ((sendCount + 1) == 2) {
        DialogWidget.showPositiveReview();
        RS.storage.setShowGoodCommentDialog1(true);
      } else {
        map[roleId] = sendCount + 1;
        RS.storage.messageCountMap = map;
      }
    }
  }

  Future<void> rechage() async {
    await RSToast.show(RSTextData.notEnough);
    // v1.3.0 - 调整为跳订阅页
    Get.toNamed(RSRouteNames.vip, arguments: VipFrom.send);
  }

  Future<void> onTapUnlockImage(RoleImage image) async {
    final gems = image.gems ?? 0;
    if (RS.login.gemBalance.value < gems) {
      Get.toNamed(RSRouteNames.gems, arguments: ConsumeFrom.album);
      return;
    }

    final imageId = image.id;
    final modelId = image.modelId;
    if (imageId == null || modelId == null) {
      return;
    }

    RSLoading.show();
    final res = await Api.unlockImageReq(imageId, modelId);
    RSLoading.close();
    if (res) {
      // 创建一个新的 images 列表
      final updatedImages = state.role.images?.map((i) {
        if (i.id == imageId) {
          return i.copyWith(unlocked: true);
        }
        return i;
      }).toList();

      // 更新 Role 对象
      state.role = state.role.copyWith(images: updatedImages);
      state.roleImagesChaned.value++;
      RS.login.fetchUserInfo();

      onTapImage(image);
    } else {
      RSToast.show(RSTextData.someErrorTryAgain);
    }
  }

  void onTapImage(RoleImage image) {
    final imageUrl = image.imageUrl;
    if (imageUrl == null) {
      return;
    }
    Get.toNamed(RSRouteNames.imagePreview, arguments: imageUrl);
  }

  void translateMsg(RSMessageModel msg) async {
    RSMessageModel lastMsg = state.list.last;
    if (lastMsg.typewriterAnimated) {
      RSToast.show(RSTextData.waitForResponse);
      return;
    }

    final content = msg.answer;
    final id = msg.id;

    // 内容为空直接返回
    if (content == null || content.isEmpty) return;

    // 定义更新消息的方法
    Future<void> updateMessage({
      required bool showTranslate,
      String? translate,
    }) async {
      msg.showTranslate = showTranslate;

      if (id != null) {
        _transCache(isAdd: showTranslate, id: id);
      }

      if (translate != null) {
        msg.translateAnswer = translate;

        if (id != null) {
          Api.saveMsgTrans(id: id, text: translate);
        }
      }
      state.list.refresh();
    }

    // 根据状态处理逻辑
    if (msg.showTranslate == true) {
      await updateMessage(showTranslate: false);
    } else if (msg.translateAnswer != null) {
      await updateMessage(showTranslate: true);
      RSMessageTransUtils().handleTranslationClick();
    } else {
      RSlogEvent('c_trans');
      if (msg.translateAnswer == null) {
        // 获取翻译内容
        RSLoading.show();
        String? result = await Api.translateText(content);
        RSLoading.close();
        // 更新消息并显示翻译
        await updateMessage(showTranslate: true, translate: result);
      } else {
        await updateMessage(showTranslate: true);
      }

      RSMessageTransUtils().handleTranslationClick();
    }
  }

  void _transCache({required bool isAdd, required String id}) {
    final Set<String> ids = RS.storage.translationMsgIds;
    if (isAdd) {
      ids.add(id); // 重复添加会自动忽略
    } else {
      ids.remove(id);
    }
    RS.storage.setTranslationMsgIds(ids);
  }

  RSMessageModel? findLastServerMsg() {
    // 从后向前遍历消息列表
    for (int i = state.list.length - 1; i >= 0; i--) {
      final msg = state.list[i];

      // 如果是错误消息，删除它
      if (msg.source == MessageSource.error) {
        state.list.removeAt(i);
        continue;
      }

      // 检查是否为服务器消息类型
      final source = msg.source;
      if (source == MessageSource.text ||
          source == MessageSource.video ||
          source == MessageSource.audio ||
          source == MessageSource.photo ||
          source == MessageSource.gift ||
          source == MessageSource.clothe) {
        return msg; // 找到服务器消息，返回并停止遍历
      }
    }
    return null;
  }

  /// 重新发送消息
  Future<void> resendMsg(RSMessageModel msg) async {
    RSMessageModel? last = msg;
    if (msg.source == MessageSource.error) {
      last = findLastServerMsg();
    }
    if (last == null) {
      continueWriting();
      return;
    }

    bool canSend = await canSendMsg(last.answer ?? '');
    if (!canSend) {
      return;
    }

    final id = msg.id;
    if (id == null) {
      RSToast.show(RSTextData.someErrorTryAgain);
      return;
    }

    await sendMsgRequest(path: RSApiUrl.resendMsg, isLoading: true, msgId: id);
  }

  /// 编辑消息
  Future<void> editMsg(String content, RSMessageModel msg) async {
    bool canSend = await canSendMsg(msg.answer ?? '');
    if (!canSend) {
      return;
    }
    RSLoading.show();
    state.isRecieving = true;
    final id = msg.id;
    if (id == null) {
      RSToast.show(RSTextData.someErrorTryAgain);
      return;
    }
    var data = await Api.editMsg(id: id, text: content);
    if (data != null) {
      // 查找上一个 sendtext 消息  如果存在question一样的，将它删除
      RSMessageModel? pre = state.list.firstWhereOrNull(
        (element) => element.question == data.question,
      );
      state.list.remove(pre);
      // 替换就消息
      state.list.removeWhere((element) => element.id == id);
      state.list.add(data);
      RS.login.fetchUserInfo();
    }
    state.isRecieving = false;
    RSLoading.close();
  }

  /// 修改聊天场景
  Future<void> editScene(String scene) async {
    void request() async {
      final charId = state.role.id;
      final conversationId = state.sessionId ?? 0;
      if (charId == null || conversationId == 0) {
        RSToast.show(RSTextData.someErrorTryAgain);
        return;
      }

      bool res = await Api.editScene(
        convId: conversationId,
        scene: scene,
        roleId: charId,
      );
      if (res) {
        state.session.scene = scene;
        state.list.clear();
        _addDefaaultTips();
      }
      RSLoading.close();
    }

    DialogWidget.alert(
      message: RSTextData.scenarioRestartWarning,
      cancelText: RSTextData.cancel,
      confirmText: RSTextData.confirm,
      onConfirm: () {
        DialogWidget.dismiss();
        request();
      },
    );
  }

  /// 修改会话模式 聊天模型 short / long
  Future<void> editChatMode(bool isLong) async {
    final conversationId = state.sessionId ?? 0;
    if (conversationId == 0) {
      RSToast.show(RSTextData.someErrorTryAgain);
      return;
    }

    var mode = isLong ? 'long' : 'short';
    if (state.session.chatModel == mode) {
      if (Get.isBottomSheetOpen == true) Get.back();
      return;
    }
    RSLoading.show();
    bool res = await Api.editChatMode(convId: conversationId, mode: mode);
    if (res) {
      state.session.chatModel = mode;
      if (Get.isBottomSheetOpen == true) Get.back();
    }
    RSLoading.close();
  }

  /// 切换 mask
  Future<bool> changeMask(int maskId) async {
    RSLoading.show();
    final conversationId = state.session.id;
    final res = await Api.changeMask(
      conversationId: conversationId,
      maskId: maskId,
    );
    RSLoading.close();
    if (res) {
      state.session.profileId = maskId;
      state.list.clear();
      _addDefaaultTips();
      _addMaskTips();
    }
    return res;
  }

  void _addMaskTips() {
    final msg = RSMessageModel();
    msg.source = MessageSource.maskTips;
    msg.answer = RSTextData.maskApplied;
    state.list.add(msg);
  }

  void cleanFormMask() {
    state.list.clear();
    _addDefaaultTips();
    _addMaskTips();
  }

  Future<void> sendMsg(String text) async {
    bool canSend = await canSendMsg(text);
    if (!canSend) {
      return;
    }

    addTemSendMsg(text);

    await sendMsgRequest(path: RSApiUrl.sendMsg, text: text);
  }

  Future<bool> resetConv() async {
    RSLoading.show();
    var result = await Api.resetSession(state.sessionId ?? 0);
    RSLoading.close();
    if (result != null) {
      state.session = result;
      state.list.clear();
      _addDefaaultTips();
      return true;
    }
    return false;
  }

  Future<bool> deleteConv() async {
    RSLoading.show();
    var result = await Api.deleteSession(state.sessionId ?? 0);

    // if (result && Get.isRegistered<ConversationController>()) {
    //   Get.find<ConversationController>().dataList.removeWhere((r) => r.id == state.sessionId);
    //   Get.find<ConversationController>().dataList.refresh();
    // }

    RSLoading.close();
    return result;
  }

  void addTemSendMsg(String text) {
    final charId = state.role.id;
    final conversationId = state.sessionId ?? 0;
    final uid = RS.login.currentUser?.id;
    if (charId == null || uid == null) {
      RSToast.show('charId or uid is null');
      return;
    }

    // 临时发送显示的消息
    final msg = RSMessageModel(
      id: state.tmpSendId,
      question: text,
      userId: RS.login.currentUser?.id,
      conversationId: conversationId,
      characterId: charId,
      onAnswer: true,
    );
    msg.source = MessageSource.sendText;
    state.list.add(msg);
    state.tmpSendMsg = msg;
  }

  String formatNumber(double? value) {
    if (value == null) {
      return '0';
    }
    if (value % 1 == 0) {
      // 如果小数部分为 0，返回整数
      return value.toInt().toString();
    } else {
      // 如果有小数部分，返回原值
      return value.toString();
    }
  }

  /// 在 onInit() 之后调用 1 帧。这是进入的理想场所
  @override
  void onReady() {
    super.onReady();
  }

  /// 在 [onDelete] 方法之前调用。
  @override
  void onClose() {
    super.onClose();
  }

  /// dispose 释放内存
  @override
  void dispose() {
    autoController.dispose();
    super.dispose();
  }
}
