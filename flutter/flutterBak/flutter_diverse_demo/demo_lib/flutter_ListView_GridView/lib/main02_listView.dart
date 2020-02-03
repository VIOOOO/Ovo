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
          title: Text('Flutter Demo 垂直列表和水平列表'),
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
        //  水平基本列表 需要在列表外设置高度
    return Container(
        height: 180.0,
        child: ListView(
          scrollDirection: Axis.horizontal, // 水平列表
          children: <Widget>[
            Container(
              width: 180.0,
              color: Colors.blue,
            ),
            Container(
              width: 180.0,
              color: Colors.yellow,
              child: ListView(children: <Widget>[
                Image.network(
                    'https://ossweb-img.qq.com/upload/adw/image/20200120/68498e64124410e35d8c4f1e85a9a790.jpeg'),
                Text('这是一段文字')
              ]),
            ),
            Container(
              width: 180.0,
              color: Colors.orange,
            ),
            Container(
              width: 180.0,
              color: Colors.brown,
            ),
            Container(
              width: 180.0,
              color: Colors.pink,
            ),
          ],
        ));


    // // 垂直基本列表
    // return ListView(
    //   children: <Widget>[
    //     ListTile(
    //       leading: Image.network(
    //           'https://flutter.cn/images/assets-and-images/icon.png'),
    //       title: Text('会Dart'),
    //       subtitle:
    //           Text('Flutter是谷歌公司开发的一款开源、免费的移动UI框架，可以让我们快速的在Android和iOS上。'),
    //     ),
    //     ListTile(
    //       leading: Icon(
    //         Icons.settings,
    //         size: 50,
    //       ), //图标
    //       title: Text('要学Flutter的话我们必须首先得会Dart'),
    //       subtitle: Text(
    //           'Flutter是谷歌公司开发的一款开源、免费的移动UI框架，可以让我们快速的在Android和iOS上构建高质量App。它最大的特点就是跨平台、以及高性能。'),
    //     ),
    //     ListTile(
    //       title: Text('要学Flutter得会Dart'),
    //       subtitle: Text('Flutter是谷歌公司开上构建高质量App。它最大的特点。'),
    //       trailing: Icon(Icons.home), // 图标放后面
    //     ),
    //     ListTile(
    //       title: Text('要学首先得会Dart'),
    //       subtitle: Text('上构建高质量App。它最大的特点就是跨平台、以及高性能。'),
    //       trailing: Icon(Icons.settings),
    //     ),
    //     ListTile(
    //       leading: Icon(
    //         Icons.pages,
    //         color: Colors.cyan,
    //       ),
    //       title: Text('必须首先得会Dart'),
    //       subtitle: Text('Flutter是谷歌公司开发的一款Android和iOS上台、以及高性能。'),
    //     ),
    //     ListTile(
    //       leading: Icon(Icons.settings),
    //       title: Text('们必须首先得会Dart'),
    //       subtitle: Text('Flutter是谷歌公司开发的一款开源、免费的移动UI跨平台、以及高性能。'),
    //        trailing: Icon(Icons.home),
    //     ),
    //   ],
    // );

    // // 垂直图文列表
    // return ListView(
    //   padding: EdgeInsets.all(10),
    //   children: <Widget>[
    //     Image.network(
    //         'https://ossweb-img.qq.com/upload/adw/image/20200120/68498e64124410e35d8c4f1e85a9a790.jpeg'),
    //     Container(
    //         child: Text(
    //           '文本标题',
    //           textAlign: TextAlign.center,
    //           style: TextStyle(
    //             fontSize: 28,
    //           ),
    //         ),
    //         height: 60,
    //         padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
    //     Image.network(
    //         'https://ossweb-img.qq.com/upload/adw/image/20200120/68498e64124410e35d8c4f1e85a9a790.jpeg'),
    //     Container(
    //         child: Text(
    //           '文本标题',
    //           textAlign: TextAlign.center,
    //           style: TextStyle(
    //             fontSize: 28,
    //           ),
    //         ),
    //         height: 60,
    //         padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
    //     Image.network(
    //         'https://ossweb-img.qq.com/upload/adw/image/20200120/68498e64124410e35d8c4f1e85a9a790.jpeg'),
    //     Container(
    //         child: Text(
    //           '文本标题',
    //           textAlign: TextAlign.center,
    //           style: TextStyle(
    //             fontSize: 28,
    //           ),
    //         ),
    //         height: 60,
    //         padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
    //     Image.network(
    //         'https://ossweb-img.qq.com/upload/adw/image/20200120/68498e64124410e35d8c4f1e85a9a790.jpeg'),
    //     Container(
    //         child: Text(
    //           '文本标题',
    //           textAlign: TextAlign.center,
    //           style: TextStyle(
    //             fontSize: 28,
    //           ),
    //         ),
    //         height: 60,
    //         padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
    //     Image.network(
    //         'https://ossweb-img.qq.com/upload/adw/image/20200120/68498e64124410e35d8c4f1e85a9a790.jpeg'),
    //     Container(
    //         child: Text(
    //           '文本标题',
    //           textAlign: TextAlign.center,
    //           style: TextStyle(
    //             fontSize: 28,
    //           ),
    //         ),
    //         height: 60,
    //         padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
    //     Image.network(
    //         'https://ossweb-img.qq.com/upload/adw/image/20200120/68498e64124410e35d8c4f1e85a9a790.jpeg'),
    //     Container(
    //         child: Text(
    //           '文本标题',
    //           textAlign: TextAlign.center,
    //           style: TextStyle(
    //             fontSize: 28,
    //           ),
    //         ),
    //         height: 60,
    //         padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
    //   ],
    // );


  }
}
