import 'package:flutter/material.dart';

class RegisterFirstPage extends StatefulWidget {
  RegisterFirstPage({Key key}) : super(key: key);

  @override
  _RegisterFirstPageState createState() => _RegisterFirstPageState();
}

class _RegisterFirstPageState extends State<RegisterFirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('注册第一步-输入手机号'),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 40),
          Text('这是注册第一步，请输入您的手机号，然后点击下一步'),
          SizedBox(height: 40),
          RaisedButton(
            child: Text('下一步'),
            onPressed: () {
              // 加载注册第二个页面
              // Navigator.pushNamed(context, '/registerSecond');
              
              // 路由替换
              // 加载第二个页面，替换当前页面，达到加载后的页面返回，可以直接返回上一层的效果
              Navigator.of(context).pushReplacementNamed('/registerSecond');
            },
          ),
        ],
      ),
    );
  }
}
