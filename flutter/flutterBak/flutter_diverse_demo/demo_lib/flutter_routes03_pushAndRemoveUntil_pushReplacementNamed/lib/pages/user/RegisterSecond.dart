import 'package:flutter/material.dart';

class RegisterSecondPage extends StatefulWidget {
  RegisterSecondPage({Key key}) : super(key: key);

  @override
  _RegisterSecondPageState createState() => _RegisterSecondPageState();
}

class _RegisterSecondPageState extends State<RegisterSecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('注册第二步-验证码'),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 40),
          Text('输入验证码'),
          SizedBox(height: 40),
          RaisedButton(
            child: Text('下一步'),
            onPressed: () {
              // 路由替换
              // 加载第二个页面，替换当前页面，达到加载后的页面返回，可以直接返回上一层的效果
              Navigator.of(context).pushReplacementNamed('/registerThrid');
            },
          )
        ],
      ),
    );
  }
}
