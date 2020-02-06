import 'package:flutter/material.dart';

// AppBar 自定义导航条
class AppBarDemoPage extends StatelessWidget {
  const AppBarDemoPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      // 长度为必须，切换的个数
      length: 2,
      child: Scaffold(
        appBar: AppBar(
            title: Text('AppBarDemo 自定义导航'),

            // // 背景色
            // backgroundColor: Colors.red,

            // 标题居中 无论 android 还是 ios
            centerTitle: true,

            // // 导航左侧加按钮图标, 该自定义按钮会覆盖 二级页面的返回按钮
            // leading: IconButton(
            //   icon: Icon(Icons.menu),
            //   onPressed: () {
            //     print('menu');
            //   },
            // ),

            // // 导航后面添加图标
            // actions: <Widget>[
            //   IconButton(
            //     icon: Icon(Icons.search),
            //     onPressed: () {
            //       print('search');
            //     },
            //   ),
            //   IconButton(
            //     icon: Icon(Icons.settings),
            //     onPressed: () {
            //       print('settings');
            //     },
            //   ),
            // ],

            // 配置顶部 tab 页签切换菜单
            bottom: TabBar(
              tabs: <Widget>[
                Tab(text: "热门"),
                Tab(text: "推荐"),
              ],
            ),),
            // TabBarView tab 页签切换对应的页面，需要和页签的个数对应上
        body: TabBarView(
          children: <Widget>[
            ListView(
              children: <Widget>[
                ListTile(
                  title: Text('第一个Tba'),
                ),
                ListTile(
                  title: Text('第一个Tba'),
                ),
                ListTile(
                  title: Text('第一个Tba'),
                ),
              ],
            ),            ListView(
              children: <Widget>[
                ListTile(
                  title: Text('第二个Tba'),
                ),
                ListTile(
                  title: Text('第二个Tba'),
                ),
                ListTile(
                  title: Text('第二个Tba'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
