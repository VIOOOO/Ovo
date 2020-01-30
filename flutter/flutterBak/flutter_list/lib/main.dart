import 'package:flutter/material.dart';
import 'res/listData.dart';

void main() {
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Demo 列表 网格布局'),
        ),
        body: LayoutDemo(),
      ),
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}


// 动态 网格布局 03
class LayoutDemo extends StatelessWidget {
  Widget _getListData(context, index) {
    return Container(
      child: Column(
        children: <Widget>[
          Image.network(listData[index]["imageUrl"]),
          SizedBox(height: 30), // 让图片和文字间有些距离
          Text(
            listData[index]["title"],
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
      decoration: BoxDecoration(
          border:
              Border.all(color: Color.fromRGBO(233, 233, 233, 0.9), width: 1)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        // 设置网格属性
        crossAxisSpacing: 10.0, //左右距离
        mainAxisSpacing: 10.0, // 上下距离
        crossAxisCount: 2, // 网格几列
      ),
      itemCount: listData.length,
      itemBuilder: this._getListData,
    );
  }
}

// // 静态 网格布局 02
// class LayoutDemo extends StatelessWidget {
//   List<Widget> _getListData() {
//     var tempList = listData.map((value) {
//       return Container(
//         child: Column(
//           children: <Widget>[
//             Image.network(value["imageUrl"]),
//             SizedBox(height: 30), // 让图片和文字间有些距离
//             Text(
//               value["title"],
//               textAlign: TextAlign.center,
//               style: TextStyle(fontSize: 20),
//             ),
//           ],
//         ),
//         decoration: BoxDecoration(
//             border: Border.all(
//                 color: Color.fromRGBO(233, 233, 233, 0.9), width: 1)),
//       );
//     });
//     return tempList.toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GridView.count(
//       crossAxisSpacing: 10.0, //左右距离
//       mainAxisSpacing: 10.0, // 上下距离
//       padding: EdgeInsets.all(10), // 左右最外边距离
//       crossAxisCount: 2, // 网格几列
//       // childAspectRatio: 0.6, //宽度和高度比例，因设置不了高度，可以适用该元素调节剂 X 轴与 Y 轴的比例
//       children: this._getListData(),
//     );
//   }
// }

// // 静态 网格布局 01
// class LayoutDemo extends StatelessWidget {

//   List<Widget> _getListData() {
//     List<Widget> list = new List();
//     for(var i=0; i<20;i++){
//       list.add(Container(
//         alignment: Alignment.center,  //元素属性居中
//         child: Text(
//           '这是第$i条元素',
//           style:TextStyle(color:Colors.white,fontSize:20),
//         ),
//         color: Colors.blue,
//       ));
//     }
//     return list;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GridView.count(
//       crossAxisSpacing: 20.0, //左右各20距离
//       mainAxisSpacing: 20.0, // 上下各20
//       padding: EdgeInsets.all(10), // 左右最外边距离
//       crossAxisCount: 3,  // 网格几列
//       childAspectRatio: 0.6, //宽度和高度比例，因设置不了高度，可以适用该元素调节剂 X 轴与 Y 轴的比例
//       children: this._getListData(),
//     );
//   }
// }
