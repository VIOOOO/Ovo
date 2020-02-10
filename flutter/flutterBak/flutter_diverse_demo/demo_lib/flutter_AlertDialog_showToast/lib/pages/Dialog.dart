import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DialogPage extends StatefulWidget {
  DialogPage({Key key}) : super(key: key);

  @override
  _DialogPageState createState() => _DialogPageState();
}

class _DialogPageState extends State<DialogPage> {
  _alertDialog() async {
    var result = await showDialog(
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
                  Navigator.pop(context, 'Cancle');
                },
              ),
              FlatButton(
                child: Text('确定'),
                onPressed: () {
                  print("确定");
                  // 关闭弹窗
                  Navigator.pop(context, 'ok');
                },
              ),
            ],
          );
        });
    print(result);
  }

  // select 选择弹窗
  _simpleDialog() async {
    var result = await showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text('选择内容'),
          children: <Widget>[
            SimpleDialogOption(
              child: Text('Option A'),
              onPressed: () {
                print('Option A');
                // 关闭弹窗
                Navigator.pop(context, 'A');
              },
            ),
            // 线
            Divider(),
            SimpleDialogOption(
              child: Text('Option B'),
              onPressed: () {
                print('Option B');
                // 关闭弹窗
                Navigator.pop(context, 'B');
              },
            ),
            // 线
            Divider(),
            SimpleDialogOption(
              child: Text('Option C'),
              onPressed: () {
                print('Option C');
                // 关闭弹窗
                Navigator.pop(context, 'C');
              },
            ),
          ],
        );
      },
    );
    print(result);
  }

  // 底部弹出框
  _modelBottomSheet() async {
    var result = await showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 250,
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text('分享 1'),
                onTap: () {
                  // 关闭弹窗
                  Navigator.pop(context, '分享 1');
                },
              ),
              Divider(),
              ListTile(
                title: Text('分享 2'),
                onTap: () {
                  // 关闭弹窗
                  Navigator.pop(context, '分享 2');
                },
              ),
              Divider(),
              ListTile(
                title: Text('分享 3'),
                onTap: () {
                  // 关闭弹窗
                  Navigator.pop(context, '分享 3');
                },
              ),
            ],
          ),
        );
      },
    );
    print(result);
  }

  // 消息提示窗
  _toast() {
    Fluttertoast.showToast(
      msg: "提示信息",
      // 长度
      toastLength: Toast.LENGTH_LONG,
      // 显示位置
      gravity: ToastGravity.TOP,
      // 显示时间 只有IOS 有效
      timeInSecForIos: 3,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

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
