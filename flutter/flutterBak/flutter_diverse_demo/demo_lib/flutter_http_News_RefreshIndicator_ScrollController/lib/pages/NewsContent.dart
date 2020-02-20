import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;

class NewsContent extends StatefulWidget {
  // 定义接收路由传过来的参数
  Map arguments;
  NewsContent({Key key, this.arguments}) : super(key: key);

  @override
  _NewsContentState createState() => _NewsContentState(this.arguments);
}

class _NewsContentState extends State<NewsContent> {
  // 定义接收上个组件传过来的参数
  Map arguments;

  // 定义详情内容
  List _list = [];

  // 构造函数
  _NewsContentState(this.arguments);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(this.arguments);
    this._getData();
  }

  _getData() async {
    var apiUrl =
        "http://www.phonegap100.com/appapi.php?a=getPortalArticle&aid=${this.arguments['aid']}";
    var response = await Dio().get(apiUrl);
    setState(() {
      this._list = json.decode(response.data)['result'];
    });
    // print(this._list);
    // [{aid: 498, catid: 20, username: admin, title: ionic域资源共享 CORS 详解, author: , summary: 了解ionic域资源共享 CORS 前先看看 CORS在ionic angular开发中使用浏览器调试resource post的时候出现 CORS 头缺少 Access-Control-Allow-Origin'解决方案http://bbs.phonegap100.com/thread-2088-1-1.htmlCORS是一 ..., pic: , content: <p style="margin: 1em 0px 0px 0.8em; padding: 0px; list-style-type: none; border: none; color: rgb(17, 17, 17); font-size: 1.6em; line-height: 28.8px; font-family: Georgia, serif; letter-spacing: -0.12px; word-spacing: 2.4px; background-color: rgb(245, 245, 213);">了解ionic域资源共享 CORS 前先看看 &nbsp;<span style="font-size: 22.4px; letter-spacing: -0.12px; line-height: 28.8px; word-spacing: 2.4px;">CORS</span><span style="font-size: 22.4px; letter-spacing: -0.12px; line-height: 28.8px; word-spacing: 2.4px;">&nbsp;</span></p><p style="margin: 1em 0px 0px 0.8em; padding: 0px; list-style-type: none; border: none; background-color: rgb(245, 245, 2 ....
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('新闻详情'),
      ),
      body: ListView(
        children: <Widget>[
          // Text("${this._list.length>0?this._list[0]['title']:''}"),
          // Text("${this._list.length>0?this._list[0]['content']:''}"),
          // 返回的页面数据
          Html(
            data: """
              ${this._list.length>0?this._list[0]['content']:''}
            """,
            //Optional parameters:
            padding: EdgeInsets.all(8.0),
            backgroundColor: Colors.white70,
            defaultTextStyle: TextStyle(fontFamily: 'serif'),
            linkStyle: const TextStyle(
              color: Colors.redAccent,
            ),
            onLinkTap: (url) {
              // open url in a webview
            },
            onImageTap: (src) {
              // Display the image in large form.
            },
            // //Must have useRichText set to false for this to work.
            // customRender: (node, children) {
            //   if(node is dom.Element) {
            //     switch(node.localName) {
            //       case "video": return Chewie(...);
            //       case "custom_tag": return CustomWidget(...);
            //     }
            //   }
            // },
            customTextAlign: (dom.Node node) {
              if (node is dom.Element) {
                switch (node.localName) {
                  case "p":
                    return TextAlign.justify;
                }
              }
            },
            customTextStyle: (dom.Node node, TextStyle baseStyle) {
              if (node is dom.Element) {
                switch (node.localName) {
                  case "p":
                    return baseStyle.merge(TextStyle(height: 2, fontSize: 20));
                }
              }
              return baseStyle;
            },
          )
        ],
      ),
    );
  }
}
