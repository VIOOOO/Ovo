import 'package:flutter/material.dart';

// 引入要跳转的页面
import '../Form.dart';

// 分类页
class CategoryPage extends StatefulWidget {
  CategoryPage({Key key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RaisedButton(
          child: Text('跳转到表单页面并传值'),
          onPressed: () {
            // 基本路由跳转方式 传值
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => FormPage(title: '跳转传值123',),
              ),
            );
          },
          // color: Theme.of(context).accentColor,
          // textTheme: ButtonTextTheme.primary,
        ),
      ],
    );
  }
}
