import 'package:flutter/material.dart';
import '../Tabs.dart';

class RegisterThridPage extends StatefulWidget {
  RegisterThridPage({Key key}) : super(key: key);

  @override
  _RegisterThridPageState createState() => _RegisterThridPageState();
}

class _RegisterThridPageState extends State<RegisterThridPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('注册第三步-完成注册'),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 40),
          Text('输入密码完成注册'),
          RaisedButton(
            child: Text('确定'),
            onPressed: () {
              // 返回根路由 另一种方法 指定跳转到 Tabs ,指定页码 
              Navigator.of(context).pushAndRemoveUntil(
                new MaterialPageRoute(builder: (context) => new Tabs(index: 2,)),
                (route) => route == null,
              );


              // // 返回根路由 另一种方法 指定跳转到 Tabs 页面
              // Navigator.of(context).pushAndRemoveUntil(
              //   new MaterialPageRoute(builder: (context) => new Tabs()),
              //   (route) => route == null,
              // );

              // 普通返回 可以与替换路由配合 可以直接返回到根
              // Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }
}
