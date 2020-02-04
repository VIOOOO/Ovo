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
          title: Text('Flutter 页面布局 Stack 层叠组件'),
        ),
        body: LayoutDemo(),
      ),
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}

// 布局综合案例
class LayoutDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // Stack 组件与 Positioned 组件结合使用
    return Center(
      child: Container(
        height: 400,
        width: 300,
        color: Colors.red,
        child: Stack(
          // alignment: Alignment.bottomLeft, // 全局内容居中，会重叠
          children: <Widget>[
            Positioned(
              left: 10,
              child: Icon(Icons.home, size: 40, color: Colors.white),
            ),
            Positioned(
              bottom: 0,
              left: 100,
              child: Icon(Icons.search, size: 40, color: Colors.white),
            ),
            Positioned(
              right: 0,
              child: Icon(Icons.settings_applications,
                  size: 40, color: Colors.white),
            ),
          ],
        ),
      ),
    );

    // // Stack 组件与 Align 组件结合使用
    // return Center(
    //   child: Container(
    //     height: 400,
    //     width: 300,
    //     color: Colors.red,
    //     child: Stack(
    //       // alignment: Alignment.bottomLeft, // 全局内容居中，会重叠
    //       children: <Widget>[
    //         Align(
    //           alignment: Alignment(-1, -1),
    //           child: Icon(Icons.home, size: 40, color: Colors.white),
    //         ),
    //         Align(
    //           alignment: Alignment.center,
    //           child: Icon(Icons.search, size: 40, color: Colors.white),
    //         ),
    //         Align(
    //           alignment: Alignment.bottomRight,
    //           child: Icon(Icons.settings_applications,
    //               size: 40, color: Colors.white),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
