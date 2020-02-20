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
        title: Text('Flutter Native 拍照上传、设备信息、地理定位'),
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

      // 左侧侧边栏
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            //  侧边栏头部用弹性布局撑满
            Row(
              children: <Widget>[
                Expanded(
                  // 头部组件02
                  child: UserAccountsDrawerHeader(
                    accountName: Text('名字XXX'),
                    accountEmail: Text('邮箱XXXXX'),
                    currentAccountPicture: CircleAvatar(
                      backgroundImage: NetworkImage(
                        'https://ossweb-img.qq.com/upload/adw/image/20200120/68498e64124410e35d8c4f1e85a9a790.jpeg',
                      ),
                    ),
                    decoration: BoxDecoration(
                      // // 黄色填充
                      // color: Colors.yellow,

                      // 背景图
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://ossweb-img.qq.com/upload/adw/image/20200121/f0f756b4425f0c096cd44ca2c2c9813b.jpeg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    // 头部内其他图片
                    otherAccountsPictures: <Widget>[
                      Image.network(
                          'https://ossweb-img.qq.com/upload/adw/image/20200120/68498e64124410e35d8c4f1e85a9a790.jpeg'),
                      Image.network(
                          'https://ossweb-img.qq.com/upload/adw/image/20200120/68498e64124410e35d8c4f1e85a9a790.jpeg'),
                      Image.network(
                          'https://ossweb-img.qq.com/upload/adw/image/20200120/68498e64124410e35d8c4f1e85a9a790.jpeg'),
                    ],
                  ),

                  // // 头部组件01 侧边栏头部组件
                  // child:  DrawerHeader(
                  //   child: Text('侧边栏头部'),
                  //   decoration: BoxDecoration(
                  //     // // 黄色填充
                  //     // color: Colors.yellow,

                  //     // 背景图
                  //     image: DecorationImage(
                  //       image: NetworkImage('https://ossweb-img.qq.com/upload/adw/image/20200120/68498e64124410e35d8c4f1e85a9a790.jpeg'),
                  //       fit: BoxFit.cover,
                  //     ),
                  //   ),
                  // ),
                )
              ],
            ),
            ListTile(
              // 增加圆形图标
              leading: CircleAvatar(
                child: Icon(Icons.home),
              ),
              title: Text('我的空间'),
            ),
            // 横线
            Divider(),
            ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.people),
              ),
              title: Text('用户中心'),
              onTap: () {
                // 返回时候能隐藏侧边栏
                Navigator.of(context).pop();
                // 侧边栏路由跳转
                Navigator.pushNamed(context, '/user');
              },
            ),
            // 横线
            Divider(),
            ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.settings),
              ),
              title: Text('设置中心'),
            ),
          ],
        ),
      ),
      // 右侧侧边栏
      endDrawer: Drawer(
        child: Text('flutter 右侧边栏'),
      ),
    );
  }
}
