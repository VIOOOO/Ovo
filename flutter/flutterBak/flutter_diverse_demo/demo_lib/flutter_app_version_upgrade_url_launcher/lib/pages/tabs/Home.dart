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
            child: Text('appVersion APP更新'),
            onPressed: () {
              Navigator.pushNamed(context, '/appVersion');
            },
          ),
          SizedBox(height: 20),
          RaisedButton(
            child: Text('UrlLauncher 打开外部应用'),
            onPressed: () {
              Navigator.pushNamed(context, '/urlLauncher');
            },
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
