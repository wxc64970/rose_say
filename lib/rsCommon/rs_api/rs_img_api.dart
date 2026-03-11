import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:rose_say/rsCommon/index.dart';

class ImageAPI {
  /// 获取风格配置
  static Future<List<RSImgStyle>> fetchStyleConf() async {
    final resp = await api.post(RSApiUrl.styleConf);
    final data = RSBaseModel.fromJson(resp.data, null);
    final list = data.data;
    return list == null
        ? []
        : (list as List).map((e) {
            return RSImgStyle.fromJson(e);
          }).toList();
  }

  /// ai生成图片历史
  static Future<List<RSImageHistroy>?> getHistory(String characterId) async {
    try {
      const path = RSApiUrl.aiGetHistroy;
      final baseRes = await api.post(path, data: {"character_id": characterId});
      final resp = RSPagesModel.fromJson(
        baseRes.data,
        (json) => RSImageHistroy.fromJson(json),
      );
      // final resp = baseRes.data["records"];
      return (resp.records ?? []).map((e) {
        return e;
      }).toList();
    } catch (e) {
      RSLoading.close();
      return null;
    }
  }

  /// 上传图片, ai 图片
  /// 角色
  static Future<RSImgUpModle?> uploadRoleImage({
    required String style,
    required String characterId,
  }) async {
    try {
      // 上传图片
      final formData = dio.FormData.fromMap({
        'style': style,
        'characterId': characterId,
      });
      final ops = dio.Options(
        receiveTimeout: const Duration(seconds: 160),
        contentType: 'multipart/form-data',
      );

      const path = RSApiUrl.upImageForAiImage;
      final response = await api.uploadFile(path, data: formData, options: ops);
      final json = response.data['data'];
      final data = RSImgUpModle.fromJson(json);
      return data;
    } catch (e) {
      return null;
    }
  }

  static Future<RSImgUpModle?> uploadAiImage({
    required String imagePath,
    required String style,
  }) async {
    try {
      // 选择图片
      final file = File(imagePath);

      // 压缩和转换后的文件
      final processedFile = await RSImageUtils.processImage(file);
      if (processedFile == null) {
        return null;
      }

      // 上传图片
      final formData = dio.FormData.fromMap({
        'file': await dio.MultipartFile.fromFile(
          processedFile.path,
          filename: 'img_${DateTime.now().millisecondsSinceEpoch}.jpg',
        ),
        'style': style,
      });

      final ops = dio.Options(
        receiveTimeout: const Duration(seconds: 180),
        contentType: 'multipart/form-data',
        method: 'POST',
      );

      const path = RSApiUrl.upImageForAiImage;

      var response = await api.uploadFile(path, data: formData, options: ops);
      final json = response.data['data'];
      final data = RSImgUpModle.fromJson(json);
      return data;
    } catch (e) {
      return null;
    }
  }

  /// 获取任务结果 ai 图片
  static Future<ImageResultRes?> getImageResult(
    String taskId, {
    int attempt = 0,
    int maxAttempts = 30,
  }) async {
    try {
      final res = await api.post(
        RSApiUrl.aiImageResult,
        queryParameters: {'taskId': taskId},
      );
      var baseResponse = RSBaseModel.fromJson(res.data, null);
      final json = baseResponse.data;

      if (json == null) {
        await Future.delayed(const Duration(seconds: 15));
        return await getImageResult(
          taskId,
          attempt: attempt + 1,
          maxAttempts: maxAttempts,
        );
      } else {
        final data = ImageResultRes.fromJson(json);
        if (data.status == 2) {
          return data;
        } else if (attempt < maxAttempts) {
          await Future.delayed(const Duration(seconds: 15));
          return await getImageResult(
            taskId,
            attempt: attempt + 1,
            maxAttempts: maxAttempts,
          );
        } else {
          return null; // 达到最大递归次数后返回null
        }
      }
    } catch (e) {
      return null;
    }
  }

  /// 上传图片, ai 视频
  static Future<RSImgUpModle?> uploadImgToVideo({
    required String imagePath,
    required String enText,
  }) async {
    try {
      // 选择图片
      final file = File(imagePath);

      /// 文件 md5
      var md5 = await RSImageUtils.calculateMd5(file);

      // 压缩和转换后的文件
      final processedFile = await RSImageUtils.processImage(file);
      if (processedFile == null) {
        return null;
      }

      // 上传图片
      final formData = dio.FormData.fromMap({
        'file': await dio.MultipartFile.fromFile(
          processedFile.path,
          filename: 'img_${DateTime.now().millisecondsSinceEpoch}.jpg',
        ),
        'style': enText,
        'fileMd5': md5,
      });

      final ops = dio.Options(
        receiveTimeout: const Duration(seconds: 180),
        contentType: 'multipart/form-data',
        method: 'POST',
      );

      const path = RSApiUrl.upImageForAiVideo;

      final response = await api.uploadFile(path, data: formData, options: ops);
      final json = response.data['data'];
      final data = RSImgUpModle.fromJson(json);
      return data;
    } catch (e) {
      return null;
    }
  }

  /// 获取任务结果 ai 视频
  static Future<ImageVideoResItem?> getVideoResult(
    String taskId, {
    int attempt = 0,
    int maxAttempts = 30,
  }) async {
    try {
      final res = await api.post(
        RSApiUrl.aiVideoResult,
        queryParameters: {'taskId': taskId},
      );
      final json = res.data['data'];

      if (json == null) {
        await Future.delayed(const Duration(seconds: 15));
        return await getVideoResult(
          taskId,
          attempt: attempt + 1,
          maxAttempts: maxAttempts,
        );
      } else {
        final data = ImageVideoResult.fromJson(json);
        final item = data.item;

        if (item != null && item.resultPath?.isNotEmpty == true) {
          return item;
        } else if (attempt < maxAttempts) {
          await Future.delayed(const Duration(seconds: 15));
          return await getVideoResult(
            taskId,
            attempt: attempt + 1,
            maxAttempts: maxAttempts,
          );
        } else {
          return null; // 达到最大递归次数后返回null
        }
      }
    } catch (e) {
      return null;
    }
  }

