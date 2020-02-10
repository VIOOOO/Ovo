import 'package:flutter/material.dart';
import '../components/MyDialog.dart';

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
            child: Text('Dialog 弹出框演示页'),
            onPressed: () {
              Navigator.pushNamed(context, '/dialog');
            },
          ),
          SizedBox(height: 20),
          RaisedButton(
            child: Text('显示自定义 Dialog'),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return Mydialog(
                    title: '标题',
                    content: '文本',
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
