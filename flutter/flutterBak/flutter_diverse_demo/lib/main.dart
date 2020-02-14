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
          title: Text('Flutter 布局综合案例'),
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
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                height: 180,
                color: Colors.black,
                child: Text('大屏幕', style: TextStyle(color: Colors.white)),
              ),
            )
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                height: 180,
                child: Image.network(
                  'https://ossweb-img.qq.com/upload/adw/image/20200121/f0f756b4425f0c096cd44ca2c2c9813b.jpeg',
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              flex: 1,
              child: Container(
                  height: 180,
                  child: ListView(
                    children: <Widget>[
                      Container(
                        height: 85,
                        child: Image.network(
                          'https://ossweb-img.qq.com/upload/adw/image/20200121/f0f756b4425f0c096cd44ca2c2c9813b.jpeg',
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: 85,
                        child: Image.network(
                          'https://ossweb-img.qq.com/upload/adw/image/20200121/f0f756b4425f0c096cd44ca2c2c9813b.jpeg',
                          fit: BoxFit.fill,
                        ),
                      )
                    ],
                  )),
            ),
          ],
        )
      ],
    );
  }
}
