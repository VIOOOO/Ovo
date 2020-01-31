import 'package:flutter/material.dart';
// import 'res/listData.dart';

void main() {
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter 布局 Expanded'),
        ),
        body: LayoutDemo(),
      ),
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}

// Expanded 布局 类似 Web 中的 Flex 布局,可以使用 Row 组件和 Column 组件
class LayoutDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 左边/右边固定宽右边自适应
    return Row(
      children: <Widget>[
        // IconContainer(Icons.search, color: Colors.blue),
        Expanded(
          flex: 1,
          child: IconContainer(Icons.home, color: Colors.orange),
        ),
        IconContainer(Icons.search, color: Colors.blue),
      ],
    );

    // // 三组图标 中间比两边大两倍
    //  return Row(
    //   children: <Widget>[
    //     Expanded(
    //       flex: 1,
    //       child: IconContainer(Icons.search, color: Colors.blue),
    //     ),
    //     Expanded(
    //       flex: 2,
    //       child: IconContainer(Icons.home, color: Colors.orange),
    //     ),
    //     Expanded(
    //       flex: 1,
    //       child: IconContainer(Icons.select_all, color: Colors.red),
    //     ),
    //   ],
    // );
  }
}

class IconContainer extends StatelessWidget {
  double size = 32.0;
  Color color = Colors.red;
  IconData icon;
  IconContainer(this.icon, {this.color, this.size});
  @override
  Widget build(BuildContext contex) {
    return Container(
      width: 100.0,
      height: 100.0,
      color: this.color,
      child: Center(
        child: Icon(
          this.icon,
          size: this.size,
          color: Colors.white,
        ),
      ),
    );
  }
}
