import 'dart:convert';

import 'package:flutter/material.dart';
// 轮播插件
import 'package:flutter_swiper/flutter_swiper.dart';
//	图片过渡插件
//import 'package:transparent_image/transparent_image.dart';
//	图片缓存插件
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_trip/dao/home_dao.dart';
import 'package:flutter_trip/model/home_model.dart';

// 顶部appBar 在页面滚动最大值后完全显示
const APPBAR_SCROLL_OFFSET = 100;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _imageUrls = [
    // 网络图片
    'https://ossweb-img.qq.com/upload/adw/image/20200120/68498e64124410e35d8c4f1e85a9a790.jpeg',
    'https://ossweb-img.qq.com/upload/adw/image/20200121/d229ba7ab0c06f88de7dc687a4e29a92.jpeg',
    'https://ossweb-img.qq.com/upload/adw/image/20200121/f0f756b4425f0c096cd44ca2c2c9813b.jpeg',
  ];

//	List _imageUrls = [	// 网络图片
//		'a01.jpeg',
//		'a02.jpeg',
//		'a03.jpeg',
//	];
  double appBarAlpha = 0;
  // 接口数据
  String resultString = "";

  @override
  void initState() {
    super.initState();
    loadData();
  }

  // 页面滚动距离计算
  _onScroll(offset) {
    double alpha = offset / APPBAR_SCROLL_OFFSET;
    if (alpha <= 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      appBarAlpha = alpha;
    });
    print(appBarAlpha);
  }

  loadData() async {
    // HomeDao.fetch().then((result){
    //   setState(() {
    //     resultString = json.encode(result);
    //   });
    // }).catchError((e){
    //   // 抛出异常处理
    //   setState(() {
    //     resultString = e.toString();
    //   });
    // });

    // 另一种方法 使用异步
    try {
      HomeModel model = await HomeDao.fetch();
      setState(() {
        resultString = json.encode(model.config);
      });
    } catch (e) {
      setState(() {
        resultString = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        MediaQuery.removePadding(
          // MediaQuery.removePadding 移除顶部安全区
          removeTop: true,
          context: context,
//					child: Text('首页'),
          child: NotificationListener(
              // 监听滚动
              onNotification: (scrollNotification) {
                if (scrollNotification is ScrollUpdateNotification &&
                    scrollNotification.depth == 0) {
                  // 滚动且是第一个元素列表,滚动的时候
                  _onScroll(scrollNotification.metrics.pixels);
                }
              },
              child: ListView(
                children: <Widget>[
                  Container(
                    height: 160,
                    // 顶部轮播
                    child: Swiper(
                      itemCount: _imageUrls.length,
                      // autoplay: true,
                      itemBuilder: (BuildContext context, int index) {
//                  // 加载网络图片前 kTransparentImage 用这个透明图片代替 实现过渡
//                  return FadeInImage.memoryNetwork(
//                    placeholder: kTransparentImage,
////										placeholder: 'image/a01.jpeg',
//                    image: _imageUrls[index],
//                    fit: BoxFit.fill,
//                  );

                        // 优先缓存，加载网络图片
                        return CachedNetworkImage(
//										placeholder:(context, url) => new CircularProgressIndicator(),	// 图片加载出来前的一个圆形进度条
                          imageUrl: _imageUrls[index],
                          fit: BoxFit.fill,
                        );

//								// 普通加载网络图片
//									return Image.network(
//										_imageUrls[index],
//										fit: BoxFit.fill,
//									);

//									// 加载静态图片
//									return Image.asset(
//										_imageUrls[index],
//										fit: BoxFit.fill,
//									);
                      },
                      pagination: SwiperPagination(), // 指示器
                    ),
                  ),
                  Container(
                    height: 800,
                    child: ListTile(
                      title: Text(resultString),
                    ),
                  ),
                ],
              )),
        ),
        Opacity(
          // 改变元素透明度
          opacity: appBarAlpha,
          child: Container(
            height: 80,
            decoration: BoxDecoration(color: Colors.white), // 装饰器 背景白色
            child: Center(
              child:
                  Padding(padding: EdgeInsets.only(top: 20), child: Text('首页')),
            ),
          ),
        )
      ],
    ));
  }
}
