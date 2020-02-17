import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trip/model/common_model.dart';

// 创建首页上方导航列表组件

// 定义名称 当前组件为纯展示无状态无交互 所以使用 StatelessWidget 更合适
class LocalNav extends StatelessWidget {
  // 接收传入的数据
  final List<CommonModel> localNavList;
  // 构造方法
  const LocalNav({Key key, @required this.localNavList}) : super(key: key);

  // 重写 build 方法
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: Colors.white,
        // 圆角
        borderRadius: BorderRadius.all(
          Radius.circular(6),
        )
      ),
      child: Padding(
        padding: EdgeInsets.all(7),
        child: _items(context),
      ),
    );
  }
  _items(BuildContext context){
    if(localNavList == null) return null;
    List<Widget> items = [];
    localNavList.map((model){
      items.add(_item(context,model));
    });
  }
  Widget _item(BuildContext context,CommonModel model){
    // 让每个组件可以点击 使用 GestureDetector 组件
    return GestureDetector(
      onTap: (){

      },
      child: Column(
        children: <Widget>[
          Image.network(
            model.icon,
            width: 32,
            height: 32,
          )
        ],
      ),
    );

  }
}
