import 'package:flutter/material.dart';
import 'package:flutter_app_test/common/Storage.dart';

// 设置页
class SettingPage extends StatefulWidget {
  SettingPage({Key key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Column(
          children: <Widget>[
            RaisedButton(
              child: Text("获取 Storage 保存的数据"),
              onPressed: () async {
                // 使用封装的 Storage 读取数据
                var username = await Storage.getString("username");
                print(username);
              },
            ),
            SizedBox(height: 20),
            RaisedButton(
              child: Text("设置 Storage 保存的数据"),
              onPressed: () async {
                // 使用封装的 Storage 设置数据
                await Storage.setString(
                    "username", "我是 Storage 类里改变的 username");
              },
            ),
          ],
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
        ListTile(
          title: Text('文本'),
        ),
      ],
    );
  }
}
