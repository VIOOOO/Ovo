import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';

class SwiperPage extends StatefulWidget {
  SwiperPage({Key key}) : super(key: key);

  @override
  _SwiperPageState createState() => _SwiperPageState();
}

class _SwiperPageState extends State<SwiperPage> {
  List<Map> imgList = [
    {
      "url":
          "https://ossweb-img.qq.com/upload/adw/image/20200120/68498e64124410e35d8c4f1e85a9a790.jpeg"
    },
    {
      "url":
          "https://ossweb-img.qq.com/upload/adw/image/20200120/68498e64124410e35d8c4f1e85a9a790.jpeg"
    },
    {
      "url":
          "https://ossweb-img.qq.com/upload/adw/image/20200120/68498e64124410e35d8c4f1e85a9a790.jpeg"
    },
    {
      "url":
          "https://ossweb-img.qq.com/upload/adw/image/20200120/68498e64124410e35d8c4f1e85a9a790.jpeg"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('轮播组件演示'),
        ),
        body: Column(
          children: <Widget>[
            Container(
              // // 让宽度适应100%
              // width: double.infinity,
              child: AspectRatio(
                // 将容器内的元素按照需要的比例显示，达到自适应宽高比
                aspectRatio: 16 / 9,
                // 轮播2
                child: new Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    return new Image.network(
                      imgList[index]['url'],
                      fit: BoxFit.fill,
                    );
                  },
                  itemCount: imgList.length,
                  viewportFraction: 0.8,
                  scale: 0.9,
                  // 分页器
                  pagination: new SwiperPagination(),
                  autoplay: true,
                ),

                // // 轮播1
                // child: new Swiper(
                //   itemBuilder: (BuildContext context, int index) {
                //     return new Image.network(
                //       imgList[index]['url'],
                //       fit: BoxFit.fill,
                //     );
                //   },
                //   // 轮播长度
                //   itemCount: imgList.length,
                //   // 分页器
                //   pagination: new SwiperPagination(),
                //   // 左右箭头
                //   control: new SwiperControl(),
                // ),
              ),
            ),
            Row(
              children: <Widget>[
                Text('文本'),
              ],
            )
          ],
        ));
  }
}
