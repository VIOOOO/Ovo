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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('appBar'),
          RaisedButton(
            child: Text('跳转到 appBarDemo'),
            onPressed: () {
              Navigator.pushNamed(context, '/appBarDemo');
            },
          ),
          RaisedButton(
            child: Text('跳转到 tabBarController'),
            onPressed: () {
              Navigator.pushNamed(context, '/tabBarController');
            },
          ),
        ],
      ),
    );
  }
}
