import 'dart:async';
import 'dart:io';
import 'package:encrypt/encrypt.dart';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:pointycastle/asymmetric/api.dart';
import 'package:rose_say/rsCommon/index.dart';

final api = RSDioClient.instance;

class Api {
  Api._();

  static Map<String, dynamic> get _qp => RS.storage.isRSB ? {'v': 'C001'} : {};

  static String? get userId => RS.login.currentUser?.id;

  static Future<String> getDeviceId() async {
    return await RS.storage.getDeviceId();
  }

  static Future<RSUsersModel?> register() async {
    try {
      final deviceId = await RS.storage.getDeviceId();
      var res = await api.request(
        RSApiUrl.register,
        method: HttpMethod.post,
        data: {
          "device_id": deviceId,
          "platform": Platform.isIOS
              ? RSAppConstants.platformIos
              : RSAppConstants.platformAndroid,
        },
      );
      if (!res.data) {
        return null;
      }
      final user = RSUsersModel.fromJson(res.data);
      return user;
    } catch (e) {
      return null;
    }
  }

  static Future<RSUsersModel?> getUserInfo() async {
    try {
      final deviceId = await RS.storage.getDeviceId();
      final res = await api.request(
        RSApiUrl.getUserInfo,
        method: HttpMethod.get,
        queryParameters: {'device_id': deviceId},
      );

      final user = RSUsersModel.fromJson(res.data);
      return user;
    } catch (e) {
      return null;
    }
  }

  static Future<bool> updateUserInfo(Map<String, dynamic> body) async {
    try {
      final res = await api.request(
        RSApiUrl.updateUserInfo,
        method: HttpMethod.post,
        data: body,
      );
      final reult = RSBaseModel.fromJson(res.data, null);
      return reult.data;
    } catch (e) {
      return false;
    }
  }

