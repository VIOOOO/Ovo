import 'package:flutter/material.dart';

// 设置页
class SettingPage extends StatefulWidget {
  SettingPage({Key key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
      ListTile(
        title: Text('文本'),
      ),
      ListTile(
        title: Text('文本'),
      ),
      ListTile(
        title: Text('文本'),
      ),
      ListTile(
        title: Text('文本'),
      ),
      ListTile(
        title: Text('文本'),
      ),
    ]);
  }
}