  /// sku 列表
  static Future<List<RSSkModel>?> getSkuList() async {
    return await Api.getSkuList();
  }

  /// 获取AI Photo页配置
  static Future<List<ItemConfigs>?> getAiPhoto() async {
    try {
      final res = await api.get(RSApiUrl.aiphoto);
      var baseResponse = RSAiPhoto.fromJson(res.data);
      return baseResponse.itemConfigs;
    } catch (e) {
      return null;
    }
  }

  /// 获取 ImageStyle 数据
  static Future<List<RSImageStyle>?> getImageStyle() async {
    try {
      final res = await api.get(RSApiUrl.imageStyle);
      final data = RSBaseModel.fromJson(res.data, null);
      final list = data.data;
      return list == null
          ? []
          : (list as List).map((e) {
              return RSImageStyle.fromJson(e);
            }).toList();
    } catch (e) {
      return null;
    }
  }

  // 头像 选项
  static Future<List<RSAiAvatarOptions>?> getDetailOptions() async {
    try {
      var response = await api.get(RSApiUrl.detailOptionsUrl);
      final result = RSBaseModel.fromJson(response.data, null);
      final data = result.data;
      if (data != null && data is List) {
        return data.map((e) => RSAiAvatarOptions.fromJson(e)).toList();
      }
      return null;
    } catch (e) {
      log.e(e);
      return null;
    }
  }

  // 用户资产
  static Future<RSAccountAssets?> getUserAsset() async {
    try {
      var result = await api.get(RSApiUrl.userAssets);
      var res = RSBaseModel.fromJson(
        result.data,
        (data) => RSAccountAssets.fromJson(data),
      );
      return res.data;
    } catch (e) {
      return null;
    }
  }

  // 头像 AI写作 - 图片提示词
  static Future<String?> avatarAiWriteWords(Map<String, dynamic> params) async {
    try {
      var response = await api.post(RSApiUrl.aiWriteAvatarUrl, data: params);
      final result = RSBaseModel.fromJson(response.data, null);
      final data = result.data;
      if (data != null && data is Map) {
        return data['prompt'];
      }
      return null;
    } catch (e) {
      log.e(e);
      return null;
    }
  }

  // 生成头像
  static Future<int?> avatarAiGenerate(Map<String, dynamic> params) async {
    try {
      var res = await api.post(RSApiUrl.generateAvatarUrl, data: params);
      final result = RSBaseModel.fromJson(res.data, null);
      final data = result.data;
      if (data != null && data is int) {
        return data;
      }
      return null;
    } catch (e) {
      log.e(e);
      return null;
    }
  }

  // 生成头像消耗gems
  static Future<RSBaseModel?> avatarAiGenerateGems(
    Map<String, dynamic> params,
  ) async {
    try {
      var res = await api.post(RSApiUrl.generateAvatarGemsUrl, data: params);
      final result = RSBaseModel.fromJson(res.data, null);
      return result;
    } catch (e) {
      log.e(e);
      return null;
    }
  }

  // 生成头像结果
  // static Future<RSGenAvatarResult?> avatarAiGenerateResult(int id) async {
  static Future<RSBaseModel?> avatarAiGenerateResult(int id) async {
    try {
      log.d('Requesting avatar generation result for id: $id');
      Map<String, String> query = {"id": id.toString()};
      var response = await api.get(
        RSApiUrl.generateAvatarResulGemstUrl,
        queryParameters: query,
      );
      log.d('API Response success: ${response.data}');
      var res = RSBaseModel.fromJson(
        response.data,
        null,
        // (json) => RSGenAvatarResult.fromJson(json),
      );
      return res;
    } catch (e) {
      log.e('avatarAiGenerateResult error: $e');
      return null;
    }
  }

  /// AI photo 历史记录列表查询
  static Future<List<RSCreationsHistory>> getAiPhotoHistoryList({
    required int page,
    required int size,
    int? type,
  }) async {
    try {
      var data = {'page': page, 'size': size, 'type': type};
      var res = await api.request(
        RSApiUrl.generateAvatarHistoryUrl,
        data: data,
        method: HttpMethod.post,
      );

      final baseModel = RSBaseModel.fromJson(res.data, null);
      final list = RSPagesModel.fromJson(
        baseModel.data,
        (json) => RSCreationsHistory.fromJson(json),
      );
      return (list.records ?? []).map((e) {
        return e;
      }).toList();
    } catch (e) {
      return [];
    }
  }

  // 获取AI photo 历史记录列表总数
  static Future getAiPhotoHistoryCount() async {
    try {
      var response = await api.get(RSApiUrl.generateAvatarHistoryCountUrl);
      final result = RSBaseModel.fromJson(response.data, (json) => json);
      final datas = result.data;

      return datas;
    } catch (e) {
      log.e(e);
      return {};
    }
  }

  //AI photo 历史记录删除
  static Future<bool> deleteAiPhotoHistory(List<int> ids) async {
    try {
      var response = await api.post(
        RSApiUrl.generateAvatarHistoryDeleteUrl,
        data: {'ids': ids},
      );
      final result = RSBaseModel.fromJson(response.data, null);
      return result.data;
    } catch (e) {
      log.e(e);
      return false;
    }
  }
}
