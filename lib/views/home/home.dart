import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:hearu/services/transcribe-client/transcribe.dart';
import 'package:hearu/services/transcribe_api.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  final List<double> _waveformAmplitudes = [];
  StreamController<Uint8List>? _audioStreamController;
  bool _isRecording = false;

  @override
  void initState() {
    super.initState();
    _initializeRecorder();
  }

  Future<void> _initializeRecorder() async {
    await _recorder.openRecorder();
    await _recorder.setSubscriptionDuration(const Duration(milliseconds: 50));
  }

  void _startRecording() async {
    setState(() => _isRecording = true);

    // Create a StreamController for audio data
    _audioStreamController = StreamController<Uint8List>();
    TranscribeService transcribe = TranscribeService();
    transcribe.startTranscription(_audioStreamController!.stream);
    /*_audioStreamController!.stream.listen((data) {
      // Convert PCM data from Uint8List to Int16List
      final pcmData = data.buffer.asInt16List();

      // Calculate the maximum amplitude
      final maxAmplitude = pcmData.isNotEmpty
          ? pcmData
              .map((e) => e.abs())
              .reduce((a, b) => a > b ? a : b)
              .toDouble()
          : 0.0;

      setState(() {
        _waveformAmplitudes.add(maxAmplitude / 32767.0); // Normalize
        if (_waveformAmplitudes.length > 100) {
          _waveformAmplitudes.removeAt(0); // Manage waveform length
        }
      });
    });*/

    await _recorder.startRecorder(
      codec: Codec.pcm16,
      numChannels: 1, // Mono audio
      sampleRate: 16000, // Required sample rat
      toStream: _audioStreamController!.sink,
    );
  }

  void _stopRecording() async {
    await _recorder.stopRecorder();
    _audioStreamController?.close();
    setState(() => _isRecording = false);
  }

  @override
  void dispose() {
    _recorder.closeRecorder();
    _audioStreamController?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Real-Time Waveform')),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _isRecording ? null : _startRecording,
                child: const Text('Start Recording'),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: !_isRecording ? null : _stopRecording,
                child: const Text('Stop Recording'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text("hello"),
          Expanded(
            child: Center(
              child: CustomPaint(
                size: const Size(double.infinity, 100),
                painter: WaveformPainter(_waveformAmplitudes),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WaveformPainter extends CustomPainter {
  final List<double> amplitudes;

  WaveformPainter(this.amplitudes);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();
    final waveHeight = size.height / 2;

    for (int i = 0; i < amplitudes.length; i++) {
      final x = i * (size.width / amplitudes.length);
      final y = waveHeight - amplitudes[i] * waveHeight;
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
