import 'package:flutter/material.dart';
import 'res/listData.dart';

void main() {
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Demo 布局 padding组件'),
        ),
        body: LayoutDemo(),
      ),
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}

// 网格布局 修改使用 padding 组件 实现左右间距
class LayoutDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0,0, 10, 10), // padding 组件必不可少
        child: GridView.count(
      crossAxisCount: 2, // 网格几列
      childAspectRatio: 1.7, //宽度和高度比例，因设置不了高度，可以适用该元素调节剂 X 轴与 Y 轴的比例
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
          child: Image.network(
            'https://ossweb-img.qq.com/upload/adw/image/20200121/d229ba7ab0c06f88de7dc687a4e29a92.jpeg',
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
          child: Image.network(
            'https://ossweb-img.qq.com/upload/adw/image/20200121/d229ba7ab0c06f88de7dc687a4e29a92.jpeg',
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
          child: Image.network(
            'https://ossweb-img.qq.com/upload/adw/image/20200121/d229ba7ab0c06f88de7dc687a4e29a92.jpeg',
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
          child: Image.network(
            'https://ossweb-img.qq.com/upload/adw/image/20200121/d229ba7ab0c06f88de7dc687a4e29a92.jpeg',
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
          child: Image.network(
            'https://ossweb-img.qq.com/upload/adw/image/20200121/d229ba7ab0c06f88de7dc687a4e29a92.jpeg',
            fit: BoxFit.cover,
          ),
        ),
      ],
    ));
  }
}
