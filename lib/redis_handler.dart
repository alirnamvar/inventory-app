import 'package:redis/redis.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class RedisHandler {
  String server = '';
  int port = 0;
  bool connectionStatus = false;
  final conn = RedisConnection();

  // Create storage
  final storage = FlutterSecureStorage();

  RedisHandler({server, port}) {
    this.server = server;
    this.port = port;
  }

  Future<void> makeConnection() async {
    await conn.connect(server, port).then((Command command) {
      command.send_object(["ping"]).then((var response) => {
            if (response.toString() == "PONG")
              {
                connectionStatus = true,
              }
            else
              connectionStatus = false,
          });
    });
  }

  Future<void> getCommand(String key) async {
    conn.connect(server, port).then((Command command) {
      command.send_object(["GET", key]).then((var response) async {
        // print("GET::key:$key, value:$response");
        await storage.write(key: key, value: response);
      });
    });
  }

  void setCommand(String key, String value) {
    conn.connect(server, port).then((Command command) {
      command.send_object(["SET", key, value]).then((var response) {
        // print("SET::key:$key, value:$value");
        assert(response == 'OK');
      });
    });
  }

  void close() {
    conn.close();
  }
}
