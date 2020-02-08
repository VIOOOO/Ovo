import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CheckBoxDemo extends StatefulWidget {
  CheckBoxDemo({Key key}) : super(key: key);

  @override
  _CheckBoxDemoState createState() => _CheckBoxDemoState();
}

class _CheckBoxDemoState extends State<CheckBoxDemo> {
  var flag = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CheckBox 多选框组件'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            children: <Widget>[
              Checkbox(
                // 选中为 true
                value: this.flag,
                // 不监听 onChanged 改变 改选项框会被禁用
                onChanged: (val) {
                  setState(() {
                    this.flag = val;
                  });
                },
                // 选中的颜色
                activeColor: Colors.red,
                
              )
            ],
          ),
          Row(
            children: <Widget>[
              Text(this.flag ? "选中" : "未选中"),
            ],
          ),
          SizedBox(height: 40),
          // CheckboxListTile(
          //   value: this.flag,
          //   onChanged: (val) {
          //     setState(() {
          //       this.flag = val;
          //     });
          //   },
          //   title: Text("标题"),
          //   subtitle: Text("副标题"),
          // ),
          // 横线
          Divider(),
          CheckboxListTile(
            value: this.flag,
            onChanged: (val) {
              setState(() {
                this.flag = val;
              });
            },
            title: Text("标题"),
            subtitle: Text("副标题"),
            // 图标
            secondary: Icon(Icons.help),
            // 文字高亮
            selected: this.flag,
          )
        ],
      ),
    );
  }
}
