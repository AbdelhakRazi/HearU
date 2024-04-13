import 'package:hearu/services/transcription/transcription_service.dart';
import 'package:injectable/injectable.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class AmazonTranscriptionService extends TranscriptionService {
  late WebSocketChannel webSocketChannel;
  @override
  Future<String> realTimeTranscribeText() {
    throw UnimplementedError();
  }

  AmazonTranscriptionService() {
    print("amazon called");
  }

  Future<WebSocketChannel> connectWebSocketChannel() async {
    webSocketChannel = WebSocketChannel.connect(
      Uri.parse(
          '''wss://transcribestreaming.us-west-2.amazonaws.com:8443/stream-transcription-websocket?
&X-Amz-Algorithm=AWS4-HMAC-SHA256
&X-Amz-Credential=AKIA2UC26WSC565XU5U3
&X-Amz-Expires=300&language-code=en-US&media-encoding=flac&sample-rate=16000'''),
    );
    print(webSocketChannel.ready);
    print("websocket is ready:" + webSocketChannel.toString());
    return webSocketChannel;
  }

  @disposeMethod
  void dispose() {
    webSocketChannel.sink.close();
  }
}
