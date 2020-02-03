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
          title: Text('Flutter 布局 Row水平、Column垂直'),
        ),
        body: LayoutDemo(),
      ),
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}

// Column 垂直布局
class LayoutDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600.0,
      width: 400.0,
      color: Colors.pink,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start, // 水平主轴 Y 排序方式
        crossAxisAlignment: CrossAxisAlignment.end, // 次轴 X 的排序方式
        children: <Widget>[
          IconContainer(Icons.search, color: Colors.blue),
          IconContainer(Icons.home, color: Colors.orange),
          IconContainer(Icons.select_all, color: Colors.red),
        ],
      ),
    );
  }
}

// // Row 水平布局
// class LayoutDemo extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 600.0,
//       width: 400.0,
//       color: Colors.pink,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 水平主轴 X 排序方式
//         crossAxisAlignment:CrossAxisAlignment.start, // 次轴 Y 的排序方式
//         children: <Widget>[
//           IconContainer(Icons.search, color: Colors.blue),
//           IconContainer(Icons.home, color: Colors.orange),
//           IconContainer(Icons.select_all, color: Colors.red),
//         ],
//       ),
//     );
//   }
// }

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
