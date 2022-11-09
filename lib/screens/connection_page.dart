import 'package:flutter/material.dart';
import '../redis_handler.dart';
import '../mysql_handler.dart';
import 'package:inventory/constants.dart';

var redisServer;
var mysqlServer;

class ConnectionPage extends StatefulWidget {
  static String id = 'connection_page';
  const ConnectionPage({Key? key}) : super(key: key);

  @override
  State<ConnectionPage> createState() => _ConnectionPageState();
}

class _ConnectionPageState extends State<ConnectionPage> {
  final serverHandler = TextEditingController();
  final portHandler = TextEditingController();

  var _orderPageButtonOnPressed = null;
  var _inventoryPageButtonOnPressed = null;
  var _disconnectButtonOnPressed = null;
  String connectionStatusToShow = 'Disconnect!';

  String? _server;
  int? _port;

  Padding _rowTextInput(String text, final textController) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Text(
              '$text: ',
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: TextField(
              controller: textController,
              decoration: const InputDecoration(),
            ),
          ),
        ],
      ),
    );
  }

  void _disconnectButtonFunction() {
    redisServer.close();

    setState(() {
      _orderPageButtonOnPressed = null;
      _disconnectButtonOnPressed = null;
      _inventoryPageButtonOnPressed = null;
      connectionStatusToShow = 'Disconnected from $_server!';
    });
  }

  void _setServerAndPort() {
    _server = serverHandler.text;
    _port = int.parse(portHandler.text);

    redisServer = RedisHandler(server: _server, port: _port);
    redisServer.makeConnection();
    mysqlServer = MysqlHandler(server: _server);
    mysqlServer.makeConnection();

    Future.delayed(
        const Duration(milliseconds: 500),
        () => {
              setState(() {
                if (redisServer.connectionStatus == true) {
                  connectionStatusToShow = 'Connected to $_server:$_port';
                  _orderPageButtonOnPressed = () {
                    Navigator.pushNamed(context, 'order_page');
                  };
                  _inventoryPageButtonOnPressed = () {
                    Navigator.pushNamed(context, 'inventory_page');
                  };
                  _disconnectButtonOnPressed = _disconnectButtonFunction;
                } else {
                  connectionStatusToShow = 'Disconnected!';
                  _orderPageButtonOnPressed = null;
                  _disconnectButtonOnPressed = null;
                }
              })
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kAppBarBackgroundColor,
        title: const Text('Connection Page'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          // make Server and Port
          Column(
            children: [
              _rowTextInput('Server', serverHandler),
              _rowTextInput('Port', portHandler),
            ],
          ),
          // Connect and Disconnect button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: kElevatedButtonPrimaryColor,
                ),
                onPressed: _setServerAndPort,
                child: const Text('Connect'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: kElevatedButtonPrimaryColor,
                ),
                onPressed: _disconnectButtonOnPressed,
                child: const Text('Disconnect'),
              ),
            ],
          ),

          // const SizedBox(height: 30),
          Text(connectionStatusToShow),

          // Two down button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: kElevatedButtonPrimaryColor,
                ),
                onPressed: _orderPageButtonOnPressed,
                child: const Text('Order Page'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: kElevatedButtonPrimaryColor,
                ),
                onPressed: _inventoryPageButtonOnPressed,
                child: const Text('Inventory Page'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
