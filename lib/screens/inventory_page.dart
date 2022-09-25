import 'package:flutter/material.dart';
import 'package:inventory/constants.dart';
import 'package:inventory/constants.dart';

class InventoryPage extends StatefulWidget {
  static String id = 'inventory_page';
  const InventoryPage({Key? key}) : super(key: key);

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
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
              margin: EdgeInsets.only(top: 50),
            ),

            // Grid of pallets
            Expanded(
                child: Row(
              children: <Widget>[
                Expanded(
                  child: ReusablePallet(kPalletNotSelected),
                ),
                Expanded(
                  child: ReusablePallet(kPalletNotSelected),
                ),
                Expanded(
                  child: ReusablePallet(kPalletNotSelected),
                ),
                Expanded(
                  child: ReusablePallet(kPalletNotSelected),
                ),
                Expanded(
                  child: ReusablePallet(kPalletNotSelected),
                ),
              ],
            )),
            Expanded(
                child: Row(
              children: <Widget>[
                Expanded(
                  child: ReusablePallet(kPalletNotSelected),
                ),
                Expanded(
                  child: ReusablePallet(kPalletNotSelected),
                ),
                Expanded(
                  child: ReusablePallet(kPalletNotSelected),
                ),
                Expanded(
                  child: ReusablePallet(kPalletNotSelected),
                ),
                Expanded(
                  child: ReusablePallet(kPalletNotSelected),
                ),
              ],
            )),
            Expanded(
                child: Row(
              children: <Widget>[
                Expanded(
                  child: ReusablePallet(kPalletNotSelected),
                ),
                Expanded(
                  child: ReusablePallet(kPalletNotSelected),
                ),
                Expanded(
                  child: ReusablePallet(kPalletNotSelected),
                ),
                Expanded(
                  child: ReusablePallet(kPalletNotSelected),
                ),
                Expanded(
                  child: ReusablePallet(kPalletNotSelected),
                ),
              ],
            )),
            Expanded(
                child: Row(
              children: <Widget>[
                Expanded(
                  child: ReusablePallet(kPalletNotSelected),
                ),
                Expanded(
                  child: ReusablePallet(kPalletNotSelected),
                ),
                Expanded(
                  child: ReusablePallet(kPalletNotSelected),
                ),
                Expanded(
                  child: ReusablePallet(kPalletNotSelected),
                ),
                Expanded(
                  child: ReusablePallet(kPalletNotSelected),
                ),
              ],
            )),
            Expanded(
                child: Row(
              children: <Widget>[
                Expanded(
                  child: ReusablePallet(kPalletNotSelected),
                ),
                Expanded(
                  child: ReusablePallet(kPalletNotSelected),
                ),
                Expanded(
                  child: ReusablePallet(kPalletNotSelected),
                ),
                Expanded(
                  child: ReusablePallet(kPalletNotSelected),
                ),
                Expanded(
                  child: ReusablePallet(kPalletNotSelected),
                ),
              ],
            )),

            // Disassemble button
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 100),
              width: double.infinity,
              height: 60.0,
              decoration: BoxDecoration(
                color: const Color(0xFFEB1555),
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Text(
                'DISASSAMBLE',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Clear button
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 20, bottom: 20),
              width: double.infinity,
              height: 60.0,
              decoration: BoxDecoration(
                color: const Color(0xFFEB1555),
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Text(
                'Clear pallet',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ));
  }
}

class ReusablePallet extends StatelessWidget {
  ReusablePallet(@required this.color);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}
