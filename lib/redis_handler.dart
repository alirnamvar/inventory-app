import 'package:redis/redis.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
            // print('#### Connection status: $response ####'),
            if (response.toString() == "PONG")
              {
                connectionStatus = true,
              }
            else
              connectionStatus = false,
            // print(
            //     'RedisHandler.makeConnection():: connectionStatus: $connectionStatus'),
          });
    });
  }

  Future<void> getCommand(String key) async {
    conn.connect(server, port).then((Command command) {
      // print('in connect with $key');
      command.send_object(["GET", key]).then((var response) async {
        // print("$key get $response");
        await storage.write(key: key, value: response);
      });
    });
  }

  void setCommand(String key, String value) {
    conn.connect(server, port).then((Command command) {
      command.send_object(["SET", key, value]).then((var response) {
        assert(response == 'OK');
        // print(
        //     'RedisHandler.setCommand(key: $key, value: $value):: Response: $response, connectionStatus: $connectionStatus')
      });
    });
  }

  void close() {
    // print('Closing redis');
    conn.close();
  }
}
