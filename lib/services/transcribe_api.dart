import 'dart:io';
import 'dart:typed_data';
import 'package:aws_common/aws_common.dart';
import 'package:aws_signature_v4/aws_signature_v4.dart';
import 'package:hearu/services/aws-transcribe-service/src/event_stream/message_signer.dart';
import 'package:hearu/services/aws-transcribe-service/src/protocol.dart';
import 'package:http2/http2.dart';

class TranscribeService {
  late EventStreamMessageSigner messageSigner;
  Future<Map<String, String>> _generateAwsHeaders() async {
    final credentials = StaticCredentialsProvider(AWSCredentials(
      'AKIA2UC26WSC5HW7OKUH', // accessKeyId
      'i45D8zA6yWO4kuLziNgqVl5Le1G0NvnMlQtw1Vh6', // secretAccessKey
      null, //'AQoDYXdzEJr...', // sessionToken
      DateTime.now().add(const Duration(hours: 1)), // expiration
    ));
    final request = AWSStreamedHttpRequest(
      method: AWSHttpMethod.post,
      uri: Uri.https('transcribestreaming.us-east-1.amazonaws.com',
          '/stream-transcription'),
      headers: {
        'Content-type': 'application/vnd.amazon.eventstream',
        'X-Amz-Target':
            'com.amazonaws.transcribe.Transcribe.StartStreamTranscription',
      },
    );
    final credentialScope = AWSCredentialScope(
      region: 'us-east-1',
      service: AWSService.transcribeStreaming,
    );

    final signer = AWSSigV4Signer(credentialsProvider: credentials);
    final signedRequest =
        await signer.sign(request, credentialScope: credentialScope);
    messageSigner = await EventStreamMessageSigner.create(
      region: 'us-east-1',
      signer: signer,
      priorSignature: signedRequest.signature,
    );
    return signedRequest.headers
      ..addAll({
        'x-amzn-transcribe-language-code': 'en-US',
        'x-amzn-transcribe-sample-rate': '16000',
        'x-amzn-transcribe-media-encoding': 'pcm'
      });
  }

  Future<void> startTranscription(Stream<Uint8List> audioStream) async {
    final headers = await _generateAwsHeaders();
    final socket = await SecureSocket.connect(
      'transcribestreaming.us-east-1.amazonaws.com',
      443,
      supportedProtocols: ['h2'],
    );
    final transport = ClientTransportConnection.viaSocket(socket);
    final stream = transport.makeRequest([
      Header.ascii(':method', 'POST'),
      Header.ascii(':path', '/stream-transcription'),
      Header.ascii(':scheme', 'https'),
      ...headers
          .map((String key, String value) =>
              MapEntry(key, Header.ascii(key, value)))
          .values
    ]);
    stream.incomingMessages.listen((message) {
      print("receiving");
      if (message is HeadersStreamMessage) {
        message.headers.forEach((header) {
          print(header.toString());
        });
      } else if (message is DataStreamMessage) {
        // Handle incoming transcription data
        print('Transcription: ${String.fromCharCodes(message.bytes)}');
      }
    });
    audioStream
        .transform(AudioDataChunker(6400))
        .transform(const AudioEventEncoder())
        .transform(const EventStreamEncoder())
        .transform(AudioMessageSigner(messageSigner))
        .transform(const EventStreamEncoder())
        .transform(const DataStreamMessageEncoder())
        .listen(stream.outgoingMessages.add);
    /*audioStream.listen((data) {
      print("sending");
      stream.outgoingMessages.add(DataStreamMessage(data));
    });*/
    //stream.outgoingMessages.add(DataStreamMessage(buffer.cast<Int16List>()));
  }
}
