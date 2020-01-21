import 'package:flutter/material.dart';
// 轮播插件
import 'package:flutter_swiper/flutter_swiper.dart';
//	图片过渡插件
import 'package:transparent_image/transparent_image.dart';
//	图片缓存插件
import 'package:cached_network_image/cached_network_image.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
//        child: Text('首页'),
        child: Column(
          children: <Widget>[
            Container(
              height: 160,
              child: Swiper(
                itemCount: _imageUrls.length,
                autoplay: true,
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
          ],
        ),
      ),
    );
  }
}
