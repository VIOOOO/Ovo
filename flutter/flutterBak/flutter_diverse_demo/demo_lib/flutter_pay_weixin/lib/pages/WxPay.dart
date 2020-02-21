import 'package:flutter/material.dart';
import 'package:sy_flutter_wechat/sy_flutter_wechat.dart';
import 'dart:convert';
import 'package:dio/dio.dart';

// 微信支付

class WxPay extends StatefulWidget {
  WxPay({Key key}) : super(key: key);

  @override
  _WxPayState createState() => _WxPayState();
}

class _WxPayState extends State<WxPay> {
  // 初始化
  @override
  void initState() {
    super.initState();
    _register();
  }

  _register() async {
    // wxf9909bde17439ac2 是在微信开发平台申请好后的应用 AppID
    bool result = await SyFlutterWechat.register('wxf9909bde17439ac2');
    print(result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('微信支付演示'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text('分享文字'),
              onPressed: () async {
                bool res = await SyFlutterWechat.shareText('hello world',
                    shareType: SyShareType.session);
                print('分享文字：' + res.toString());
              },
            ),
            RaisedButton(
              child: Text('分享图片'),
              onPressed: () async {
                bool res = await SyFlutterWechat.shareImage(
                    'https://avatars0.githubusercontent.com/u/10024776',
                    shareType: SyShareType.timeline);
                print('分享图片：' + res.toString());
              },
            ),
            RaisedButton(
              child: Text('分享网页'),
              onPressed: () async {
                bool res = await SyFlutterWechat.shareWebPage(
                    '标题',
                    '描述',
                    'https://avatars0.githubusercontent.com/u/10024776',
                    'http://www.example.com',
                    shareType: SyShareType.session);
                print('分享网页：' + res.toString());
              },
            ),
            RaisedButton(
              child: Text('微信支付'),
              onPressed: () async {
                var apiUrl = 'http://agent.itying.com/wxpay/';
                var myPayInfo = await Dio().get(apiUrl);
                // 先请求接口拿到签名订单
                Map myInfo = json.decode(myPayInfo.data);
                print(myInfo);

                var payInfo = {
                  "appid": myInfo["appid"].toString(),
                  "partnerid": myInfo["partnerid"].toString(),
                  "prepayid": myInfo["prepayid"].toString(),
                  "package": myInfo["package"].toString(),
                  "noncestr": myInfo["noncestr"].toString(),
                  "timestamp": myInfo["timestamp"].toString(),
                  "sign": myInfo["sign"].toString(),
                };
                SyPayResult payResult =
                    await SyFlutterWechat.pay(SyPayInfo.fromJson(payInfo));

                print(payResult);
              },
            ),
          ],
        ),
      ),
    );
  }
}
