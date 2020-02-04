import 'package:flutter/material.dart';
import 'pages/Tabs.dart';

void main() => runApp(Myapp());

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Tabs(),
      // 自定义主题颜色
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ), 
    );
  }
}
