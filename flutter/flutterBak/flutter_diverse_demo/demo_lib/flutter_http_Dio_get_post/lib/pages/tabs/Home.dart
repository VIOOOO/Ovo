import 'package:flutter/material.dart';

import 'package:dio/dio.dart';

// 首页
class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // @override
  // void initState() {
  //   super.initState();
  //   this._getData();
  // }

  // 请求数据
  _getData() async {
    var apiUrl =
        "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";
    // 实例化 Dio
    Response response = await Dio().get(apiUrl);
    print(response);
  }

  // 提交数据
  _postData() async {
    Map jsonData = {'name': 'doodle', 'color': 'blue'};
    var apiUrl = "https://example.com/whatsit/create";
    Response response = await Dio().post(apiUrl, data: jsonData);
    print(response);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            child: Text('Dio Get 请求数据'),
            onPressed: _getData,
          ),
          SizedBox(height: 20),
          RaisedButton(
            child: Text('Dio Post 提交数据'),
            onPressed: _postData,
          ),
          SizedBox(height: 20),
          RaisedButton(
            child: Text('Dio Get 请求、渲染数据演示 Dome'),
            onPressed: () {
              Navigator.pushNamed(context, '/http');
            },
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
