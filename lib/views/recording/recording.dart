import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:hearu/bloc/auth_bloc.dart';
import 'package:hearu/bloc/notes_bloc.dart';
import 'package:hearu/config/colors.dart';
import 'package:hearu/model/note.dart';
import 'package:hearu/services/transcribe_api.dart';

class Recording extends StatefulWidget {
  const Recording({super.key});

  @override
  _RecordingState createState() => _RecordingState();
}

class _RecordingState extends State<Recording> {
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  StreamController<Uint8List>? _audioStreamController;
  StreamController<String>? _textStreamController; // For transcribed words
  bool _isRecording = false;

  String _transcribedText = ""; // Single string for the text widget

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
    _audioStreamController = StreamController<Uint8List>();
    _textStreamController = StreamController<String>();
    TranscribeService transcribe = TranscribeService();
    transcribe.startTranscription(
      _audioStreamController!.stream,
      _textStreamController!,
    );
    _textStreamController!.stream.listen((word) {
      setState(() {
        _transcribedText += "$word ";
      });
    });
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
    _textStreamController?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: BlocListener<NotesBloc, NotesState>(
          listener: (context, state) async {
            if (state is NoteSaved) {
              await _showSuccessDialog(context);
            } else if (state is NoteSaved) {
              await _showErrorDialog(context);
            }
          },
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
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.3,
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    color: AppColors.blueMain.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: AppColors.blueMain)),
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
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 3,
                child: ElevatedButton(
                  onPressed: _transcribedText != ""
                      ? () async {
                          await _showNameNoteDialog(context);
                        }
                      : null, // Disable button if _transcribedText is empty
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _transcribedText != ""
                        ? AppColors.blueMain
                        : AppColors.dark.withOpacity(0.4),
                  ),
                  child: const Text("SAVE"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showNameNoteDialog(BuildContext context) async {
    String noteName = ""; // Temporary variable to store the note name
    final TextEditingController nameController = TextEditingController();

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("How would you like to name the note?"),
          content: TextField(
            controller: nameController,
            decoration: const InputDecoration(
              hintText: "Enter note name",
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              noteName = value; // Update note name as user types
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (noteName.trim().isEmpty) {
                  // Show an error if name is empty
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Note name cannot be empty!"),
                    ),
                  );
                  return;
                }
                // Save the note with the provided name
                _saveNote(noteName);
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  void _saveNote(String noteName) {
    // Implement your save logic here, e.g., saving to a database
    BlocProvider.of<NotesBloc>(context).add(SaveNoteEvent(
        Note(
            title: noteName,
            content: _transcribedText,
            audioLength: 0,
            audioPath: ""),
        BlocProvider.of<AuthBloc>(context).authToken!));
    Navigator.of(context).pop(); // Close the dialog
  }

  Future<void> _showSuccessDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            icon: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.cancel)),
            title: const Text("Note saved!"),
            content: const Text("Your note has been saved successfully"));
      },
    );
  }

  Future<void> _showErrorDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            icon: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.cancel)),
            title: const Text("Cannot save the note!"),
            content: const Text(
                "Your note has not been saved. Please retry again!"));
      },
    );
  }
}
