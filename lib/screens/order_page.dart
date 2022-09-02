import 'dart:async';

import 'package:flutter/material.dart';
import 'package:inventory/constants.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'connection_page.dart' as con_page;

class OrderPage extends StatefulWidget {
  static String id = 'order_page';
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final storage = const FlutterSecureStorage();

  final redHandler = TextEditingController();
  final greenHandler = TextEditingController();
  final blueHandler = TextEditingController();
  final whiteHandler = TextEditingController();
  var redisServer = con_page.redisServer;

  int redRawMaterialOrder = 0;
  int greenRawMaterialOrder = 0;
  int blueRawMaterialOrder = 0;
  int whiteRawMaterialOrder = 0;
  int sumOfRawMaterials = 0;

  int redRawMaterialInventory = 0;
  int greenRawMaterialInventory = 0;
  int blueRawMaterialInventory = 0;
  int whiteRawMaterialInventory = 0;

  String? orderNumberInServer;

  List<String?> inventoryList = ['', '', '', ''];

  bool makeOrderEver = false;
  bool everCheckOrder = false;
  bool everFetchInventory = false;

  var _makeOrderOnPress = null;

  List<String> colorsList = ['red', 'green', 'blue', 'white'];

  String storeRoomStatusText = 'Click fetch button to see inventory...';

  dynamic _checkOrderButtonFunction() async {
    if (redHandler.text == '' ||
        greenHandler.text == '' ||
        blueHandler.text == '' ||
        whiteHandler.text == '') {
      setState(() {
        _makeOrderOnPress = null;
      });
      return _onBasicAlertPressed(context,
          text: "At least one of the inputs is empty.", title: "Order Error");
    }

    _castInputMaterialsToInteger();
    if (sumOfRawMaterials > 4) {
      setState(() {
        _makeOrderOnPress = null;
      });
      return _onBasicAlertPressed(context,
          text:
              "Sum of input raw materials are more than 4.\nPlease choose less.",
          title: "Order Error");
    }
    if (sumOfRawMaterials == 0) {
      setState(() {
        _makeOrderOnPress = null;
      });
      return _onBasicAlertPressed(context,
          text:
          "Choose some materials.",
          title: "Empty Order!");
    }


    if (everFetchInventory == false) {
      setState(() {
        _makeOrderOnPress = null;
      });
      return _onBasicAlertPressed(context,
          text: "Never get inventory data.\nPress Fetch button.",
          title: "Fetch inventory Error");
    }
    _syncLocalDataToServer();
    if (possibleMakeOrder()) {
      setState(() {
        _makeOrderOnPress = _makeOrderFunction;
      });
      return _onBasicAlertPressed(context,
          text: "Everything is Ok.\nNow can make order.", title: "Make Order!");
    } else {
      setState(() {
        _makeOrderOnPress = null;
      });
      return _onBasicAlertPressed(context,
          text: "Not enough material for making this order!",
          title: "Make order Error");
    }
  }

  void _makeOrderFunction() {
    makeOrderEver = true;
    _saveOrderToServer();
    Navigator.pushNamed(context, 'waiting_page');
  }

  void _saveOrderToServer() async {
    int finalToServer = 0;
    finalToServer = 1000 * redRawMaterialOrder +
        100 * greenRawMaterialOrder +
        10 * blueRawMaterialOrder +
        1 * whiteRawMaterialOrder;
    // print('${int.parse(orderNumberInServer!) + 1}');
    redisServer.setCommand('order:${int.parse(orderNumberInServer!) + 1}',
        finalToServer.toString());
    await Future.delayed(const Duration(milliseconds: 2000));
    redisServer.setCommand(
        'orderNumber', '${int.parse(orderNumberInServer!) + 1}');
  }

  bool possibleMakeOrder() {
    if (redRawMaterialInventory >= redRawMaterialOrder &&
        greenRawMaterialInventory >= greenRawMaterialOrder &&
        blueRawMaterialInventory >= blueRawMaterialOrder &&
        whiteRawMaterialInventory >= whiteRawMaterialOrder) {
      return true;
    } else {
      return false;
    }
  }

