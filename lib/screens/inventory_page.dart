import 'package:flutter/material.dart';
import 'package:inventory/constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'connection_page.dart' as con_page;

class InventoryPage extends StatefulWidget {
  static String id = 'inventory_page';
  const InventoryPage({Key? key}) : super(key: key);

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  final inputHandler = TextEditingController();
  final storage = const FlutterSecureStorage();
  var redisServer = con_page.redisServer;
  var mysqlServer = con_page.mysqlServer;
  int palletToDisassemble = 0;
  int? disorderNumber = 0;
  String? disorderNumberInString = '';
  String disorder = '';

  List<int> palletFilledList = [
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
  ];

  Padding _makePalletInput(final textController) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: textController,
              decoration: const InputDecoration(
                hintText: 'Enter Pallet number to disassemble!',
                hintStyle: TextStyle(fontSize: 17),
                contentPadding: EdgeInsets.all(10),
              ),
              keyboardType: TextInputType.number,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kAppBarBackgroundColor,
          title: const Text('Inventory Page'),
        ),
        body: Column(
          children: <Widget>[
            // make some void space
            Container(
              margin: const EdgeInsets.only(top: 20),
            ),

            // Grid of pallets
            Expanded(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: ReusablePallet(
                          palletFilledList[0] == 0
                              ? kNotSelectedPallet
                              : kSelectedPallet,
                          '1'),
                    ),
                    Expanded(
                      child: ReusablePallet(
                          palletFilledList[1] == 0
                              ? kNotSelectedPallet
                              : kSelectedPallet,
                          '2'),
                    ),
                    Expanded(
                      child: ReusablePallet(
                          palletFilledList[2] == 0
                              ? kNotSelectedPallet
                              : kSelectedPallet,
                          '3'),
                    ),
                    Expanded(
                      child: ReusablePallet(
                          palletFilledList[3] == 0
                              ? kNotSelectedPallet
                              : kSelectedPallet,
                          '4'),
                    ),
                    Expanded(
                      child: ReusablePallet(
                          palletFilledList[4] == 0
                              ? kNotSelectedPallet
                              : kSelectedPallet,
                          '5'),
                    ),
                  ],
                )),
            Expanded(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: ReusablePallet(
                          palletFilledList[5] == 0
                              ? kNotSelectedPallet
                              : kSelectedPallet,
                          '6'),
                    ),
                    Expanded(
                      child: ReusablePallet(
                          palletFilledList[6] == 0
                              ? kNotSelectedPallet
                              : kSelectedPallet,
                          '7'),
                    ),
                    Expanded(
                      child: ReusablePallet(
                          palletFilledList[7] == 0
                              ? kNotSelectedPallet
                              : kSelectedPallet,
                          '8'),
                    ),
                    Expanded(
                      child: ReusablePallet(
                          palletFilledList[8] == 0
                              ? kNotSelectedPallet
                              : kSelectedPallet,
                          '9'),
                    ),
                    Expanded(
                      child: ReusablePallet(
                          palletFilledList[9] == 0
                              ? kNotSelectedPallet
                              : kSelectedPallet,
                          '10'),
                    ),
                  ],
                )),
            Expanded(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: ReusablePallet(
                          palletFilledList[10] == 0
                              ? kNotSelectedPallet
                              : kSelectedPallet,
                          '11'),
                    ),
                    Expanded(
                      child: ReusablePallet(
                          palletFilledList[11] == 0
                              ? kNotSelectedPallet
                              : kSelectedPallet,
                          '12'),
                    ),
                    Expanded(
                      child: ReusablePallet(
                          palletFilledList[12] == 0
                              ? kNotSelectedPallet
                              : kSelectedPallet,
                          '13'),
                    ),
                    Expanded(
                      child: ReusablePallet(
                          palletFilledList[13] == 0
                              ? kNotSelectedPallet
                              : kSelectedPallet,
                          '14'),
                    ),
                    Expanded(
                      child: ReusablePallet(
                          palletFilledList[14] == 0
                              ? kNotSelectedPallet
                              : kSelectedPallet,
                          '15'),
                    ),
                  ],
                )),
            Expanded(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: ReusablePallet(
                          palletFilledList[15] == 0
                              ? kNotSelectedPallet
                              : kSelectedPallet,
                          '16'),
                    ),
                    Expanded(
                      child: ReusablePallet(
                          palletFilledList[16] == 0
                              ? kNotSelectedPallet
                              : kSelectedPallet,
                          '17'),
                    ),
                    Expanded(
                      child: ReusablePallet(
                          palletFilledList[17] == 0
                              ? kNotSelectedPallet
                              : kSelectedPallet,
                          '18'),
                    ),
                    Expanded(
                      child: ReusablePallet(
                          palletFilledList[18] == 0
                              ? kNotSelectedPallet
                              : kSelectedPallet,
                          '19'),
                    ),
                    Expanded(
                      child: ReusablePallet(
                          palletFilledList[19] == 0
                              ? kNotSelectedPallet
                              : kSelectedPallet,
                          '20'),
                    ),
                  ],
                )),
            Expanded(
                child: Row(
              children: <Widget>[
                Expanded(
                  child: ReusablePallet(
                      palletFilledList[20] == 0
                          ? kNotSelectedPallet
                          : kSelectedPallet,
                      '21'),
                ),
                Expanded(
                  child: ReusablePallet(
                      palletFilledList[21] == 0
                          ? kNotSelectedPallet
                          : kSelectedPallet,
                      '22'),
                ),
                Expanded(
                  child: ReusablePallet(
                      palletFilledList[22] == 0
                          ? kNotSelectedPallet
                          : kSelectedPallet,
                      '23'),
                ),
                Expanded(
                  child: ReusablePallet(
                      palletFilledList[23] == 0
                          ? kNotSelectedPallet
                          : kSelectedPallet,
                      '24'),
                ),
                Expanded(
                  child: ReusablePallet(
                      palletFilledList[24] == 0
                          ? kNotSelectedPallet
                          : kSelectedPallet,
                      '25'),
                ),
              ],
            )),

            // Input pallet box
            _makePalletInput(inputHandler),

            // `Update Warehouse` button
            GestureDetector(
              onTap: () async {
                List<int> willBeUpdatedPallets = await mysqlServer.query(
                    'select * from warehouse;');
                bool hasOutput = false;
                setState(() {
                  for (var position in willBeUpdatedPallets) {
                    hasOutput = true;
                    palletFilledList[position] = 1;
                  }
                });
                if (hasOutput == false) {
                  for (int i = 0; i < 25; i++) {
                    palletFilledList[i] = 0;
                  }
                  Alert(
                    context: context,
                    style: kAlertStyle,
                    title: "Update Error!",
                    desc: "Nothing in warehouse to update.",
                  ).show();
                }
              },
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 35, bottom: 10),
                width: double.infinity,
                height: 60.0,
                decoration: BoxDecoration(
                  color: const Color(0xFFEB1555),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Text(
                  'Update Warehouse',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),

            // `DISASSEMBLE` button
            GestureDetector(
              onTap: () async {
                palletToDisassemble = int.parse(inputHandler.text);
                if (palletFilledList[palletToDisassemble - 1] == 0) {
                  Alert(
                    context: context,
                    style: kAlertStyle,
                    title: "Disassemble Error!",
                    desc: "No pallet in this position.",
                  ).show();
                } else {
                  redisServer.getCommand("disorderNumber");
                  disorderNumberInString = await storage.read(key: 'disorderNumber');
                  disorderNumber = int.tryParse(disorderNumberInString!);
                  disorder = 'disorder:${disorderNumber! + 1}';
                  redisServer.setCommand(disorder, '${palletToDisassemble-1}');
                  redisServer.setCommand("disorderNumber", '${disorderNumber! + 1}');
                  setState(() {
                    palletFilledList[palletToDisassemble - 1] = 0;
                    Navigator.pushNamed(context, 'waiting_page');
                  });
                }
              },
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(bottom: 10),
                width: double.infinity,
                height: 60.0,
                decoration: BoxDecoration(
                  color: const Color(0xFFEB1555),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Text(
                  'DISASSEMBLE',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}

class ReusablePallet extends StatelessWidget {
  ReusablePallet(this.color, this.number);

  final Color color;
  final String number;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: [
          Text(
            number,
            style: kNumberInventoryPage,
          ),
        ],
      ),
    );
  }
}
