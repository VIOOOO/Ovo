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
            child: Text('Device 获取设备信息页面'),
            onPressed: () {
              Navigator.pushNamed(context, '/device');
            },
          ),
          SizedBox(height: 20),
          RaisedButton(
            child: Text('Location 获取地理定位页面'),
            onPressed: () {
              Navigator.pushNamed(context, '/location');
            },
          ),
          SizedBox(height: 20),
                    RaisedButton(
            child: Text('拍照上传'),
            onPressed: () {
              Navigator.pushNamed(context, '/imagePicker');
            },
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
