import 'package:flutter/material.dart';


// 引入路由组件
import 'routes/Routes.dart';

void main() => runApp(Myapp());

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Tabs() 写入路由后 为成根路由，可以省略 home 属性，
      // home: Tabs(),  
      // 省略 home 后缺少入口 所以需要 initialRoute，在初始化时候，加载的路由，即加载 Tabs 组件
      initialRoute: '/',


      // // 命名路由需要配置在根组件内，如当前位置， 可以抽离成组件
      // routes: {
      //   '/form': (context) => FormPage(),
      //   '/search': (context) => SearchPage(),
      // },

      // 路由组件内创建的方法，这里方法不需要加括号，加括号表示传参
      onGenerateRoute: onGenerateRoute,
      // 自定义主题颜色
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
