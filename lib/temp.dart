import 'package:redis/redis.dart';

void main() {
  final conn = RedisConnection();
  conn.connect('192.168.122.1', 6379).then((Command command) {
    command.send_object(["SET", "key", "0"]).then((var response) {
      assert(response == 'OK');
      return command.send_object(["INCR", "key"]);
    }).then((var response) {
      assert(response == 1);
      return command.send_object(["INCR", "key"]);
    }).then((var response) {
      assert(response == 2);
      return command.send_object(["INCR", "key"]);
    }).then((var response) {
      assert(response == 3);
      return command.send_object(["GET", "key"]);
    }).then((var response) {
      return print(response); // 3
    });
  });
}
