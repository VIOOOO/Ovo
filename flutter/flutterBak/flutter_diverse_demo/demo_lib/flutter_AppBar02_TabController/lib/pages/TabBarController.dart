import 'package:flutter/material.dart';

// 动态自定义导航条

class TabBarControllerPage extends StatefulWidget {
  TabBarControllerPage({Key key}) : super(key: key);

  @override
  _TabBarControllerPageState createState() => _TabBarControllerPageState();
}

class _TabBarControllerPageState extends State<TabBarControllerPage>
    with SingleTickerProviderStateMixin {
  // 继承 SingleTickerProviderStateMixin 后定义一个 TabController
  TabController _tabController;

  // 生命周期函数
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }


  // 声明周期函数
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // 初始化时 实例化 _tabController 传入两个参数
    _tabController = new TabController(
      // tab 长度
      length: 8,
      // 固定写法
      vsync: this,
    );
    // 监听改变
    _tabController.addListener(() {
      print(_tabController.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TabBarControllerPage'),
        bottom: TabBar(
          // 必须 配置controller
          controller: this._tabController,

          // 页面过多时候是否可以滚动
          isScrollable: true,
          tabs: <Widget>[
            Tab(text: "热门0"),
            Tab(text: "推荐1"),
            Tab(text: "推荐2"),
            Tab(text: "推荐3"),
            Tab(text: "推荐4"),
            Tab(text: "推荐5"),
            Tab(text: "推荐6"),
            Tab(text: "推荐7"),
          ],
        ),
      ),
      body: TabBarView(
        // 必须 配置controller
        controller: this._tabController,

        children: <Widget>[
          ListView(
            children: <Widget>[
              ListTile(
                title: Text('Tba'),
              ),
              ListTile(
                title: Text('Tba'),
              ),
              ListTile(
                title: Text('Tba'),
              ),
            ],
          ),
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
          ),
          ListView(
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
          ListView(
            children: <Widget>[
              ListTile(
                title: Text('第三个Tba'),
              ),
              ListTile(
                title: Text('第三个Tba'),
              ),
              ListTile(
                title: Text('第三个Tba'),
              ),
            ],
          ),
          ListView(
            children: <Widget>[
              ListTile(
                title: Text('第四个Tba'),
              ),
              ListTile(
                title: Text('第四个Tba'),
              ),
              ListTile(
                title: Text('第四个Tba'),
              ),
            ],
          ),
          ListView(
            children: <Widget>[
              ListTile(
                title: Text('第五个Tba'),
              ),
              ListTile(
                title: Text('第五个Tba'),
              ),
              ListTile(
                title: Text('第五个Tba'),
              ),
            ],
          ),
          ListView(
            children: <Widget>[
              ListTile(
                title: Text('第六个Tba'),
              ),
              ListTile(
                title: Text('第六个Tba'),
              ),
              ListTile(
                title: Text('第六个Tba'),
              ),
            ],
          ),
          ListView(
            children: <Widget>[
              ListTile(
                title: Text('第七个Tba'),
              ),
              ListTile(
                title: Text('第七个Tba'),
              ),
              ListTile(
                title: Text('第七个Tba'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
