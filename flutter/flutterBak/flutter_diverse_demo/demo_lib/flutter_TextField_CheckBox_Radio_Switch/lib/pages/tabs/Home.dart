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
            child: Text('按钮演示页面'),
            onPressed: () {
              Navigator.pushNamed(context, '/button');
            },
          ),
          SizedBox(height: 20),
          RaisedButton(
            child: Text('表单输入框演示页面'),
            onPressed: () {
              Navigator.pushNamed(context, '/textField');
            },
          ),
          SizedBox(height: 20),
          RaisedButton(
            child: Text('CheckBox 多选框组件'),
            onPressed: () {
              Navigator.pushNamed(context, '/checkBox');
            },
          ),
          SizedBox(height: 20),
          RaisedButton(
            child: Text('RadioDemo 单选按钮 Switch 开关'),
            onPressed: () {
              Navigator.pushNamed(context, '/radio');
            },
          ),
          SizedBox(height: 20),
          RaisedButton(
            child: Text('表单综合案例 登记表'),
            onPressed: () {
              Navigator.pushNamed(context, '/form');
            },
          ),
        ],
      ),
    );
  }
}
