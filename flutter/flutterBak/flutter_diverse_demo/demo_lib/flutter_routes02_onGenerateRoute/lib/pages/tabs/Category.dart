import 'package:flutter/material.dart';

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
          child: Text('跳转到表单页面'),
          onPressed: () {
            // 命名路由跳转
            Navigator.pushNamed(context, '/form');
          },
          // color: Theme.of(context).accentColor,
          // textTheme: ButtonTextTheme.primary,
        ),
      ],
    );
  }
}
