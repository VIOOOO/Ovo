import 'package:flutter/material.dart';

import 'package:device_info/device_info.dart';

// 获取设备信息
class DevicePage extends StatefulWidget {
  DevicePage({Key key}) : super(key: key);

  @override
  _DevicePageState createState() => _DevicePageState();
}

class _DevicePageState extends State<DevicePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._getDevice();
  }

  _getDevice() async {
    // android 获取设备信息
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    print('Running on ${androidInfo.androidId}'); // e.g. "Moto G (4)"

    // // ios 获取设备信息
    // IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    // print('Running on ${iosInfo.utsname.machine}'); // e.g. "iPod7,1"
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('flutter Native Device 设备信息演示'),
        ),
        body: Text("设备信息演示"));
  }
}
