import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  final arguments;

  SearchPage({this.arguments});

  @override
  Widget build(BuildContext context) {
    // 此页面为一个页面，被 Navigator push 到需要的页面时候，是无主题的，所以需要 Scaffold 先设置主题等内容
    return Scaffold(
      appBar: AppBar(
        title: Text('搜索页面'),
      ),
      body: Text("搜索页面内容区接收到值：${arguments != null ? arguments['id'] : '0'}"),
    );
  }
}
