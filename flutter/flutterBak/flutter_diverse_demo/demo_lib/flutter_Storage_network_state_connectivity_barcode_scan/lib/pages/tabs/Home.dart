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
            child: Text('检测网络变化'),
            onPressed: () {
              Navigator.pushNamed(context, '/network');
            },
          ),
          SizedBox(height: 20),
          RaisedButton(
            child: Text('本地存储'),
            onPressed: () {
              Navigator.pushNamed(context, '/storage');
            },
          ),
          SizedBox(height: 20),
          RaisedButton(
            child: Text('扫码(条形码，二维码)'),
            onPressed: () {
              Navigator.pushNamed(context, '/scan');
            },
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
