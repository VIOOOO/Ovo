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
          title: Text('Flutter Demo 动态列表'),
        ),
        body: HomeContent(),
      ),
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}

// 动态列表4 ListView.Builder() 循环遍历新增的数据
class HomeContent extends StatelessWidget {
  Widget _getListData(context, index) {
    return ListTile(
      leading: Image.network(listData[index]["imageUrl"]),
      subtitle: Text(listData[index]["author"]),
      title: Text(listData[index]["title"]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listData.length, // 列表长度 必须
      itemBuilder: this._getListData, // 不需要写() ,表示赋值。加()表示执行方法
    );
  }
}

// // 动态列表3 ListView.Builder()
// class HomeContent extends StatelessWidget {

//   List list = new List();
//   // 构造函数
//   HomeContent(){
//     for(var i=0;i<20;i++){
//       this.list.add(
//         ListTile(
//           title: Text('这是第$i列表元素'),
//         )
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: this.list.length, // 列表长度 必须
//       itemBuilder: (context,index){
//         return this.list[index];
//       },
//     );
//   }
// }

// // 动态列表2
// class HomeContent extends StatelessWidget {
//   // 自定义方法
//   List<Widget> _getData() {
//      var tempList = listData.map((value){
//       return ListTile(
//         leading: Image.network(value["imageUrl"]),
//         title: Text(value["title"]),
//         subtitle: Text(value["author"]),
//       );
//     });
//     return tempList.toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       children: this._getData(),
//     );
//   }
// }

// // 动态列表1
// class HomeContent extends StatelessWidget {
//   // 自定义方法
//   List<Widget> _getData() {
//     List<Widget> list = new List();
//     for (var i = 0; i <= 20; i++) {
//       list.add(
//         ListTile(
//           title: Text('这是第${i}个列表'),
//         ),
//       );
//     }
//     return list;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       children: this._getData(),
//     );
//   }
// }
