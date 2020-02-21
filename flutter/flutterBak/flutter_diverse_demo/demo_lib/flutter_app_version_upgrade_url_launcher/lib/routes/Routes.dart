import 'package:flutter/material.dart';
import '../pages/Tabs.dart';

import '../pages/AppVersion.dart';
import '../pages/UrlLauncher.dart';

// 配置命名路由
final routes = {
  // 根路由
  '/': (context) => Tabs(),
  '/appVersion': (context) => AppVersionPage(),
  '/urlLauncher': (context) => UrlLauncherPage(),

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
