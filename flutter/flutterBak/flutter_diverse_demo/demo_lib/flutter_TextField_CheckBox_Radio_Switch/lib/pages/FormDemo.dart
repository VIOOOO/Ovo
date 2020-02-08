import 'package:flutter/material.dart';

class FormDemoPage extends StatefulWidget {
  FormDemoPage({Key key}) : super(key: key);

  @override
  _FormDemoPageState createState() => _FormDemoPageState();
}

class _FormDemoPageState extends State<FormDemoPage> {
  String _username;
  int sex;
  String info = '';

  List hobby = [
    {
      "checked": true,
      "title": "吃饭",
    },
    {
      "checked": true,
      "title": "睡觉",
    },
    {
      "checked": false,
      "title": "放屁",
    },
  ];

  List<Widget> _getHobby() {
    // 定义一个临时数组
    List<Widget> tempList = [];
    //循环添加 多选组件
    for (var i = 0; i < this.hobby.length; i++) {
      tempList.add(
        Row(
          children: <Widget>[
            Text(this.hobby[i]["title"] + ": "),
            Checkbox(
              value: this.hobby[i]["checked"],
              onChanged: (value) {
                setState(() {
                  this.hobby[i]["checked"] = value;
                });
              },
            ),
          ],
        ),
      );
    }
    return tempList;
  }

  void _sexChanged(value) {
    setState(() {
      this.sex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('学员登记系统'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                hintText: "请输入用户信息",
              ),
              onChanged: (value) {
                this._username = value;
              },
            ),
            Row(
              children: <Widget>[
                Text('男:'),
                Radio(
                  value: 1,
                  groupValue: this.sex,
                  onChanged: this._sexChanged,
                ),
                SizedBox(width: 30),
                Text('女:'),
                Radio(
                  value: 2,
                  groupValue: this.sex,
                  onChanged: this._sexChanged,
                ),
              ],
            ),

            // 爱好
            SizedBox(height: 40),
            Column(
              children: this._getHobby(),
            ),
            TextField(
              // 显示最大4行
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "请输入描述",
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                this.info = value;
              },
            ),
            SizedBox(height: 40),
            Container(
              width: double.infinity,
              height: 40,
              child: RaisedButton(
                child: Text('提交信息'),
                onPressed: () {
                  print(this._username);
                  print(this.sex);
                  print(this.hobby);
                },
                color: Colors.blue,
                textColor: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
