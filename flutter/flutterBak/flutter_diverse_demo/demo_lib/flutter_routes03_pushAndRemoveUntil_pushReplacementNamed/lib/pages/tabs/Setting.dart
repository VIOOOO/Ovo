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
      Column(
        children: <Widget>[
          RaisedButton(
            child: Text('跳转到登陆页面'),
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
          ),
          RaisedButton(
            child: Text('跳转到注册页面'),
            onPressed: () {
              Navigator.pushNamed(context, '/registerFirst');
            },
          ),
        ],
      ),
    ]);
  }
}
