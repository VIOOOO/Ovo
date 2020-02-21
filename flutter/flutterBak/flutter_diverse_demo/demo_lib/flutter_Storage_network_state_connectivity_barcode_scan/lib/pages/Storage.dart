import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 数据存储

class StoragePage extends StatefulWidget {
  StoragePage({Key key}) : super(key: key);

  @override
  _StoragePageState createState() => _StoragePageState();
}

class _StoragePageState extends State<StoragePage> {
  _saveData() async {
    // 获取实例 赋值给变量 异步方法
    SharedPreferences sp = await SharedPreferences.getInstance();
    // 保存数据 保存过后可以在其他页面获取到保存的数据
    sp.setString("username", "张三1");
    sp.setString("age", "12");
  }

  _getData() async {
    // 获取实例 赋值给变量 异步方法
    SharedPreferences sp = await SharedPreferences.getInstance();
    // 传入 key 获取数值
    print(sp.getString("username"));
    print(sp.getString("age"));
  }

  _removeData() async {
    // 获取实例 赋值给变量 异步方法
    SharedPreferences sp = await SharedPreferences.getInstance();
    // 删除指定数据
    sp.remove("age");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('本地存储'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text("保存数据"),
              onPressed: _saveData,
            ),
            SizedBox(height: 20),
            RaisedButton(
              child: Text("获取数据"),
              onPressed: _getData,
            ),
            SizedBox(height: 20),
            RaisedButton(
              child: Text("清除数据"),
              onPressed: _removeData,
            ),
          ],
        ),
      ),
    );
  }
}
