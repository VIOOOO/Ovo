import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HttpDemo extends StatefulWidget {
  HttpDemo({Key key}) : super(key: key);

  @override
  _HttpDemoState createState() => _HttpDemoState();
}

class _HttpDemoState extends State<HttpDemo> {
  List _list = [];

  @override
  void initState() {
    super.initState();
    this._getData();
  }

  _getData() async {
    var apiUrl =
        "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";
    // 看数据类型是否需要转换
    Response response = await Dio().get(apiUrl);
    // print(json.decode(response.data)["pokemon"]);
    setState(() {
      this._list = json.decode(response.data)["pokemon"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('请求数据 Demo'),
      ),
      // ListView Builder 方式
      body: this._list.length > 0
          ? ListView(
              children: this._list.map((value) {
                return ListTile(
                  title: Text(value["name"]),
                );
              }).toList(),
            )
          : Text('加载中...'),
    );
  }
}
