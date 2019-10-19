import 'package:anweshan_pass_scanner/pages/scan_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(Scanner());

class Scanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pass Scanner',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: Scaffold(
        body: ScanPage(),
      ),
    );
  }
}
