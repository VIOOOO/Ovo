import 'package:flutter/material.dart';
import 'package:sy_flutter_alipay/sy_flutter_alipay.dart';
import 'package:dio/dio.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: '支付演示'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
 _doAliPay() async{

      print("支付宝支付...");
       var serverApi="http://agent.itying.com/alipay/";

      var serverData=await Dio().get(serverApi);
     
      var payInfo=serverData.data;    
      var result = await SyFlutterAlipay.pay(
          payInfo,
          urlScheme: 'flutteralipay', //前面配置的urlScheme
          // isSandbox: true //是否是沙箱环境，只对android有效
      );
      print(result);

   }
  @override
  Widget build(BuildContext context) {
    
   
    return Scaffold(
      appBar: AppBar(        
        title: Text(widget.title),
      ),
      body: Center(
       
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           RaisedButton(
             child: Text('支付宝支付'),
             onPressed: _doAliPay,
           )
          ],
        ),
      ),
     
    );
  }
}
