// import 'dart:io';
//
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_tts/flutter_tts.dart';
// import 'package:flutter_tts/flutter_tts_web.dart';
//
// class TTSService {
//   late FlutterTts flutterTts;
//   String? language;
//   String? engine;
//   double volume = 0.5;
//   double pitch = 1.0;
//   double rate = 0.5;
//   bool isCurrentLanguageInstalled = false;
//
//   String? _newVoiceText;
//   int? _inputLength;
//
//   TtsState ttsState = TtsState.stopped;
//
//   bool get isPlaying => ttsState == TtsState.playing;
//   bool get isStopped => ttsState == TtsState.stopped;
//   bool get isPaused => ttsState == TtsState.paused;
//   bool get isContinued => ttsState == TtsState.continued;
//
//   bool get isIOS => !kIsWeb && Platform.isIOS;
//   bool get isAndroid => !kIsWeb && Platform.isAndroid;
//   bool get isWindows => !kIsWeb && Platform.isWindows;
//   bool get isWeb => kIsWeb;
//
//   TTSService() {
//     flutterTts = FlutterTts();
//   }
// }
