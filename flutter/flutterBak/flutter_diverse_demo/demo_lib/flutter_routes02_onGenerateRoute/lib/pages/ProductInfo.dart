import 'package:flutter/material.dart';

class ProductInfoPage extends StatefulWidget {
  // 定义传过来的参数，接收路由值
  final Map arguments;

  ProductInfoPage({Key key, this.arguments}) : super(key: key);

  @override
  _ProductInfoPageState createState() =>
      _ProductInfoPageState(arguments: this.arguments);
}

class _ProductInfoPageState extends State<ProductInfoPage> {
  // 定义传过来的参数，接收ProductInfoPage 传递值
  Map arguments;
  _ProductInfoPageState({this.arguments});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('商品详情页'),
      ),
      body: Container(
        child: Text("商品详情 pid=${arguments['pid']}"),
      ),
    );
  }
}
