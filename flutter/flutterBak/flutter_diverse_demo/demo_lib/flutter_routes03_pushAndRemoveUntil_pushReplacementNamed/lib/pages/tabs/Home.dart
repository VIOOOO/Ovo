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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RaisedButton(
          child: Text('跳转到搜索页'),
          onPressed: () {
            // 命名路由跳转 并传值
            Navigator.pushNamed(context, '/search',arguments:{
              "id":123
            });
          },
          color: Theme.of(context).accentColor,
          textTheme: ButtonTextTheme.primary,
        ),
        SizedBox(height: 20),
        RaisedButton(
          child: Text('跳转到商品页面'),
          onPressed: () {
            Navigator.pushNamed(context, '/product');
          },
        ),
      ],
    );
  }
}
