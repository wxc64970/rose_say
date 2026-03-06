import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:rose_say/rsCommon/index.dart';

/// 音频播放状态枚举
enum AudioPlayState {
  stopped, // 停止
  downloading, // 下载中
  playing, // 播放中
  paused, // 暂停
  error, // 错误
}

/// 音频状态信息
class AudioStateInfo {
  final String msgId;
  final AudioPlayState state;
  final String? filePath;
  final int audioDuration;
  final String? errorMessage;

  AudioStateInfo({
    required this.msgId,
    required this.state,
    this.filePath,
    required this.audioDuration,
    this.errorMessage,
  });

  AudioStateInfo copyWith({
    String? msgId,
    AudioPlayState? state,
    String? filePath,
    int? audioDuration,
    String? errorMessage,
  }) {
    return AudioStateInfo(
      msgId: msgId ?? this.msgId,
      state: state ?? this.state,
      filePath: filePath ?? this.filePath,
      audioDuration: audioDuration ?? this.audioDuration,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

/// 全局音频播放管理服务
class RSAudioPlayerService extends GetxService {
  /// 音频播放器
  AudioPlayer? _audioPlayer;

  /// 所有音频状态映射 msgId -> AudioStateInfo
  final RxMap<String, AudioStateInfo> _audioStates =
      <String, AudioStateInfo>{}.obs;

  /// 当前正在播放的音频信息
  final Rx<AudioStateInfo?> currentPlayingAudio = Rx<AudioStateInfo?>(null);

  /// 播放器状态订阅
  StreamSubscription<PlayerState>? _playerStateSubscription;

  /// 重试次数映射
  final Map<String, int> _retryCount = {};

  /// 最大重试次数
  static const int _maxRetryCount = 1;

  /// 下载超时时间
  static const int _downloadTimeoutSeconds = 30;

  /// 播放超时时间
  static const int _playTimeoutSeconds = 5;

  @override
  void onInit() {
    super.onInit();
    _initializeAudioService();
  }

  /// 初始化音频服务
  Future<void> _initializeAudioService() async {
    try {
      // 使用AudioUtils初始化全局音频配置
      await RSAudioUtils.initAudioPlayer();

      // 初始化当前管理器的音频播放器
      await _initializeAudioPlayer();

      debugPrint('🎧 RSAudioPlayerService: 音频管理器初始化成功');
    } catch (e) {
      debugPrint('⚠️ RSAudioPlayerService: 音频管理器初始化失败: $e');
    }
  }

  @override
  void onClose() {
    debugPrint('🎧 RSAudioPlayerService: 开始清理资源');
    _cleanupResources();
    super.onClose();
  }

  /// 初始化音频播放器
  Future<void> _initializeAudioPlayer() async {
    try {
      // 使用AudioUtils创建配置好的播放器
      _audioPlayer = await RSAudioUtils.createAudioPlayer(
        'global_audio_player',
      );

      // 监听播放器状态变化
      _playerStateSubscription = _audioPlayer!.onPlayerStateChanged.listen(
        _handlePlayerStateChanged,
        onError: (error) {
          debugPrint('⚠️ RSAudioPlayerService: 播放器状态监听错误: $error');
        },
      );

      debugPrint('🎧 RSAudioPlayerService: 音频播放器初始化成功');
    } catch (e) {
      debugPrint('⚠️ RSAudioPlayerService: 音频播放器初始化失败: $e');
    }
  }

  /// 处理播放器状态变化
  void _handlePlayerStateChanged(PlayerState state) {
    final currentAudio = currentPlayingAudio.value;
    if (currentAudio == null) return;

    debugPrint('🎧 RSAudioPlayerService: 播放器状态变化: $state');

    switch (state) {
      case PlayerState.completed:
        debugPrint(
          '🎧 RSAudioPlayerService: 音频播放完成, msgId: ${currentAudio.msgId}',
        );
        _updateAudioState(currentAudio.msgId, AudioPlayState.stopped);
        currentPlayingAudio.value = null;
        break;
      case PlayerState.stopped:
        debugPrint(
          '🎧 RSAudioPlayerService: 音频播放停止, msgId: ${currentAudio.msgId}',
        );
        _updateAudioState(currentAudio.msgId, AudioPlayState.stopped);
        currentPlayingAudio.value = null;
        break;
      default:
        break;
    }
  }

  // ==================== 公共接口 ====================

  /// 开始播放音频
  Future<void> startPlay(String msgId, String? audioUrl) async {
    try {
      debugPrint('🎧 RSAudioPlayerService: 开始播放音频, msgId: $msgId');

      // 验证参数
      if (audioUrl == null || audioUrl.isEmpty) {
        debugPrint('⚠️ RSAudioPlayerService: 音频URL为空，无法播放');
        _updateAudioState(msgId, AudioPlayState.error, errorMessage: '音频URL为空');
        return;
      }

      // 停止其他正在播放的音频
      await _stopCurrentAudio();

      // 更新状态为下载中（不设置时长，等待实际获取）
      _updateAudioState(msgId, AudioPlayState.downloading);

      // 下载音频文件
      String? downloadedFilePath = await _downloadAudioWithRetry(
        msgId,
        audioUrl,
      );
      if (downloadedFilePath == null) {
        _updateAudioState(msgId, AudioPlayState.error, errorMessage: '下载失败');
        return;
      }

      // 检查音频是否在下载过程中被停止
      final currentState = _audioStates[msgId];
      if (currentState?.state == AudioPlayState.stopped) {
        debugPrint('🎧 RSAudioPlayerService: 音频在下载过程中被停止，取消播放, msgId: $msgId');
        return;
      }

      debugPrint('🎧 RSAudioPlayerService: 音频下载成功, 路径: $downloadedFilePath');

      // 获取实际音频时长
      int currentDuration = await _getAudioDuration(downloadedFilePath);
      debugPrint('🎧 RSAudioPlayerService: 获取实际音频时长: $currentDuration ms');

      // 验证文件完整性
      if (!await _validateAudioFile(downloadedFilePath, currentDuration)) {
        debugPrint('⚠️ RSAudioPlayerService: 音频文件验证失败，强制重新下载');
        // 删除不完整的文件
        final file = File(downloadedFilePath);
        if (await file.exists()) {
          await file.delete();
          debugPrint('🎧 RSAudioPlayerService: 已删除不完整的缓存文件');
        }

        // 等待片刻后重新下载
        await Future.delayed(const Duration(milliseconds: 500));

        // 再次检查是否被停止
        final recheckState = _audioStates[msgId];
        if (recheckState?.state == AudioPlayState.stopped) {
          debugPrint(
            '🎧 RSAudioPlayerService: 音频在重新下载前被停止，取消播放, msgId: $msgId',
          );
          return;
        }

        // 重新下载
        downloadedFilePath = await _downloadAudioWithRetry(
          msgId,
          audioUrl,
          forceRedownload: true,
        );
        if (downloadedFilePath == null) {
          _updateAudioState(
            msgId,
            AudioPlayState.error,
            errorMessage: '重新下载失败',
          );
          return;
        }

        currentDuration = await _getAudioDuration(downloadedFilePath);
        debugPrint('🎧 RSAudioPlayerService: 重新下载后时长: $currentDuration ms');

        // 再次验证
        if (!await _validateAudioFile(downloadedFilePath, currentDuration)) {
          debugPrint('⚠️ RSAudioPlayerService: 重新下载后仍然验证失败，可能是服务器文件问题');
          _updateAudioState(
            msgId,
            AudioPlayState.error,
            errorMessage: '文件仍然不完整',
          );
          return;
        }
      }

      // 最终检查是否被停止（在播放前的最后检查）
      final finalState = _audioStates[msgId];
      if (finalState?.state == AudioPlayState.stopped) {
        debugPrint('🎧 RSAudioPlayerService: 音频在播放前被停止，取消播放, msgId: $msgId');
        return;
      }

      // 开始播放
      await _playAudioFile(msgId, downloadedFilePath, currentDuration);
    } catch (e) {
      debugPrint('⚠️ RSAudioPlayerService: 播放音频异常: $e');
      _updateAudioState(
        msgId,
        AudioPlayState.error,
        errorMessage: e.toString(),
      );
    }
  }

  /// 停止播放指定音频
  Future<void> stopPlay(String msgId) async {
    try {
      debugPrint('🎧 RSAudioPlayerService: 停止播放音频, msgId: $msgId');

      final currentAudio = currentPlayingAudio.value;
      if (currentAudio?.msgId == msgId) {
        await _audioPlayer?.stop();
        currentPlayingAudio.value = null;
      }

      _updateAudioState(msgId, AudioPlayState.stopped);
    } catch (e) {
      debugPrint('⚠️ RSAudioPlayerService: 停止播放异常: $e');
    }
  }

  /// 停止所有音频播放
  Future<void> stopAll() async {
    try {
      debugPrint('🎧 RSAudioPlayerService: 停止所有音频播放');
      await _audioPlayer?.stop();
      currentPlayingAudio.value = null;

      // 更新所有状态为停止，包括正在下载的音频
      for (final msgId in _audioStates.keys) {
        final audioState = _audioStates[msgId];
        if (audioState?.state == AudioPlayState.playing ||
            audioState?.state == AudioPlayState.downloading) {
          _updateAudioState(msgId, AudioPlayState.stopped);
          debugPrint(
            '🎧 RSAudioPlayerService: 停止音频 $msgId, 原状态: ${audioState?.state}',
          );
        }
      }
    } catch (e) {
      debugPrint('⚠️ RSAudioPlayerService: 停止所有播放异常: $e');
    }
  }

  /// 获取音频状态
  AudioStateInfo? getAudioState(String msgId) {
    return _audioStates[msgId];
  }

  // ==================== 私有方法 ====================

  /// 停止当前播放的音频
  Future<void> _stopCurrentAudio() async {
    final currentAudio = currentPlayingAudio.value;
    if (currentAudio != null) {
      debugPrint(
        '🎧 RSAudioPlayerService: 停止当前音频, msgId: ${currentAudio.msgId}',
      );
      await _audioPlayer?.stop();
      _updateAudioState(currentAudio.msgId, AudioPlayState.stopped);
      currentPlayingAudio.value = null;
    }
  }

  /// 下载音频文件（带重试）
  Future<String?> _downloadAudioWithRetry(
    String msgId,
    String audioUrl, {
    bool forceRedownload = false,
  }) async {
    final retryKey = msgId;
    _retryCount[retryKey] = _retryCount[retryKey] ?? 0;

    while (_retryCount[retryKey]! < _maxRetryCount) {
      try {
        debugPrint('🎧 RSAudioPlayerService: 开始下载音频, URL: $audioUrl');

        // 如果需要强制重新下载，先删除已存在的文件
        if (forceRedownload) {
          final fileName = FileDownloadService.instance.generateFileNameFromUrl(
            audioUrl,
          );
          final docDir = await getApplicationDocumentsDirectory();
          final folderPath = path.join(docDir.path, 'audios_files');
          final existingFilePath = path.join(folderPath, fileName);
          final existingFile = File(existingFilePath);
          if (await existingFile.exists()) {
            await existingFile.delete();
            debugPrint('🎧 RSAudioPlayerService: 已删除旧缓存文件: $existingFilePath');
          }
        }

        final filePath = await FileDownloadService.instance
            .downloadFile(audioUrl, fileType: FileType.audio)
            .timeout(
              const Duration(seconds: _downloadTimeoutSeconds),
              onTimeout: () => throw TimeoutException(
                '下载超时',
                const Duration(seconds: _downloadTimeoutSeconds),
              ),
            );

        if (filePath != null && await File(filePath).exists()) {
          _retryCount.remove(retryKey); // 清除重试次数
          return filePath;
        } else {
          throw Exception('下载返回空路径或文件不存在');
        }
      } catch (e) {
        _retryCount[retryKey] = _retryCount[retryKey]! + 1;
        debugPrint(
          '⚠️ RSAudioPlayerService: 下载失败 (${_retryCount[retryKey]}/$_maxRetryCount): $e',
        );

        if (_retryCount[retryKey]! >= _maxRetryCount) {
          _retryCount.remove(retryKey);
          break;
        }

        // 等待后重试
        await Future.delayed(Duration(seconds: _retryCount[retryKey]!));
      }
    }

    return null;
  }

  /// 获取音频时长 - 使用AudioUtils
  Future<int> _getAudioDuration(String filePath) async {
    try {
      final source = DeviceFileSource(filePath);
      final duration = await RSAudioUtils.getAudioDuration(source);

      if (duration != null) {
        return duration.inMilliseconds;
      } else {
        debugPrint('⚠️ RSAudioPlayerService: 无法获取音频时长');
        return 0;
      }
    } catch (e) {
      debugPrint('⚠️ RSAudioPlayerService: 获取音频时长异常: $e');
      return 0;
    }
  }

  /// 验证音频文件完整性
  Future<bool> _validateAudioFile(String filePath, int duration) async {
    try {
      final file = File(filePath);

      // 检查文件是否存在
      if (!await file.exists()) {
        debugPrint('⚠️ RSAudioPlayerService: 音频文件不存在: $filePath');
        return false;
      }

      // 检查文件大小（小于1KB可能是不完整的）
      final fileSize = await file.length();
      if (fileSize < 1024) {
        debugPrint('⚠️ RSAudioPlayerService: 音频文件过小: ${fileSize}B');
        return false;
      }

      // 检查时长合理性（小于1秒可能有问题）
      if (duration < 1000) {
        debugPrint('⚠️ RSAudioPlayerService: 音频时长过短: ${duration}ms');
        return false;
      }

      debugPrint(
        '🎧 RSAudioPlayerService: 音频文件验证通过, 文件大小: ${fileSize}B, 时长: ${duration}ms',
      );
      return true;
    } catch (e) {
      debugPrint('⚠️ RSAudioPlayerService: 验证音频文件异常: $e');
      return false;
    }
  }

  /// 播放音频文件
  Future<void> _playAudioFile(
    String msgId,
    String filePath,
    int duration,
  ) async {
    try {
      debugPrint(
        '🎧 RSAudioPlayerService: 开始播放音频文件, msgId: $msgId, 路径: $filePath, duration: $duration',
      );

      if (_audioPlayer == null) {
        throw Exception('音频播放器未初始化');
      }

      // 播放前最后一次检查状态
      final currentState = _audioStates[msgId];
      if (currentState?.state == AudioPlayState.stopped) {
        debugPrint('🎧 RSAudioPlayerService: 音频在播放前被停止，取消播放, msgId: $msgId');
        return;
      }

      // 更新状态为正在播放
      final audioState = AudioStateInfo(
        msgId: msgId,
        state: AudioPlayState.playing,
        filePath: filePath,
        audioDuration: duration,
      );

      _audioStates[msgId] = audioState;
      currentPlayingAudio.value = audioState;

      // 触发状态更新
      _audioStates.refresh();

      debugPrint('🎧 RSAudioPlayerService: 开始播放音频文件');

      // 开始播放
      await _audioPlayer!
          .play(DeviceFileSource(filePath))
          .timeout(
            const Duration(seconds: _playTimeoutSeconds),
            onTimeout: () => throw TimeoutException(
              '播放超时',
              const Duration(seconds: _playTimeoutSeconds),
            ),
          );
    } catch (e) {
      debugPrint('⚠️ RSAudioPlayerService: 播放音频文件异常: $e');
      _updateAudioState(
        msgId,
        AudioPlayState.error,
        errorMessage: e.toString(),
      );
      currentPlayingAudio.value = null;
    }
  }

  /// 更新音频状态
  void _updateAudioState(
    String msgId,
    AudioPlayState state, {
    String? filePath,
    int? audioDuration,
    String? errorMessage,
  }) {
    final currentState = _audioStates[msgId];

    final newState = AudioStateInfo(
      msgId: msgId,
      state: state,
      filePath: filePath ?? currentState?.filePath,
      audioDuration: audioDuration ?? currentState?.audioDuration ?? 0,
      errorMessage: errorMessage,
    );

    _audioStates[msgId] = newState;
    debugPrint('🎧 RSAudioPlayerService: 音频状态更新, msgId: $msgId, state: $state');
  }

  /// 清理资源
  void _cleanupResources() {
    try {
      debugPrint('🎧 RSAudioPlayerService: 开始清理资源...');

      // 停止所有音频播放
      _audioPlayer?.stop();

      // 取消状态监听
      _playerStateSubscription?.cancel();
      _playerStateSubscription = null;

      // 释放音频播放器
      _audioPlayer?.dispose();
      _audioPlayer = null;

      // 清理状态数据
      _audioStates.clear();
      currentPlayingAudio.value = null;
      _retryCount.clear();

      debugPrint('🎧 RSAudioPlayerService: 资源清理完成');
    } catch (e) {
      debugPrint('⚠️ RSAudioPlayerService: 资源清理异常: $e');
    }
  }
}
