import 'package:anweshan_pass_scanner/pages/display.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ScanPage extends StatefulWidget {
  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        padding: EdgeInsets.all(20),
        textColor: Colors.white,
        color: Theme.of(context).primaryColor,
        child: Text('Scan Pass', style: TextStyle(fontSize: 30,),),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        onPressed: () => scan(context),
      ),
    );
  }

  Future scan(BuildContext context) async {
    try {
      String barcode = await FlutterBarcodeScanner.scanBarcode(
          '#0000ff', 'Cancel', true, ScanMode.QR);
      if (barcode != '-1')
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => Display(
              pass: barcode,
            ),
          ),
        );
      print(barcode);
    } on PlatformException {
      showSnackBar('Unknown Error!', context);
    }
  }

  void showSnackBar(String content, BuildContext context) {
    Scaffold.of(context).removeCurrentSnackBar();
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
      ),
    );
  }
}
