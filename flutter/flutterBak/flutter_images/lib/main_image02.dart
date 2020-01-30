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
        // 引入网络图片

        // 圆形图片2
        child: ClipOval(
          child: Image.network(
            'https://ossweb-img.qq.com/upload/adw/image/20200120/68498e64124410e35d8c4f1e85a9a790.jpeg',
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        ),

        // // 圆形图片1
        // width: 300,
        // height: 300,
        // decoration: BoxDecoration(
        //   color: Colors.yellow,
        //   borderRadius: BorderRadius.circular(150),
        //   image: DecorationImage(
        //     image: NetworkImage('https://ossweb-img.qq.com/upload/adw/image/20200120/68498e64124410e35d8c4f1e85a9a790.jpeg'),
        //     fit: BoxFit.cover
        //   )
        // ),

        // // 普通引入网络图片
        // // child: Image.network(
        // //   'https://ossweb-img.qq.com/upload/adw/image/20200120/68498e64124410e35d8c4f1e85a9a790.jpeg',
        // // ),
      ),
    );
  }
}
