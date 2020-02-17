import 'package:flutter/cupertino.dart';
import 'package:flutter_trip/model/grid_nav_model.dart';

// 创建首页上方导航列表组件

// 定义名称 当前组件为纯展示无状态无交互 所以使用 StatelessWidget 更合适
class GridNav extends StatelessWidget {

  // 接收传入的数据
  final GridNavModel gridNavModel;
  // 构造方法
  const GridNav({Key key, @required this.gridNavModel}) : super(key: key);

  // 重写 build 方法
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("ddd"),
    );
  }
}