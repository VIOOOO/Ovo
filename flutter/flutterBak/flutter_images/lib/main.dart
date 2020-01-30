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
          title: Text('Flutter Demo'),
        ),
        body: HomeContent(),
      ),
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}

class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        
        // 引入本地图片

        // child: Image.asset(
        //   'images/a.jpeg',
        //   fit: BoxFit.cover,
        // ),
        // width: 300,
        // height: 300,
        // decoration: BoxDecoration(
        //   color: Colors.black
        // ),


        // 圆形图片
        child: ClipOval(
          child:Image.asset(
            'images/a.jpeg',
          width: 100,
          height: 100,
          fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
