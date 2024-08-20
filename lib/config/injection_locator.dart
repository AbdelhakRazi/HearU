import 'dart:async';

import 'package:flutter_sound/flutter_sound.dart';
import 'package:get_it/get_it.dart';
import 'package:hearu/services/audio/flutter_sound_recorder_service.dart';
import 'package:hearu/services/audio/recorder_service.dart';

final locator = GetIt.instance;

void setup() {
  locator.registerLazySingleton<RecorderService>(() =>
      FlutterSoundRecorderService(
          recorder: FlutterSoundRecorder(),
          audioRecorderController: StreamController()));
}
