import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

/// 音频工具类 - 提供基础音频操作功能
///
/// 职责说明：
/// - 简化为工具类，专注于基础音频操作
/// - 移除复杂的状态管理，由AudioPlayerService负责
/// - 提供静态方法，更容易使用
class RSAudioUtils {
  static AudioContext? _audioContextDefault;

  /// 初始化音频播放器全局配置
  static Future<void> initAudioPlayer() async {
    await _setupSpeaker();
  }

  /// 格式化音频时间显示
  ///
  /// [value] 时间值（秒）
  /// 返回格式化的时间字符串，如 "1:23" 或 "1h2:34"
  static String audioTimer(int value) {
    int hours = value ~/ 3600;
    int minutes = (value % 3600) ~/ 60;
    int seconds = value % 60;

    // 使用 StringBuffer 构建字符串
    final str = StringBuffer();

    if (hours > 0) {
      str.write('${hours}h');
    }

    // 格式化分钟和秒，确保两位数显示
    str.write('${minutes.toString().padLeft(2, '0')}:');
    str.write(seconds.toString().padLeft(2, '0'));

    return str.toString();
  }

  /// 创建新的音频播放器实例
  ///
  /// [playerId] 播放器唯一标识
  /// 返回配置好的AudioPlayer实例
  static Future<AudioPlayer> createAudioPlayer(String playerId) async {
    final player = AudioPlayer(playerId: playerId);

    // 应用全局音频上下文配置
    if (_audioContextDefault != null) {
      await player.setAudioContext(_audioContextDefault!);
    }

    return player;
  }

  /// 获取音频文件时长
  ///
  /// [source] 音频源
  /// 返回音频时长，获取失败时返回null
  static Future<Duration?> getAudioDuration(Source source) async {
    try {
      final tempPlayer = AudioPlayer();
      await tempPlayer.setSource(source);
      final duration = await tempPlayer.getDuration();
      await tempPlayer.dispose();
      return duration;
    } catch (e) {
      debugPrint('⚠️ RSAudioUtils: 获取音频时长失败: $e');
      return null;
    }
  }

  /// 初始化音频上下文配置
  static Future<void> _setupSpeaker() async {
    _audioContextDefault = await _getAudioContext();
    await AudioPlayer.global.setAudioContext(_audioContextDefault!);
    debugPrint('🎧 RSAudioUtils: 全局音频配置初始化完成');
  }

  /// 获取平台特定的音频上下文配置
  static Future<AudioContext> _getAudioContext() async {
    bool isSpeakerphoneOn = true;

    return AudioContext(
      android: AudioContextAndroid(
        usageType: AndroidUsageType.media,
        audioMode: AndroidAudioMode.normal,
        isSpeakerphoneOn: isSpeakerphoneOn,
      ),
      iOS: AudioContextIOS(
        category: AVAudioSessionCategory.playback,
        options: const {AVAudioSessionOptions.mixWithOthers},
      ),
    );
  }

  /// 获取当前全局音频上下文
  static AudioContext? get globalAudioContext => _audioContextDefault;
}
