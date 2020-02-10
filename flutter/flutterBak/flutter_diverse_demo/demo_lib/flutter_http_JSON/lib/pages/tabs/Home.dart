import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

// 首页
class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _news = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // Map userInfo = {"username": "长得", "age": 20};
    // // 将 Map 类型转换为 json数据
    // var a = json.encode(userInfo);
    // print(userInfo is Map);
    // print(a is String);

    // String userinfo = '{"username": "李四", "age": 18}';
    // // 把 json 字符串转换成 Map 类型
    // Map u = json.decode(userinfo);
    // print(u["username"]);
  }

  // 请求数据
  _getData() async {
    var apiUrl = "https://www.googleapis.com/books/v1/volumes/g_1SAAAAMAAJ";
    var result = await http.get(apiUrl);
    if (result.statusCode == 200) {
      // print(result.body);
      setState(() {
        this._news = json.decode(result.body)['volumeInfo']['title'];
      });
    } else {
      print(result.statusCode);
    }
  }

  // 提交数据
  _postData() async {
    var apiUrl = "https://example.com/whatsit/create";
    var result = await http.post(
      apiUrl,
      body: {'name': 'doodle', 'color': 'blue'},
    );
    if (result.statusCode == 200) {
      print(json.decode(result.body));
      // setState(() {
      //   this._news = json.decode(result.body)['volumeInfo']['title'];
      // });
    } else {
      print(result.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(this._news),
          RaisedButton(
            child: Text('Get 请求数据'),
            onPressed: _getData,
          ),
          SizedBox(height: 20),
          RaisedButton(
            child: Text('Post 提交数据'),
            onPressed: _postData,
          ),
          SizedBox(height: 20),
          RaisedButton(
            child: Text('Get 请求、渲染数据演示 Dome'),
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