  static Future<List<RSTagsModel>?> roleTagsList() async {
    try {
      var res = await api.request(
        RSApiUrl.roleTag,
        method: HttpMethod.get,
        queryParameters: _qp,
      );
      if (res.data is List) {
        final list = (res.data as List)
            .map((e) => RSTagsModel.fromJson(e))
            .toList();
        return list;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  // 获取开屏随机角色
  static Future<ChaterModel?> splashRandomRole() async {
    try {
      var res = await api.request(
        RSApiUrl.splashRandomRole,
        method: HttpMethod.get,
        queryParameters: _qp,
      );
      var result = RSBaseModel.fromJson(
        res.data,
        (json) => ChaterModel.fromJson(json),
      );
      return result.data;
    } catch (e) {
      return null;
    }
  }

  static Future<RSChaterPageModel?> homeList({
    required int page,
    required int size,
    String? rendStyl,
    String? name,
    bool? videoChat,
    bool? genImg,
    bool? genVideo,
    bool? dress,
    List<int>? tags,
  }) async {
    try {
      var data = {
        'page': page,
        'size': size,
        'platform': Platform.isIOS
            ? RSAppConstants.platformIos
            : RSAppConstants.platformAndroid,
      };
      if (rendStyl != null) {
        data['render_style'] = rendStyl;
      }
      if (videoChat != null) {
        data['video_chat'] = videoChat;
      }
      if (genImg != null) {
        data['gen_img'] = genImg;
      }
      if (genVideo != null) {
        data['gen_video'] = genVideo;
      }
      if (dress != null) {
        data['change_clothing'] = dress;
      }
      if (name != null) {
        data['name'] = name;
      }
      if (tags != null && tags.isNotEmpty) {
        data['tags'] = tags;
      }
      var res = await api.request(
        RSApiUrl.roleList,
        data: data,
        method: HttpMethod.post,
        queryParameters: _qp,
      );
      final rolePage = RSChaterPageModel.fromJson(res.data);
      return rolePage;
    } catch (e) {
      return null;
    }
  }

  static Future<ChaterModel?> loadRoleById(String roleId) async {
    try {
      var qp = _qp;
      qp['id'] = roleId;
      var res = await api.request(
        RSApiUrl.getRoleById,
        method: HttpMethod.get,
        queryParameters: qp,
      );
      var role = ChaterModel.fromJson(res.data);
      return role;
    } catch (e) {
      return null;
    }
  }

  /// api signature msg
  static Future<String?> getApiSignature() async {
    try {
      if (userId == null || (userId?.isEmpty ?? true)) return null;
      const derEncodedPublicKey =
          'MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCLWMEjJb703WZJ5Nqf7qJ2wefSSYvbmQZM0CgHGrYstUaj4Mlz+P06mCqpVAYmyf3dJxLrEsUiobWvhi1Ut5W+PY0yrzEsIOJ5lJrIt1pm0/kcPsPj2d4cEl9S7DTEIJVQTGMzquAlhEkgbA0yDVXNtqqf4MECCADU/WM3WTCH2QIDAQAB';
      const pemPublicKey =
          '-----BEGIN PUBLIC KEY-----\n$derEncodedPublicKey\n-----END PUBLIC KEY-----';
      final parser = RSAKeyParser();
      final RSAPublicKey publicKey = parser.parse(pemPublicKey) as RSAPublicKey;
      final encrypter = Encrypter(
        RSA(publicKey: publicKey, encoding: RSAEncoding.PKCS1),
      );
      final encrypted = encrypter.encrypt(userId!);
      return encrypted.base64;
    } catch (e) {
      return null;
    }
  }

  static Future<int> consumeReq(int value, String from) async {
    // 使用公钥加密消息
    final uid = RS.login.currentUser?.id;
    if (uid == null || uid.isEmpty) return 0;
    final signature = await getApiSignature();

    var body = <String, dynamic>{
      'signature': signature,
      'id': uid,
      'gems': value,
      'description': from,
    };

    try {
      var res = await api.request(
        RSApiUrl.minusGems,
        method: HttpMethod.post,
        data: body,
        queryParameters: _qp,
      );
      if (res.statusCode == 200) {
        return res.data;
      } else {
        return 0;
      }
    } catch (e) {
      return 0;
    }
  }

  static Future<RSOrderModel?> makeIosOrder({
    required String skuId,
    required String orderType,
    bool? createImg,
    bool? createVideo,
  }) async {
    try {
      if (userId == null || (userId?.isEmpty ?? true)) return null;

      String deviceId = await getDeviceId();

      Map<String, dynamic> body = {
        'user_id': userId,
        'sku_id': skuId,
        'order_type': orderType,
        'device_id': deviceId,
      };
      if (createImg != null) {
        body['create_img'] = createImg;
      }
      if (createVideo != null) {
        body['create_video'] = createVideo;
      }

      var res = await api.request(
        RSApiUrl.createIosOrder,
        method: HttpMethod.post,
        data: body,
      );
      final result = RSBaseModel.fromJson(
        res.data,
        (data) => RSOrderModel.fromJson(data),
      );
      return result.data;
    } catch (e) {
      return null;
    }
  }

  static Future<bool> verifyIosOrder({
    required int orderId,
    required String? receipt,
    required String skuId,
    required String? transactionId,
    required String? purchaseDate,
    bool? dres,
    bool? createImg,
    bool? createVideo,
  }) async {
    try {
      if (userId == null || (userId?.isEmpty ?? true)) {
        return false;
      }
      var chooseEnv = RSAppConstants.isDebug ? false : true;

      final idfa = await RSInfoUtils.getIdfa();
      final adid = await RSInfoUtils.getAdid();

      var params = <String, dynamic>{
        'order_id': orderId,
        'user_id': userId,
        'receipt': receipt,
        'choose_env': chooseEnv,
        'idfa': idfa,
        'adid': adid,
        'sku_id': skuId,
        'transaction_id': transactionId,
        'purchase_date': purchaseDate,
      };
      if (dres != null) {
        params['dres'] = dres;
      }
      if (createImg != null) {
        params['create_img'] = createImg;
      }
      if (createVideo != null) {
        params['create_video'] = createVideo;
      }
      var res = await api.request(
        RSApiUrl.verifyIosReceipt,
        method: HttpMethod.post,
        data: params,
      );

      var data = RSBaseModel.fromJson(res.data, null);
      if (data.code == 0 || data.code == 200) {
        log.d('verifyIosOrder: ✅');
        return true;
      }
      log.w('verifyIosOrder: ❌ - code: ${data.code}');
      return false;
    } catch (e) {
      log.e('verifyIosOrder: 异常 - $e');
      return false;
    }
  }

  static Future<RSOrderModel?> makeAndOrder({
    required String orderType,
    required String skuId,
  }) async {
    try {
      if (userId == null || (userId?.isEmpty ?? true)) return null;

      String deviceId = await getDeviceId();

      var body = {
        'device_id': deviceId,
        'platform': Platform.isIOS
            ? RSAppConstants.platformIos
            : RSAppConstants.platformAndroid,
        'order_type': orderType,
        'sku_id': skuId,
        'user_id': userId,
      };

      var res = await api.request(
        RSApiUrl.createAndOrder,
        method: HttpMethod.post,
        data: body,
      );

      var result = RSBaseModel.fromJson(
        res.data,
        (data) => RSOrderModel.fromJson(data),
      );
      return result.data;
    } catch (e) {
      return null;
    }
  }

  // 安卓验签
  static Future<bool> verifyAndOrder({
    required String originalJson,
    required String purchaseToken,
    required String orderType,
    required String skuId,
    required String orderId,
    bool? dres,
    bool? createImg,
    bool? createVideo,
  }) async {
    try {
      if (userId == null || (userId?.isEmpty ?? true)) {
        log.w('verifyAndOrder: 用户ID为空');
        return false;
      }
      String androidId = await RS.storage.getDeviceId(isOrigin: true);
      final adid = await RSInfoUtils.getAdid();
      final gpsAdid = await RSInfoUtils.getGoogleAdId();
      var body = <String, dynamic>{
        'original_json': originalJson,
        'purchase_token': purchaseToken,
        'order_type': orderType,
        'sku_id': skuId,
        'order_id': orderId,
        'android_id': androidId,
        'gps_adid': gpsAdid,
        'adid': adid,
        'user_id': userId,
      };
      if (dres != null) {
        body['dres'] = dres;
      }
      if (createImg != null) {
        body['create_img'] = createImg;
      }
      if (createVideo != null) {
        body['create_video'] = createVideo;
      }
      log.d('verifyAndOrder: 请求参数构建完成 - ${body.keys.join(", ")}');
      var res = await api.request(
        RSApiUrl.verifyAndOrder,
        method: HttpMethod.post,
        data: body,
      );
      final data = RSBaseModel.fromJson(res.data, null);
      if (data.code == 0 || data.code == 200) {
        log.d('verifyAndOrder:  ✅');
        return true;
      }
      log.w('verifyAndOrder: ❌- code: ${data.code}');
      return false;
    } catch (e) {
      log.e('verifyAndOrder: 异常 - $e');
      return false;
    }
  }

  static Future<bool> collectRole(String roleId) async {
    try {
      var res = await api.request(
        RSApiUrl.collectRole,
        method: HttpMethod.post,
        data: {'character_id': roleId},
      );
      return res.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> cancelCollectRole(String roleId) async {
    try {
      var res = await api.request(
        RSApiUrl.cancelCollectRole,
        method: HttpMethod.post,
        data: {'character_id': roleId},
      );
      return res.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  static Future<List<RSConversationModel>?> sessionList(
    int page,
    int size,
  ) async {
    try {
      var res = await api.request(
        RSApiUrl.sessionList,
        method: HttpMethod.post,
        data: {'page': page, 'size': size},
        queryParameters: _qp,
      );
      final list = RSPagesModel.fromJson(
        res.data,
        (json) => RSConversationModel.fromJson(json),
      );
      return list.records;
    } catch (e) {
      log.e(e);
      return null;
    }
  }

  static Future<RSConversationModel?> addSession(String charId) async {
    try {
      var res = await api.request(
        RSApiUrl.addSession,
        method: HttpMethod.post,
        queryParameters: {'charId': charId},
      );
      return RSConversationModel.fromJson(res.data);
    } catch (e) {
      return null;
    }
  }

  static Future<RSConversationModel?> resetSession(int id) async {
    try {
      var res = await api.request(
        RSApiUrl.resetSession,
        method: HttpMethod.post,
        queryParameters: {'conversationId': id.toString()},
      );
      return RSConversationModel.fromJson(res.data);
    } catch (e) {
      return null;
    }
  }

  static Future<bool> deleteSession(int id) async {
    try {
      var res = await api.request(
        RSApiUrl.deleteSession,
        method: HttpMethod.post,
        queryParameters: {'id': id.toString()},
      );
      return res.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  static Future<RSChaterPageModel?> likedList(int page, int size) async {
    try {
      var res = await api.request(
        RSApiUrl.collectList,
        method: HttpMethod.post,
        data: {'page': page, 'size': size},
        queryParameters: _qp,
      );
      return RSChaterPageModel.fromJson(res.data);
    } catch (e) {
      return null;
    }
  }

  // 消息列表
  static Future<List<RSMessageModel>?> messageList(
    int page,
    int size,
    int convId,
  ) async {
    try {
      var res = await api.request(
        RSApiUrl.messageList,
        method: HttpMethod.post,
        data: {'page': page, 'size': size, 'conversation_id': convId},
        queryParameters: _qp,
      );
      final list = RSPagesModel.fromJson(
        res.data,
        (json) => RSMessageModel.fromJson(json),
      );
      return list.records;
    } catch (e) {
      return null;
    }
  }

  static Future<RSMsgReplayModel?> sendVoiceChatMsg({
    required String roleId,
    required String userId,
    required String nickName,
    required String message,
    String? msgId,
  }) async {
    try {
      var res = await api.request(
        RSApiUrl.voiceChat,
        method: HttpMethod.post,
        data: {
          'char_id': roleId,
          'user_id': userId,
          'nick_name': nickName,
          'message': message,
          if (msgId?.isNotEmpty == true) 'msg_id': msgId,
        },
        queryParameters: _qp,
      );
      return RSMsgReplayModel.fromJson(res.data);
    } catch (e) {
      return null;
    }
  }

  static Future<bool> updateEventParams({String? lang}) async {
    try {
      String deviceId = await Api.getDeviceId();
      final adid = await RSInfoUtils.getAdid();
      Map<String, dynamic> data = {
        'adid': adid,
        'device_id': deviceId,
        'platform': Platform.isIOS
            ? RSAppConstants.platformIos
            : RSAppConstants.platformAndroid,
      };

      if (Platform.isIOS) {
        String idfa = await RSInfoUtils.getIdfa();
        data['idfa'] = idfa;
      } else if (Platform.isAndroid) {
        final gpsAdid = await RSInfoUtils.getGoogleAdId();
        data['gps_adid'] = gpsAdid;
      }

      data['source_language'] = 'en';
      if (lang != null) {
        RS.storage.setLocale(lang);
      } else {
        String localeLang = RS.storage.locale;
        if (localeLang.isEmpty) {
          String? userLang = RS.login.currentUser?.targetLanguage;
          if (userLang != null) {
            data['target_language'] = userLang;
          } else {
            data['target_language'] = Get.deviceLocale?.languageCode;
          }
        } else {
          data['target_language'] = localeLang;
        }
      }

      if (lang != null) {
        data['target_language'] = lang;
      }
      var result = await api.request(
        RSApiUrl.eventParams,
        method: HttpMethod.post,
        data: data,
      );
      return result.data == true;
    } catch (e) {
      return false;
    }
  }

  static Future<List<RSLevelModel>?> getChatLevelConfig() async {
    try {
      var result = await api.request(
        RSApiUrl.chatLevelConfig,
        method: HttpMethod.get,
      );
      final list = result.data;
      if (list is List) {
        final datas = list.map((x) => RSLevelModel.fromJson(x)).toList();
        return datas;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<bool> unlockImageReq(int imageId, String modelId) async {
    try {
      var result = await api.request(
        RSApiUrl.unlockImage,
        method: HttpMethod.post,
        data: {'image_id': imageId, 'model_id': modelId},
      );

      return result.data;
    } catch (e) {
      return false;
    }
  }

  static Future<ChatAnserLevel?> fetchChatLevel({
    required String charId,
    required String userId,
  }) async {
    try {
      var qb = _qp;
      qb['charId'] = charId;
      qb['userId'] = userId;

      var result = await api.request(
        RSApiUrl.chatLevel,
        queryParameters: qb,
        method: HttpMethod.post,
      );
      var res = RSBaseModel.fromJson(
        result.data,
        (json) => ChatAnserLevel.fromJson(json),
      );
      return res.data;
    } catch (e) {
      return null;
    }
  }

  static Future<String?> translateText(
    String content, {
    String? slan = 'en',
    String? tlan,
  }) async {
    try {
      var result = await api.request(
        RSApiUrl.translate,
        method: HttpMethod.post,
        data: {
          'content': content,
          'source_language': slan,
          'target_language': tlan ?? Get.deviceLocale?.languageCode,
        },
      );
      final res = RSBaseModel.fromJson(result.data, null);
      return res.data;
    } catch (e) {
      return null;
    }
  }

  static Future getDailyReward() async {
    try {
      var result = await api.request(RSApiUrl.signIn, method: HttpMethod.post);
      final res = RSBaseModel.fromJson(result.data, null);
      if (res.code == 0 || res.code == 200) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> saveMsgTrans({
    required String id,
    required String text,
  }) async {
    try {
      var result = await api.post(
        RSApiUrl.saveMsg,
        data: {'translate_answer': text, 'id': id},
      );
      return result.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  /// 获取商品列表
  static Future<List<RSSkModel>?> getSkuList() async {
    try {
      var result = await api.get(RSApiUrl.skuList);
      var res = RSBaseModel.fromJson(result.data, null);
      if (res.data != null) {
        List<RSSkModel> skus = [];
        for (var item in res.data) {
          skus.add(RSSkModel.fromJson(item));
        }
        return skus;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  // /// 编辑消息
  static Future<RSMessageModel?> editMsg({
    required String id,
    required String text,
  }) async {
    try {
      var result = await api.post(
        RSApiUrl.editMsg,
        data: {'id': id, 'answer': text},
      );
      var res = RSBaseModel.fromJson(
        result.data,
        (json) => RSMessageModel.fromJson(json),
      );
      return res.data;
    } catch (e) {
      return null;
    }
  }

  /// 修改聊天场景
  static Future<bool> editScene({
    required int convId,
    required String scene,
    required String roleId,
  }) async {
    try {
      var result = await api.post(
        RSApiUrl.editScene,
        data: {
          'conversation_id': convId,
          'character_id': roleId,
          'scene': scene,
        },
      );
      var res = RSBaseModel.fromJson(result.data, null);
      return res.data == null ? false : true;
    } catch (e) {
      return false;
    }
  }

  /// 修改会话模式
  static Future<bool> editChatMode({
    required int convId,
    required String mode,
  }) async {
    try {
      var result = await api.post(
        RSApiUrl.editMode,
        data: {'id': convId, 'chat_model': mode},
      );
      var res = RSBaseModel.fromJson(result.data, null);
      return res.data;
    } catch (e) {
      return false;
    }
  }

  /// 新建 mask
  static Future<bool> createOrUpdateMask({
    required String name,
    required String age,
    required int gender,
    required String? description,
    required String? otherInfo,
    required int? id,
  }) async {
    try {
      final isEdit = id != null;
      final path = isEdit ? RSApiUrl.editMask : RSApiUrl.createMask;
      final body = <String, dynamic>{
        'profile_name': name,
        'age': age,
        'gender': gender,
        'description': description,
        'other_info': otherInfo,
        'user_id': userId,
      };
      if (isEdit) {
        body['id'] = id;
      }

      var result = await api.post(path, data: body);
      var res = RSBaseModel.fromJson(result.data, null);
      return isEdit ? res.data : res.data != null;
    } catch (e) {
      return false;
    }
  }

  /// 获取 mask 列表 分页
  static Future<List<RSMaskModel>?> getMaskList({
    int page = 1,
    int size = 10,
  }) async {
    try {
      var result = await api.post(
        RSApiUrl.getMaskList,
        data: {'page': page, 'size': size, 'user_id': userId},
      );

      final list = RSPagesModel.fromJson(
        result.data,
        (json) => RSMaskModel.fromJson(json),
      );
      return list.records;
    } catch (e) {
      return null;
    }
  }

  /// 切换 mask
  static Future<bool> changeMask({
    required int? conversationId,
    required int? maskId,
  }) async {
    try {
      var result = await api.post(
        RSApiUrl.changeMask,
        data: {'conversation_id': conversationId, 'profile_id': maskId},
      );
      var res = RSBaseModel.fromJson(result.data, null);
      return res.data;
    } catch (e) {
      return false;
    }
  }

  /// 获取各种价格配置
  static Future<RSPricesModel?> getPriceConfig() async {
    try {
      var result = await api.get(RSApiUrl.getPriceConfig);
      var res = RSPricesModel.fromJson(result.data);
      return res;
    } catch (e) {
      return null;
    }
  }

  /// 删除 mask
  static Future<bool> deleteMask({required int id}) async {
    try {
      var result = await api.post(RSApiUrl.deleteMask, data: {'id': id});
      var res = RSBaseModel.fromJson(result.data, null);
      return res.data ?? false;
    } catch (e) {
      return false;
    }
  }

  /// 发送消息
  static Future<RSBaseModel<RSMessageModel>?> sendMsg({
    required String path,
    Map<String, Object>? body,
  }) async {
    try {
      var result = await api.post(path, data: body);
      var res = RSBaseModel.fromJson(
        result.data,
        (x) => RSMessageModel.fromJson(x),
      );
      return res;
    } catch (e) {
      return null;
    }
  }

  /// 获取语言列表
  static Future<Map<String, dynamic>?> getAppLangs() async {
    try {
      var result = await api.get(RSApiUrl.supportLangs);
      var res = RSBaseModel.fromJson(result.data, null);
      if (res.data != null) {
        return res.data;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<List<RSPost>?> momensListPage({
    required int page,
    required int size,
  }) async {
    try {
      var res = await api.post(
        RSApiUrl.momentsList,
        data: {
          'page': page,
          'size': size,
          'hide_character': RS.storage.isRSB ? true : false,
        },
        queryParameters: _qp,
      );
      final pageData = RSPagesModel<RSPost>.fromJson(
        res.data,
        (json) => RSPost.fromJson(json),
      );
      return pageData.records;
    } catch (e) {
      return null;
    }
  }

  //获取预设提示词
  static Future<PresetTips?> getPresetTips() async {
    try {
      var res = await api.get(RSApiUrl.presetWordUrl);
      final result = RSBaseModel.fromJson(res.data, null);
      final list = PresetTips.fromJson(result.data);
      return list;
    } catch (e) {
      return null;
    }
  }
}
