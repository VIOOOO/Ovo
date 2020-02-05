import 'package:flutter/material.dart';
// 命名路由 引入需要跳转的页面进行路由配置
import '../pages/Tabs.dart';
import '../pages/Form.dart';
import '../pages/Search.dart';
import '../pages/Product.dart';
import '../pages/ProductInfo.dart';

// 配置命名路由
final routes = {
  // 根路由
  '/': (context) => Tabs(),
  // 无传参
  '/form': (context) => FormPage(),
  // 需要传参， {arguments} 表示可选参数， 参数名与接收方法对应 arguments
  '/search': (context, {arguments}) => SearchPage(arguments: arguments),

  '/Product': (context) => ProductPage(),
  '/ProductInfo': (context, {arguments}) => ProductInfoPage(arguments: arguments),
};

//  固定路由写法
// 创建路由处理方法
var onGenerateRoute = (RouteSettings settings) {
  // print(settings.name);
  final String name = settings.name;
  // 获取名称对应的方法并赋值到 pageContentBuilder
  final Function pageContentBuilder = routes[name];

  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      // 命名路由内传参
      final Route route = MaterialPageRoute(
        builder: (context) =>
            pageContentBuilder(context, arguments: settings.arguments),
      );
      return route;
    } else {
      // 无需传参
      final Route route = MaterialPageRoute(
        builder: (context) => pageContentBuilder(context),
      );
      return route;
    }
  }
};