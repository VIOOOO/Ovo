import 'package:flutter/material.dart';

// 列表下拉刷新

void main() => runApp(MyApp());
// 动态类型 简单列表
List<String> cityNames = [
  '北京市',
  '天津市',
  '石家庄市',
  '唐山市',
  '秦皇岛市',
  '邯郸市',
  '邢台市',
  '保定市',
  '张家口市',
  '承德市',
  '沧州市',
  '廊坊市',
  '衡水市',
  '省直辖县',
  '太原市',
  '大同市',
  '阳泉市',
  '长治市',
  '晋城市',
  '朔州市',
  '晋中市',
  '运城市',
  '忻州市',
  '临汾市',
  '吕梁市'
];

// 列表 ListView 垂直 下拉刷新
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ScrollController _scrollController = ScrollController(); // 构建 下拉加载 实例

  // 列表滚动监听开始
  @override
  void initState() {
    _scrollController.addListener(() {
      // 列表滚动到 最底 位置时候 触发加载
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
        _loadData();
      }
    });

    super.initState();
  }

  // 列表滚动监听结束 列表滚动结束后及时及时移除监听，减少性能损耗
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final title = '高级功能列表下拉刷新与上拉加载更多 功能实现';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: RefreshIndicator(
          // RefreshIndicator 让 ListView 具有下拉刷新的能力
          onRefresh: _handleRefresh, // 刷新的回调方法
          child: ListView(
            controller: _scrollController,  // 添加上拉加载更多
            children: _buildList(),
          ),
        ),
      ),
    );
  }

  // 下拉加载 模拟接口 延时 200毫秒
  _loadData() async {
    await Future.delayed(Duration(milliseconds: 200));
    setState(() {
      List<String> list = List<String>.from(cityNames); // 复制数组
      list.addAll(cityNames); // 数组再加一份
      cityNames = list;
    });
  }

  // 刷新的回调方法 模拟网络请求
  Future<Null> _handleRefresh() async {
    await Future.delayed(Duration(seconds: 2)); // 延时2秒
    setState(() {
      cityNames = cityNames.reversed.toList(); // 将数组取反
    });
    return null;
  }

  List<Widget> _buildList() {
    return cityNames.map((city) => _item(city)).toList();
  }

  Widget _item(String city) {
    return Container(
      height: 80, //网格布局 垂直滚动样式 水平滚动高度需要在外部对整个列表设置高度
      margin: EdgeInsets.only(bottom: 5), // 网格布局 垂直滚动样式
      alignment: Alignment.center, // 居中方式
      decoration: BoxDecoration(color: Colors.teal), // 装饰器
      child: Text(
        city,
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }

}
