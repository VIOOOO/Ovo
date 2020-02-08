import 'dart:ffi';

import 'package:flutter/material.dart';

class RadioDemo extends StatefulWidget {
  RadioDemo({Key key}) : super(key: key);

  @override
  _RadioDemoState createState() => _RadioDemoState();
}

class _RadioDemoState extends State<RadioDemo> {
  int sex = 1;
  bool flag = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Radio'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            // Row(
            //   children: <Widget>[
            //     Text('男'),
            //     // 单选按钮选 只能选中一个, 所以一个按钮组 监听同一个变量值
            //     Radio(
            //       value: 1,
            //       groupValue: this.sex,
            //       onChanged: (v) {
            //         setState(() {
            //           this.sex = v;
            //         });
            //       },
            //     ),
            //     SizedBox(width: 20),
            //     Text('女'),
            //     Radio(
            //       value: 2,
            //       groupValue: this.sex,
            //       onChanged: (v) {
            //         setState(() {
            //           this.sex = v;
            //         });
            //       },
            //     ),
            //   ],
            // ),
            // Row(
            //   children: <Widget>[
            //     Text("${this.sex}"),
            //     Text(this.sex == 1 ? " 男" : " 女")
            //   ],
            // ),
            SizedBox(height: 40),
            RadioListTile(
              value: 1,
              groupValue: this.sex,
              onChanged: (v) {
                setState(() {
                  this.sex = v;
                });
              },
              title: Text("标题"),
              subtitle: Text("副标题"),
              // 图标
              secondary: Icon(Icons.help),
              // 文字高亮
              selected: this.sex == 1,
            ),
            RadioListTile(
              value: 2,
              groupValue: this.sex,
              onChanged: (v) {
                setState(() {
                  this.sex = v;
                });
              },
              title: Text("标题"),
              subtitle: Text("副标题"),
              // 图片
              secondary: Image.network(
                'https://ossweb-img.qq.com/upload/adw/image/20200120/68498e64124410e35d8c4f1e85a9a790.jpeg',
                fit: BoxFit.cover,
              ),
              // 文字高亮
              selected: this.sex == 2,
            ),
            SizedBox(height:20),
            Text('Switch 开关'),
            Switch(value: this.flag, onChanged: (v){
              setState(() {
                this.flag = v;
              });
            },)
          ],
        ),
      ),
    );
  }
}
