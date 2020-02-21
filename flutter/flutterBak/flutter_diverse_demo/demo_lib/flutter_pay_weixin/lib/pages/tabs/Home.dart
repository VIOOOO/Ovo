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
            child: Text('支付宝支付'),
            onPressed: () {
              Navigator.pushNamed(context, '/alipay');
            },
          ),
          SizedBox(height: 20),
          RaisedButton(
            child: Text('微信支付'),
            onPressed: () {
              Navigator.pushNamed(context, '/wxPay');
            },
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
