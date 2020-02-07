import 'dart:io';

import 'package:flutter/material.dart';

class ButtonPage extends StatefulWidget {
  ButtonPage({Key key}) : super(key: key);

  @override
  _ButtonPageState createState() => _ButtonPageState();
}

class _ButtonPageState extends State<ButtonPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('溢出凸起按钮 FloatingActionButton'),
        actions: <Widget>[
          // 图标按钮
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      // 底部导航浮动按钮 溢出凸起按钮
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.black,
          size: 40,
        ),
        onPressed: () {
          print('FloatingActionButton');
        },
        backgroundColor: Colors.yellow,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: ListView(
        children: <Widget>[
          Column(
            // 纵居中
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('RaisedButton:凸起的按钮'),
              Row(
                // 水平居中
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    child: Text('普通按钮'),
                    onPressed: () {
                      print('普通按钮');
                    },
                  ),
                  SizedBox(width: 10),
                  RaisedButton(
                    child: Text('有色按钮'),
                    color: Colors.blue,
                    textColor: Colors.white,
                    onPressed: () {
                      print('有色按钮');
                    },
                  ),
                  SizedBox(width: 10),
                  RaisedButton(
                    child: Text('有阴影按钮'),
                    color: Colors.blue,
                    textColor: Colors.white,
                    // 阴影效果 值越大阴影越大
                    elevation: 10,
                    onPressed: () {
                      print('有阴影按钮');
                    },
                  ),
                  SizedBox(width: 10),
                  RaisedButton.icon(
                    icon: Icon(Icons.search),
                    label: Text('图标按钮'),
                    color: Colors.green,
                    textColor: Colors.white,
                    // // 无监听事件 设置为 null 时当前图标会被禁用，无法点击，颜色无法设置
                    // onPressed: null,
                    onPressed: () {},
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // 在按钮外包裹 Container 设置宽高
                  Container(
                    height: 50,
                    width: 200,
                    child: RaisedButton(
                      child: Text('设宽高按钮'),
                      color: Colors.blue,
                      textColor: Colors.white,
                      // 阴影效果
                      elevation: 20,
                      onPressed: () {
                        print('设宽高按钮');
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // 在按钮外包裹 Expanded flex 实现宽度自适应
                  // 再嵌套 Container 设置 高度 margin 等
                  Expanded(
                    child: Container(
                      height: 60,
                      margin: EdgeInsets.all(10),
                      child: RaisedButton(
                        child: Text('自适应按钮'),
                        color: Colors.blue,
                        textColor: Colors.white,
                        // 阴影效果
                        elevation: 20,
                        onPressed: () {
                          print('自适应按钮');
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    child: Text('圆角按钮'),
                    color: Colors.blue,
                    textColor: Colors.white,
                    // 阴影效果
                    elevation: 20,
                    // 圆角
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onPressed: () {
                      print('圆角按钮');
                    },
                  ),
                  SizedBox(width: 10),
                  Container(
                    height: 80,
                    child: RaisedButton(
                      child: Text('圆形按钮'),
                      color: Colors.blue,
                      textColor: Colors.white,
                      // 阴影效果
                      elevation: 20,
                      // 水波纹颜色 长按
                      splashColor: Colors.red,
                      // 圆形
                      shape: CircleBorder(
                        side: BorderSide(
                          color: Colors.red,
                        ),
                      ),
                      onPressed: () {
                        print('圆形按钮');
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Text('FlatButton:扁平化的按钮'),
              Row(
                // 水平居中
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    child: Text('扁平按钮'),
                    color: Colors.purple,
                    textColor: Colors.yellow,
                    onPressed: () {
                      print('扁平按钮');
                    },
                  ),
                ],
              ),
              SizedBox(height: 30),
              Text('OutlineButton: 线框的按钮'),
              Row(
                // 水平居中
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  OutlineButton(
                    child: Text('边框按钮'),
                    // 无法改变背景色，默认白色，可以设置字体颜色
                    textColor: Colors.redAccent,
                    onPressed: () {
                      print('边框按钮');
                    },
                  ),
                ],
              ),
              SizedBox(height: 30),
              Text('IconButton: 图标按钮'),
              Row(
                // 水平居中
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.settings),
                    color: Colors.purple,
                    onPressed: () {
                      print('图标按钮');
                    },
                  ),
                ],
              ),
              SizedBox(height: 30),
              Text('ButtonBar: 按钮组'),
              Row(
                // 水平居中
                // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ButtonBar(
                    children: <Widget>[
                      RaisedButton(
                        child: Text('有色按钮'),
                        color: Colors.blue,
                        textColor: Colors.white,
                        onPressed: () {
                          print('有色按钮');
                        },
                      ),
                      RaisedButton(
                        child: Text('有色按钮'),
                        color: Colors.blue,
                        textColor: Colors.white,
                        onPressed: () {
                          print('有色按钮');
                        },
                      ),
                      RaisedButton(
                        child: Text('有色按钮'),
                        color: Colors.blue,
                        textColor: Colors.white,
                        onPressed: () {
                          print('有色按钮');
                        },
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 30),
              Text('自定义按钮'),
              Row(
                // 水平居中
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  MyButton(
                    text: '自定义按钮',
                    width: 100,
                    height: 60,
                    pressed: () {
                      print('自定义按钮');
                    },
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

// 自定义按钮组件

class MyButton extends StatelessWidget {
  final text;
  final pressed;
  final double width;
  final double height;
  const MyButton({
    this.text = '',
    this.width = 80.0,
    this.height = 30.0,
    this.pressed = null,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.width,
      height: this.height,
      child: RaisedButton(
        child: Text(this.text),
        onPressed: this.pressed,
      ),
    );
  }
}
