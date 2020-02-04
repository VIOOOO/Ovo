import 'package:flutter/material.dart';
import 'package:flutter_app_test/pages/tabs/My.dart';
import 'tabs/Home.dart';
import 'tabs/Category.dart';
import 'tabs/Setting.dart';
// import 'tabs/My.dart';

// Tab 组件03 组件更详细的控制
class Tabs extends StatefulWidget {
  Tabs({Key key}) : super(key: key);

  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  // 声明默认颜色和选中颜色
  final _defaultColor = Colors.green;
  final _activeColor = Colors.orange;
  // 声明页码
  int _currentIndex = 0;
  final PageController _controller = PageController(
    initialPage: 0,
  );
  // tabs 页面
  List<Widget> _pageList = [
    HomePage(),
    CategoryPage(),
    SettingPage(),
    MyPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter 自定义底部导航'),
      ),
      // 根据 tab 页签改变切换页面 使用组件 PageView
      body: PageView(
        controller: _controller,
        children: _pageList,
      ),
      // BottomNavigationBar 自定义底部导航
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          _controller.jumpToPage(index);
          setState(() {
            _currentIndex = index;
          });
        },
        // fixedColor: Colors.red, // 选中颜色
        type: BottomNavigationBarType.fixed, // 配置底部可以有多个按钮 大于3个需要该属性
        items: [
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.home),
          //   title: Text('首页'),
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: _defaultColor),
            activeIcon: Icon(Icons.home, color: _activeColor),
            title: Text(
              '首页',
              style: TextStyle(
                color: _currentIndex != 0 ? _defaultColor : _activeColor,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category, color: _defaultColor),
            activeIcon: Icon(Icons.category, color: _activeColor),
            title: Text(
              '分类',
              style: TextStyle(
                  color: _currentIndex != 1 ? _defaultColor : _activeColor),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, color: _defaultColor),
            activeIcon: Icon(Icons.settings, color: _activeColor),
            title: Text(
              '设置',
              style: TextStyle(
                  color: _currentIndex != 2 ? _defaultColor : _activeColor),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle, color: _defaultColor),
            activeIcon: Icon(Icons.account_circle, color: _activeColor),
            title: Text(
              '我的',
              style: TextStyle(
                  color: _currentIndex != 3 ? _defaultColor : _activeColor),
            ),
          ),
        ],
      ),
    );
  }
}

// // Tab 组件02
// class Tabs extends StatefulWidget {
//   Tabs({Key key}) : super(key: key);

//   @override
//   _TabsState createState() => _TabsState();
// }

// class _TabsState extends State<Tabs> {
//   // 声明页码
//   int _currentIndex = 0;

//   // tabs 页面
//  List _pageList = [
//        HomePage(),
//       CategoryPage(),
//        SettingPage(),
//      ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Flutter 自定义底部导航'),
//       ),
//       // 根据 tab 页签改变切换页面
//       body: this._pageList[this._currentIndex],
//       // BottomNavigationBar 自定义底部导航
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: this._currentIndex, // 第几个选中
//         onTap: (int index) {
//           setState(() {
//             // 重新渲染
//             this._currentIndex = index;
//           });
//         },
//         // iconSize: 25.0, // 图标大小
//         // fixedColor: Colors.red, // 选中颜色
//         // type: BottomNavigationBarType.fixed, // 配置底部可以有多个按钮 大于3个需要该属性
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             title: Text('首页'),
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.category),
//             title: Text('分类'),
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.settings),
//             title: Text('设置'),
//           ),
//           // BottomNavigationBarItem(
//           //   icon: Icon(Icons.home),
//           //   title: Text('首页4'),
//           // ),
//           // BottomNavigationBarItem(
//           //   icon: Icon(Icons.home),
//           //   title: Text('首页5'),
//           // ),
//           // BottomNavigationBarItem(
//           //   icon: Icon(Icons.home),
//           //   title: Text('首页6'),
//           // ),
//         ],
//       ),
//     );
//   }
// }
