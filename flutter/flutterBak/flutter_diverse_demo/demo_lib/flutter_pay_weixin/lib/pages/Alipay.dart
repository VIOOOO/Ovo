import 'package:flutter/material.dart';
import 'package:sy_flutter_alipay/sy_flutter_alipay.dart';
import 'package:dio/dio.dart';

// 支付宝支付

class AliPay extends StatefulWidget {
  AliPay({Key key}) : super(key: key);

  @override
  _AliPayState createState() => _AliPayState();
}

class _AliPayState extends State<AliPay> {
  // 执行支付宝支付
  _doAliPay() async {
    // 传入支付相关信息 生成签名订单
    var serverApi = "http://agent.itying.com/alipay/XXXX";

    var serverData = await Dio().get(serverApi);
    // // 查看接口数据
    // print(serverData.data);

    // 根据接口返回的签名订单信息 进行支付
    // const payInfo = "从服务端获取的支付参数"; // 签名后的订单信息
    var payInfo = serverData.data;
    var result = await SyFlutterAlipay.pay(
      payInfo,
      // urlScheme: '你的ios urlScheme', //前面配置的urlScheme
      // isSandbox: true, //是否是沙箱环境，只对android有效 目前正是环境不需要该配置
    );
    print(result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AliPay 支付宝支付'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text("支付宝支付"),
              onPressed: _doAliPay,
            ),
          ],
        ),
      ),
    );
  }
}
