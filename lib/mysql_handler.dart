import 'package:mysql1/mysql1.dart';

class MysqlHandler {
  String server = '';
  int port = 3306;
  String user = "super";
  String password = 'password';
  var settings;
  var conn;
  var pool;

  MysqlHandler({server}) {
    this.server = server;
  }

  Future<void> makeConnection() async {
    // print("Server: $server");
    settings = ConnectionSettings(
      host: server,
      port: port,
      user: user,
      password: password,
      db: 'IUT',
    );
    conn = await MySqlConnection.connect(settings);
  }

  Future<List<int>> query(String command) async {
    List<int> palletFilledList = [];
    var results = await conn.query(command);
    for (var row in results) {
      palletFilledList.add(row[0]);
    }
    return palletFilledList;
  }
}
