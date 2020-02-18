import 'package:flutter/material.dart';

// 分类页
class CategoryPage extends StatefulWidget {
  CategoryPage({Key key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      // 长度为必须，切换的个数
      length: 8,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          // tab 页签切换菜单 嵌入导航内
          title: Row(
            children: <Widget>[
              // Flex 布局
              Expanded(
                child: TabBar(
                  // 页面过多时候是否可以滚动
                  isScrollable: true,

                  // 指示器颜色
                  indicatorColor: Colors.blue,
                  // 指示器长度
                  indicatorSize: TabBarIndicatorSize.label,

                  // 页签字 选中颜色
                  labelColor: Colors.green,
                  // 页签字 未选中颜色
                  unselectedLabelColor: Colors.white,

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
            ],
          ),
        ),
        // TabBarView tab 页签切换对应的页面，需要和页签的个数对应上
        body: TabBarView(
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
      ),
    );
  }
}
