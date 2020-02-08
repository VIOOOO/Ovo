import 'package:flutter/material.dart';

// 首页
class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            child: Text('跳转到日期演示页面'),
            onPressed: () {
              Navigator.pushNamed(context, '/datePicker');
            },
          ),
          SizedBox(height: 20),
          RaisedButton(
            child: Text('第三方日期插件使用'),
            onPressed: () {
              Navigator.pushNamed(context, '/datePickerPub');
            },
          ),
        ],
      ),
    );
  }
}
