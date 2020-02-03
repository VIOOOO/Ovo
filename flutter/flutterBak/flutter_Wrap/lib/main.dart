import 'package:flutter/material.dart';

void main() {
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Wrap 流式布局'),
        ),
        body: LayoutDemo(),
      ),
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}

class LayoutDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 基本的流布局
    return Container(
      height: 600,
      width: 400,
      color: Colors.green,
      padding: EdgeInsets.all(10),
      child: Wrap(
        spacing: 10, //元素间距
        runSpacing: 10, // 纵轴间距 行间距
        // direction: Axis.vertical, // 竖着排列
        // alignment: WrapAlignment.end, // 主轴对其方式
        // runAlignment: WrapAlignment.center,  // 纵轴对其方式
        children: <Widget>[
          MyButton('按钮'),
          MyButton('超长按钮按钮'),
          MyButton('按钮'),
          MyButton('超长按钮按钮'),
          MyButton('按钮'),
          MyButton('长长长按钮'),
          MyButton('按钮'),
          MyButton('长按钮'),
          MyButton('按钮'),
          MyButton('按钮'),
        ],
      ),
    );

    // // 基本的流布局
    // return Wrap(
    //   spacing: 10, //元素间距
    //   runSpacing: 10, // 纵轴间距 行间距
    //   // alignment: WrapAlignment.end, // 主轴对其方式
    //   children: <Widget>[
    //     MyButton('按钮'),
    //     MyButton('超长按钮按钮'),
    //     MyButton('按钮'),
    //     MyButton('超长按钮按钮'),
    //     MyButton('按钮'),
    //     MyButton('长长长按钮'),
    //     MyButton('按钮'),
    //     MyButton('长按钮'),
    //     MyButton('按钮'),
    //     MyButton('按钮'),

    //   ],
    // );
  }
}

// 定义一个按钮组件
class MyButton extends StatelessWidget {
  // 定义传入参数
  final String text;
  // 构造函数，text 为必选的参数
  const MyButton(this.text, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text(this.text),
      // 使按钮使用主题颜色
      textColor: Theme.of(context).accentColor,
      onPressed: () {}, // 按钮需要监听事件
    );
  }
}
