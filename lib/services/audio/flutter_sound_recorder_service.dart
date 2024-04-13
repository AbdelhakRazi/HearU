// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

import 'recorder_service.dart';

class FlutterSoundRecorderService extends RecorderService {
  FlutterSoundRecorder recorder;
  StreamController<Food> audioRecorderController;
  FlutterSoundRecorderService({
    required this.recorder,
    required this.audioRecorderController,
  }) {
    debugPrint("flutter sound service created");
  }
  @override
  Future<void> startRecording() async {
    final isGranted = await _checkPermissions();
    if (isGranted) {
      await recorder.openRecorder();
      await recorder.startRecorder(
          toStream: audioRecorderController.sink, codec: Codec.pcm16);
    }
  }

  @override
  Future<void> stopRecording() async {
    await recorder.stopRecorder();
    await audioRecorderController.close();
    await recorder.closeRecorder();
  }

  Future<bool> _checkPermissions() async {
    if (!await Permission.microphone.request().isGranted) {
      return false;
    }
    return true;
  }
}
