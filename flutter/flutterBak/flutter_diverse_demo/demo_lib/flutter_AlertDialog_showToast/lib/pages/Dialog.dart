import 'package:flutter/material.dart';

class DialogPage extends StatefulWidget {
  DialogPage({Key key}) : super(key: key);

  @override
  _DialogPageState createState() => _DialogPageState();
}

class _DialogPageState extends State<DialogPage> {
  _alertDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("提示信息！"),
            content: Text("您确定要删除吗"),
            actions: <Widget>[
              FlatButton(
                child: Text('取消'),
                onPressed: () {
                  print("取消");
                  // 关闭弹窗
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text('确定'),
                onPressed: () {
                  print("确定");
                },
              ),
            ],
          );
        });
  }

  _simpleDialog() async {}
  _modelBottomSheet() async {}
  _toast() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dialog'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text('alert 弹出窗-AlertDialog'),
              onPressed: _alertDialog,
            ),
            RaisedButton(
              child: Text('selelct 弹出窗-SimpleDialog'),
              onPressed: _simpleDialog,
            ),
            RaisedButton(
              child: Text('ActionSheet 底部弹出框-showModalBottomSheet'),
              onPressed: _modelBottomSheet,
            ),
            RaisedButton(
              child: Text('toast fluttertoast 第三方库'),
              onPressed: _toast,
            ),
          ],
        ),
      ),
    );
  }
}
