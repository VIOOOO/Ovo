import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';

// 扫码

class ScanPage extends StatefulWidget {
  ScanPage({Key key}) : super(key: key);

  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  String barcode;
  Future _scan() async {
    try {
      // 扫码
      String barcode = await BarcodeScanner.scan();
      // 扫码完成执行setState
      setState(() {
        return this.barcode = barcode;
      });
    } on PlatformException catch (e) {
      // 抛出异常
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        // 扫码 需要获取照相机权限
        setState(() {
          return this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() {
          return this.barcode = 'Unknown error: $e';
        });
      }
    } on FormatException {
      setState(() => this.barcode =
          'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 定义一个浮动按钮
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.photo_camera),
        onPressed: _scan,
      ),
      appBar: AppBar(
        title: Text('扫码'),
      ),
      body: Center(
        child: Text("${this.barcode}"),
      ),
    );
  }
}
