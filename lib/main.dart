// ignore_for_file: prefer_function_declarations_over_variables
import 'package:flutter/material.dart';
import 'screens/connection_page.dart';
import 'screens/order_page.dart';
import 'package:inventory/constants.dart';
import 'screens/waiting_page.dart';
import 'screens/inventory_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: kScaffoldBackgroundColor,
      ),
      initialRoute: ConnectionPage.id,
      routes: {
        ConnectionPage.id: (context) => ConnectionPage(),
        OrderPage.id: (context) => OrderPage(),
        WaitingPage.id: (context) => WaitingPage(),
        InventoryPage.id: (context) => InventoryPage(),
      },
    );
  }
}




