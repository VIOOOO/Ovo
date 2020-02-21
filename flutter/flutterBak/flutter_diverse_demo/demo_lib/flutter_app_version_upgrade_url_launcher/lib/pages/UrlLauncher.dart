import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// 调用 url_launcher 模块打开外部浏器 打开外部应用 拨打电话 发送短信

class UrlLauncherPage extends StatefulWidget {
  UrlLauncherPage({Key key}) : super(key: key);

  @override
  _UrlLauncherPageState createState() => _UrlLauncherPageState();
}

class _UrlLauncherPageState extends State<UrlLauncherPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('检测网络变化'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: ListView(
            children: <Widget>[
              RaisedButton(
                child: Text("打开外部浏览器"),
                onPressed: () async {
                  const url = 'https://cflutter.com';
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                },
              ),
              SizedBox(height: 10),
              RaisedButton(
                child: Text("拨打电话"),
                onPressed: () async {
                  const tel = 'tel:10086';
                  if (await canLaunch(tel)) {
                    await launch(tel);
                  } else {
                    throw 'Could not launch $tel';
                  }
                },
              ),
              SizedBox(height: 10),
              RaisedButton(
                child: Text("发送短信"),
                onPressed: () async {
                  const tel = 'sms:10086';
                  if (await canLaunch(tel)) {
                    await launch(tel);
                  } else {
                    throw 'Could not launch $tel';
                  }
                },
              ),
              SizedBox(height: 10),
              RaisedButton(
                child: Text("打开外部应用"),
                onPressed: () async{
                  // 需要对应 scheme
                  // 微信 weixin://
                  // 支付宝 alipays://
                  const url = 'weixin://';
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                },
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
