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
          title: Text('Flutter AspectRatio、Card 卡片组件'),
        ),
        body: LayoutDemo(),
      ),
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}

// AspectRatio、Card 卡片组件
class LayoutDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
     // 03综合例子  AspectRatio、Card 卡片组件
    return ListView(
      children: <Widget>[
        Card(
          margin: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 20 / 9,
                child: Image.network(
                  'https://ossweb-img.qq.com/upload/adw/image/20200120/68498e64124410e35d8c4f1e85a9a790.jpeg',
                  fit: BoxFit.cover,
                ),
              ),
              ListTile(
                // 圆形图片 圆形头像 常用 CircleAvatar
                leading: CircleAvatar(
                  backgroundImage: NetworkImage('https://ossweb-img.qq.com/upload/adw/image/20200120/68498e64124410e35d8c4f1e85a9a790.jpeg')
                ),
                title: Text('XXXXX'),
                subtitle: Text('XXXXXXXX'),
              )
            ],
          ),
        ),
         Card(
          margin: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 20 / 9,
                child: Image.network(
                  'https://ossweb-img.qq.com/upload/adw/image/20200120/68498e64124410e35d8c4f1e85a9a790.jpeg',
                  fit: BoxFit.cover,
                ),
              ),
              ListTile(
                // 圆形图片 不设置高宽就会变成椭圆
                leading: ClipOval(
                  child: Image.network('https://ossweb-img.qq.com/upload/adw/image/20200120/68498e64124410e35d8c4f1e85a9a790.jpeg'),
                ),
                title: Text('XXXXX'),
                subtitle: Text('XXXXXXXX'),
              )
            ],
          ),
        )
      ],
    );
    
    // // 02 ACard 卡片组件
    // return ListView(
    //   children: <Widget>[
    //     Card(
    //       margin: EdgeInsets.all(10),
    //       child: Column(
    //         children: <Widget>[
    //           ListTile(
    //             title: Text('张三', style: TextStyle(fontSize: 28)),
    //             subtitle: Text('高级吃货'),
    //           ),
    //           ListTile(
    //             title: Text('电话：1111111'),
    //           ),
    //           ListTile(
    //             title: Text('地址：打了你上来看'),
    //           ),
    //         ],
    //       ),
    //     ),
    //     Card(
    //       margin: EdgeInsets.all(10),
    //       child: Column(
    //         children: <Widget>[
    //           ListTile(
    //             title: Text('李四', style: TextStyle(fontSize: 28)),
    //             subtitle: Text('高级吃货'),
    //           ),
    //           ListTile(
    //             title: Text('电话：111258741'),
    //           ),
    //           ListTile(
    //             title: Text('地址：打了你上来看'),
    //           ),
    //         ],
    //       ),
    //     ),
    //     Card(
    //       margin: EdgeInsets.all(10),
    //       child: Column(
    //         children: <Widget>[
    //           ListTile(
    //             title: Text('炫舞', style: TextStyle(fontSize: 28)),
    //             subtitle: Text('高级吃货'),
    //           ),
    //           ListTile(
    //             title: Text('电话：178543121'),
    //           ),
    //           ListTile(
    //             title: Text('地址：打了你上来看'),
    //           ),
    //         ],
    //       ),
    //     )
    //   ],
    // );

    // // 01 AspectRatio卡片组件
    // return AspectRatio(
    //   aspectRatio: 3.0 / 1.0, // 宽高比
    //   child: Container(
    //     color: Colors.red,
    //   ),
    // );

    // // AspectRatio卡片组件01
    // return Container(
    //   width: 300,
    //   child: AspectRatio(
    //     aspectRatio: 2.0/1.0, // 宽高比
    //     child: Container(
    //       color: Colors.red,
    //     ),
    //   ),
    // );
  }
}
