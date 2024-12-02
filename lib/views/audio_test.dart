import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';

import 'package:hearu/services/transcribe-client/transcribe.dart';
import 'package:permission_handler/permission_handler.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _transcribe = Transcribe();
  final _flutterSoundRecorder = FlutterSoundRecorder();
  bool _isRecording = false;
  String _transcription = "";

  Future<void> _startRecording() async {
    await Permission.microphone.request();
    if (await Permission.microphone.isGranted) {
      await _flutterSoundRecorder.startRecorder(
        //toStream: await _transcribe.getAudioStreamSink(),
        codec: Codec.pcm16,
        numChannels: 1,
        sampleRate: 16000,
      );
      setState(() {
        _isRecording = true;
        _transcription = "";
      });
    } else {
      // Handle permission denied case
    }
  }

  Future<void> _stopRecording() async {
    await _flutterSoundRecorder.stopRecorder();
    setState(() {
      _isRecording = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Speech to Text"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_transcription),
            ElevatedButton(
              onPressed: _isRecording ? _stopRecording : _startRecording,
              child: Text(_isRecording ? "Stop Recording" : "Start Recording"),
            ),
          ],
        ),
      ),
    );
  }
}
