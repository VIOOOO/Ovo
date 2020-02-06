import 'package:flutter/material.dart';
import 'tabs/Home.dart';
import 'tabs/Category.dart';
import 'tabs/Setting.dart';

// Tab 组件02
class Tabs extends StatefulWidget {
  // 声明传入的页码 接收
  final index;
  Tabs({Key key, this.index = 0}) : super(key: key);

  @override
  _TabsState createState() => _TabsState(this.index);
}

class _TabsState extends State<Tabs> {
  // 声明页码
  int _currentIndex;
  // int _currentIndex = 0;

  _TabsState(index) {
    this._currentIndex = index;
  }

  // tabs 页面
  List _pageList = [
    HomePage(),
    CategoryPage(),
    SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter 路由'),
      ),
      // 根据 tab 页签改变切换页面
      body: this._pageList[this._currentIndex],
      // BottomNavigationBar 自定义底部导航
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: this._currentIndex, // 第几个选中
        onTap: (int index) {
          setState(() {
            // 重新渲染
            this._currentIndex = index;
          });
        },
        // iconSize: 25.0, // 图标大小
        // fixedColor: Colors.red, // 选中颜色
        // type: BottomNavigationBarType.fixed, // 配置底部可以有多个按钮 大于3个需要该属性
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('首页'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            title: Text('分类'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text('设置'),
          ),
        ],
      ),
    );
  }
}