  void _fetchInventoryFunction() async {
    everFetchInventory = true;
    _syncLocalDataToServer();
    await Future.delayed(const Duration(milliseconds: 2000));
    setState(() {
      _makeOrderOnPress = null;
      storeRoomStatusText = 'Red: $redRawMaterialInventory\n'
          'Green: $greenRawMaterialInventory\n'
          'Blue: $blueRawMaterialInventory\n'
          'White: $whiteRawMaterialInventory\n\n'
          'Order number: ${int.parse(orderNumberInServer!) + 1}';
    });
  }

  void _syncLocalDataToServer() async {
    int index = 0;
    String? value;
    for (String color in colorsList) {
      await redisServer.getCommand(color);
      await Future.delayed(const Duration(milliseconds: 300));
      value = await storage.read(key: color);
      inventoryList[index] = value;
      index++;
      // print('$color: $value');
    }
    await redisServer.getCommand('orderNumber');
    await Future.delayed(const Duration(milliseconds: 300));
    // redRawMaterialInventory = await storage.read(key: color);
    orderNumberInServer = await storage.read(key: 'orderNumber');
    _updateRawMaterialInventory();
    // print('inventoryList: $inventoryList');
    // print('orderNumberInServer: $orderNumberInServer');
  }

  void _updateRawMaterialInventory() {
    redRawMaterialInventory = int.parse(inventoryList[0]!);
    greenRawMaterialInventory = int.parse(inventoryList[1]!);
    blueRawMaterialInventory = int.parse(inventoryList[2]!);
    whiteRawMaterialInventory = int.parse(inventoryList[3]!);
    // print('redRawMaterialInventory: $redRawMaterialInventory\n'
    //     'greenRawMaterialInventory: $greenRawMaterialInventory\n'
    //     'blueRawMaterialInventory: $blueRawMaterialInventory\n'
    //     'whiteRawMaterialInventory: $whiteRawMaterialInventory\n');
  }

  void _castInputMaterialsToInteger() {
    redRawMaterialOrder = int.parse(redHandler.text);
    greenRawMaterialOrder = int.parse(greenHandler.text);
    blueRawMaterialOrder = int.parse(blueHandler.text);
    whiteRawMaterialOrder = int.parse(whiteHandler.text);
    sumOfRawMaterials = redRawMaterialOrder +
        greenRawMaterialOrder +
        blueRawMaterialOrder +
        whiteRawMaterialOrder;
  }

  // The easiest way for creating RFlutter Alert
  _onBasicAlertPressed(context, {text, title}) {
    Alert(
      context: context,
      style: kAlertStyle,
      title: title,
      desc: "$text",
    ).show();
  }

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
              keyboardType: TextInputType.number,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // String inventoryUpdatedText = 'Haa';
    // String storeRoomStatusText = everFetchInventory == false
    //     ? 'Click fetch button to see inventory...'
    //     : inventoryUpdatedText;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: kAppBarBackgroundColor,
        title: const Text('Order Page'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              // choose material text
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFF111328),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    'Choose your raw materials',
                    style: TextStyle(
                      color: Color(0xFFc5cae9),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              // 4 color inputs
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    _rowTextInput('Red', redHandler),
                    _rowTextInput('Green', greenHandler),
                    _rowTextInput('Blue', blueHandler),
                    _rowTextInput('White', whiteHandler),
                  ],
                ),
              ),

              // Middle buttons
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: kElevatedButtonPrimaryColor,
                      ),
                      onPressed: _checkOrderButtonFunction,
                      child: const Text('Check order', style: kButtonTextStyle),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: kElevatedButtonPrimaryColor,
                      ),
                      onPressed: _fetchInventoryFunction,
                      child: const Text('Fetch inventory',
                          style: kButtonTextStyle),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: kElevatedButtonPrimaryColor,
                      ),
                      onPressed: _makeOrderOnPress,
                      child: const Text('Make order', style: kButtonTextStyle),
                    ),
                  ],
                ),
              ),

              // Store room text
              Container(
                padding: const EdgeInsets.all(10.0),
                margin: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: const Color(0xFF111328),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Store room status',
                  style: TextStyle(
                    color: Color(0xFFc5cae9),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // store room status text
              Container(
                padding: const EdgeInsets.all(15.0),
                margin: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: const Color(0xFF111328),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  storeRoomStatusText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          // Connection page button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: kElevatedButtonPrimaryColor,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Connection page', style: kButtonTextStyle),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
