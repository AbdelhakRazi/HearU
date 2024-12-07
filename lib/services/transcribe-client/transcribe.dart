import 'dart:async';
import 'dart:typed_data';

import 'package:aws_common/aws_common.dart';
import 'package:flutter/foundation.dart';
import 'package:hearu/services/aws-transcribe-service/aws_transcribe_streaming.dart';

class Transcribe {
  Future transcribe(Stream<Uint8List> audioStream) async {
    final transcribeStreamingClient = TranscribeStreamingClient(
      region: 'us-east-1',
      // Provide credentials with `transcribe:StartStreamTranscription` permission
      credentialsProvider: StaticCredentialsProvider(AWSCredentials(
        'AKIA2UC26WSC5HW7OKUH', // accessKeyId
        'i45D8zA6yWO4kuLziNgqVl5Le1G0NvnMlQtw1Vh6', // secretAccessKey
        null, //'AQoDYXdzEJr...', // sessionToken
        DateTime.now().add(const Duration(hours: 1)), // expiration
      )),
    );

    late final StartStreamTranscriptionResponse response;
    late final Stream<TranscriptEvent> transcriptEventStream;
    late final StreamSink<Uint8List> audioStreamSink;
    StreamSubscription<Uint8List>? audioStreamSubscription;

    try {
      // Start a stream transcription.
      (response, audioStreamSink, transcriptEventStream) =
          await transcribeStreamingClient.startStreamTranscription(
        const StartStreamTranscriptionRequest(
          languageCode: LanguageCode.enUs,
          mediaSampleRateHertz: 48000,
          mediaEncoding: MediaEncoding.pcm,
        ),
      );
    } on TranscribeStreamingException catch (e) {
      debugPrint('Error starting transcription: $e');
      return;
    }

    debugPrint('Session ID: ${response.sessionId}');

    final transcriptionCompleter = Completer<void>();

    // Listen to transcript events.
    // final transcriptSubscription =
    //     transcriptEventStream.listen((TranscriptEvent event) => print(event));
    // or use a custom strategy to decode transcript events.
    transcriptEventStream
        .transform(const TranscriptEventStreamDecoder(
            PlainTextTranscriptionStrategy()))
        .listen(
      (String message) {
        print('Transcription: $message');
      },
      onError: (Object error, StackTrace stackTrace) async {
        print('Transcription error: $error');
        await audioStreamSubscription?.cancel();
        await audioStreamSink.close();
      },
      onDone: () async {
        print('Transcription done');
        await audioStreamSubscription?.cancel();
        transcriptionCompleter.complete();
      },
    );

    // Instead use a real stream of audio data from the microphone
    // in PCM signed 16-bit little-endian audio format with 48kHz sample rate.

    // Send audio data to the audio stream sink.
    audioStreamSubscription = audioStream.listen(
      audioStreamSink.add,
      onDone: audioStreamSink.close,
    );

    await transcriptionCompleter.future;

    print('Finished');
  }
}
