import 'package:flutter/material.dart';


// 多种类型类型  简单类型 复杂多级列表 网格布局

void main() => runApp(MyApp());
// 静态类型 简单列表 网格布局
const CITY_NAMES = [
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

// 多级 手风琴 ExpansionTile 多级展开列表
const CITY_NAMES_EX = {
  '河北省': [
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
    '衡水市'
  ],
  '山西省': [
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
  ],
  '辽宁省': [
    '沈阳市',
    '大连市',
    '鞍山市',
    '抚顺市',
    '本溪市',
    '丹东市',
    '锦州市',
    '营口市',
    '阜新市',
    '辽阳市',
    '盘锦市',
    '铁岭市',
    '朝阳市',
    '葫芦岛市'
  ],
  '吉林省': ['长春市', '吉林市', '四平市', '辽源市', '通化市', '白山市', '松原市', '白城市', '延边朝鲜族自治州'],
  '河南省': [
    '郑州市',
    '开封市',
    '洛阳市',
    '平顶山市',
    '安阳市',
    '鹤壁市',
    '新乡市',
    '焦作市',
    '濮阳市',
    '许昌市',
    '漯河市',
    '三门峡市',
    '南阳市',
    '商丘市',
    '信阳市',
    '周口市',
    '驻马店市',
    '济源市'
  ],
  '江苏省': [
    '南京市',
    '无锡市',
    '徐州市',
    '常州市',
    '苏州市',
    '南通市',
    '连云港市',
    '淮安市',
    '盐城市',
    '扬州市',
    '镇江市',
    '泰州市',
    '宿迁市'
  ],
  '浙江省': [
    '杭州市',
    '宁波市',
    '温州市',
    '嘉兴市',
    '湖州市',
    '绍兴市',
    '金华市',
    '衢州市',
    '舟山市',
    '台州市',
    '丽水市'
  ],
  '安徽省': [
    '合肥市',
    '芜湖市',
    '蚌埠市',
    '淮南市',
    '马鞍山市',
    '淮北市',
    '铜陵市',
    '安庆市',
    '黄山市',
    '滁州市',
    '阜阳市',
    '宿州市',
    '巢湖市',
    '六安市',
    '亳州市',
    '池州市',
    '宣城市'
  ],
  '福建省': ['福州市', '厦门市', '莆田市', '三明市', '泉州市', '漳州市', '南平市', '龙岩市', '宁德市']
};

// 列表 ListView 垂直 或 水平布局

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = '列表类型';

    return MaterialApp(
        title: title,
        home: Scaffold(
          appBar: AppBar(
            title: Text(title),
          ),

          // 默认 垂直滚动
          body: ListView(
            children: _buildList(),
          ),

//      // 水平滚动需要 在列表内设置 滚动方向
//        body: Container(
//          height: 200,  // 水平滚动高度 默认是填满整个区域
//          child:ListView(
//            scrollDirection: Axis.horizontal,
//            children: _buildList(),
//          ),
//        ),

//          //  多级展开列表
//          body: Container(
//            child: ListView(
//              children: _buildList_ex(),
//            ),
//          ),

          //  网格布局
//          body: GridView.count(
//            crossAxisCount: 3,  // 一行内 几列
//            children: _buildList(),
//          ),
        ));
  }


//  简单列表 网格列表
List<Widget> _buildList() {
  return CITY_NAMES.map((city) => _item(city)).toList();
}

Widget _item(String city) {
  return Container(
//    width: 160, // 水平滚动样式 默认自身宽度
    height: 80, //网格布局 垂直滚动样式 水平滚动高度需要在外部对整个列表设置高度
    margin: EdgeInsets.only(bottom: 5), // 网格布局 垂直滚动样式
//    margin: EdgeInsets.only(right: 5), // 水平滚动样式 右间距
    alignment: Alignment.center, // 居中方式
    decoration: BoxDecoration(color: Colors.teal), // 装饰器
    child: Text(
      city,
      style: TextStyle(color: Colors.white, fontSize: 20),
    ),
  );
}

//// 多级展开列表
//List<Widget> _buildList_ex() {
//  List<Widget> widgets = [];
//  CITY_NAMES_EX.keys.forEach((key) {
//    widgets.add(_item(key, CITY_NAMES_EX[key]));
//  });
//  return widgets;
//}
//
//Widget _item(String city, List<String> subCities) {
//  return ExpansionTile(
//    title: Text(
//      city,
//      style: TextStyle(color: Colors.black54, fontSize: 20),
//    ),
//    children: subCities.map((subCity) => _buildSub(subCity)).toList(),
//  );
//}
//
//Widget _buildSub(String subCity) {
//  return FractionallySizedBox(
//    // 让宽度撑满  实用可伸缩组件
//    widthFactor: 1, // 宽度撑满
//    child: Container(
//      height: 50,
//      margin: EdgeInsets.only(bottom: 5),
//      decoration: BoxDecoration(color: Colors.lightBlueAccent),
//      child: Text(subCity),
//    ),
//  );
//}

}