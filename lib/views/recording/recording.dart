import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:hearu/config/colors.dart';
import 'package:hearu/services/transcribe_api.dart';

class Recording extends StatefulWidget {
  const Recording({super.key});

  @override
  _RecordingState createState() => _RecordingState();
}

class _RecordingState extends State<Recording> {
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  final List<double> _waveformAmplitudes = [];
  StreamController<Uint8List>? _audioStreamController;
  StreamController<String>? _textStreamController; // For transcribed words
  bool _isRecording = false;

  String _transcribedText = ""; // Single string for the text widget
  late StreamSubscription<String> _transcriptionSubscription;

  @override
  void initState() {
    super.initState();
    _initializeRecorder();
  }

  Future<void> _initializeRecorder() async {
    await _recorder.openRecorder();
    await _recorder.setSubscriptionDuration(const Duration(milliseconds: 50));
    // _recorder.logger.close();
  }

  void _startRecording() async {
    setState(() => _isRecording = true);

    // Create a StreamController for audio data
    // Initialize StreamControllers
    _audioStreamController = StreamController<Uint8List>();
    _textStreamController = StreamController<String>();

    // Start transcription
    TranscribeService transcribe = TranscribeService();
    transcribe.startTranscription(
      _audioStreamController!.stream,
      _textStreamController!,
    );
    // Listen to the text stream and update the single Text widget
    _transcriptionSubscription = _textStreamController!.stream.listen((word) {
      setState(() {
        _transcribedText += "$word "; // Append each new word to the string
      });
    });
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
      sampleRate: 48000, // Required sample rat
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
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            TextButton(
              onPressed: _isRecording ? _stopRecording : _startRecording,
              child: Text(_isRecording ? 'Stop Recording' : 'Start Recording',
                  style: const TextStyle(
                      color: AppColors.blueMain,
                      fontWeight: FontWeight.w800,
                      fontSize: 20)),
            ),
            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Text of the note :",
                style: TextStyle(
                    color: AppColors.dark,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: AppColors.blueMain.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: SingleChildScrollView(
                  child: Text(
                    _transcribedText, // Display concatenated text
                    style: const TextStyle(
                      color: AppColors.dark,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: _isRecording
                          ? AppColors.blueMain
                          : AppColors.dark.withOpacity(0.4)),
                  child: const Text("SAVE")),
            ),
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
