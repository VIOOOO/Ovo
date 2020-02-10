import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpDemo extends StatefulWidget {
  HttpDemo({Key key}) : super(key: key);

  @override
  _HttpDemoState createState() => _HttpDemoState();
}

class _HttpDemoState extends State<HttpDemo> {
  List _list = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // 页面加载时候请求数据
    this._getData();
  }

  _getData() async {
    // var apiUrl = "https://www.runoob.com/try/ajax/getcustomer.php?q=Google";
    // var apiUrl = "https://www.googleapis.com/books/v1/volumes?q={http}";
    var apiUrl =
        "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";
    var result = await http.get(apiUrl);
    if (result.statusCode == 200) {
      print(json.decode(result.body));
      setState(() {
        this._list = json.decode(result.body)['pokemon'];

        // body数据
        // "pokemon": [
        //   {
        //     "id": 1,
        //     "num": "001",
        //     "name": "Bulbasaur",
        //     "img": "http://www.serebii.net/pokemongo/pokemon/001.png",
        //   },
        //   {
        //     "id": 2,
        //     "num": "002",
        //     "name": "Ivysaur",
        //     "img": "http://www.serebii.net/pokemongo/pokemon/002.png",
        //   }
        // ];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('请求数据 Demo'),
      ),
      body: this._list.length > 0
          ? ListView(
              children: this._list.map((value) {
                return ListTile(
                  title: Text(value['name']),
                );
              }).toList(),
            )
          : Text('加载中...'),
    );
  }
}
