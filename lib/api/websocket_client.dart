import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/io.dart';

/* REFERENCE SHIT
final headers = {
  'Cookie':
      'puffer_auth=eyJhbGciOiJFUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxIiwiYXVkIjpbInNlc3Npb24iXSwiZXhwIjoxNjc5NzY5Njc3LCJpYXQiOjE2Nzk3NjYwNzcsInB1ZmZlcnBhbmVsIjp7fX0.nZWeYRdhAu1kW3LesvEofmm5ibPaaP9UIRikw8Wf6c0dAx5NCEu9PoQgBiuhm23ddcQ3z55Tl3vGPRcAgh2AGw'
};

void main() async {
  final channel = IOWebSocketChannel.connect(
    'wss://mc.chromium.hu/proxy/daemon/socket/8b01b3e5',
    headers: headers,
  );

  channel.stream.listen((message) {
    print('Received message: $message');
  });

  channel.sink.add('{"type":"stat"}');
}
*/

class PufferPanelWebSocketClient {
  late IOWebSocketChannel channel;
  late String _instance;
  late String _accessToken;

  PufferPanelWebSocketClient();

  void init({required instance, required accesstoken}) {
    _instance = instance;
    _accessToken = accesstoken;
  }

  void connect(String serverId) {
    channel = IOWebSocketChannel.connect(
      "$_instance/proxy/daemon/socket/$serverId"
          .replaceAll("https://", "wss://"),
      headers: {
        'Cookie': 'puffer_auth=$_accessToken',
      },
    );

    channel.sink.add('{"type":"replay","since":0}');
    channel.sink.add('{"type":"file","action":"get","path":"/"}');
  }
}

class PufferPanelWebSocketClientState extends ChangeNotifier {
  final PufferPanelWebSocketClient _client = PufferPanelWebSocketClient();
  PufferPanelWebSocketClient get client => _client;
}
