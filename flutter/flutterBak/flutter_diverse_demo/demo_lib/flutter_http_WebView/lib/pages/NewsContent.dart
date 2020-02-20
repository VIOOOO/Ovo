import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class NewsContent extends StatefulWidget {
  Map arguments;
  NewsContent({Key key, this.arguments}) : super(key: key);

  @override
  _NewsContentState createState() => _NewsContentState(this.arguments);
}

class _NewsContentState extends State<NewsContent> {
  Map arguments;
  // loading 显示
  bool _flag = true;
  _NewsContentState(this.arguments);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('新闻详情'),
      ),
      body: Column(
        children: <Widget>[
          // loading
          this._flag ? _getMoreWidget() : Text(''),
          Expanded(
            child: InAppWebView(
              // 打开详情页地址
              initialUrl:
                  "http://www.phonegap100.com/newscontent.php?aid=${this.arguments['aid']}",
              // initialUrl: "https://baidu.com/",
              initialOptions: InAppWebViewWidgetOptions(
                inAppWebViewOptions: InAppWebViewOptions(
                  debuggingEnabled: true,
                ),
              ),
              // 监听加载进度
              onProgressChanged:
                  (InAppWebViewController controller, int progress) {
                print(progress / 100);
                if ((progress / 100) > 0.99) {
                  setState(() {
                    this._flag = false;
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  // loading 组件
  Widget _getMoreWidget() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("加载中... "),
            // loading
            CircularProgressIndicator(
              strokeWidth: 1.0,
            ),
          ],
        ),
      ),
    );
  }
}
