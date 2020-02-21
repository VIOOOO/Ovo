import 'package:flutter/material.dart';

import 'package:package_info/package_info.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:open_file/open_file.dart';

// APP更新
class AppVersionPage extends StatefulWidget {
  AppVersionPage({Key key}) : super(key: key);

  @override
  _AppVersionPageState createState() => _AppVersionPageState();
}

class _AppVersionPageState extends State<AppVersionPage> {
  @override
  void initState() {
    super.initState();

    this._getPackageInfo();

    this._getAppPath();
  }

  // 弹出 Dialog
  _showDialog() async {
    var alertRel = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("更新APP提示!"),
            content: Text("发现新的版本，新版本修复了如下bug 是否更新!"),
            actions: <Widget>[
              FlatButton(
                child: Text("否"),
                onPressed: () {
                  Navigator.pop(context, 'Cancle');
                },
              ),
              FlatButton(
                child: Text("是"),
                onPressed: () {
                  Navigator.pop(context, 'Ok');
                },
              )
            ],
          );
        });
  }

  // 获取版本号
  _getPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;

    print("appName 应用名称:${appName}");
    print("packageName 版本号:${packageName}");
    // version 版本对应配置表内 versionName
    print("version 版本:${version}");
    // version 版本对应配置表内 versionCode
    print("buildNumber:${buildNumber}");
  }

  // 获取文件本地存储路径
  _getAppPath() async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    var directory = await getExternalStorageDirectory();
    String storageDirectory = directory.path;

    print("tempPath 临时目录:${tempPath}");
    print("appDocDir 应用安装目录:${appDocPath}");
    print("StorageDirectory 存储卡路径:${storageDirectory}");
  }

  // 下载文件
  _downLoad() async {
    final directory = await getExternalStorageDirectory();
    String _localPath = directory.path;
    final taskId = await FlutterDownloader.enqueue(
      // 远程 APK地址 android 9.0 以后的版本需要 https 请求数据和下载数据
      url: "http://www.ionic.wang/jdshop.apk",
      // 需要写本地存储路径
      savedDir: _localPath,
      // 是否显示下载通知
      showNotification:
          true, // show download progress in status bar (for Android)
      // 是否下载完成后可以点击打开应用
      openFileFromNotification:
          true, // click on notification to open downloaded file (for Android)
    );

    // 监听下载进度
    FlutterDownloader.registerCallback((id, status, progress) {
      print(status);
      // code to update your UI
      print('1111111');
      print(progress);
    });

    //打开文件 apk 下载路径上的名称应该与远程地址 url 配置的 APK名字一致
    OpenFile.open("${_localPath}/jdshop.apk");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 下载用的 浮动按钮
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_downward),
        onPressed: _downLoad,
      ),
      appBar: AppBar(
        title: Text('App升级演示'),
      ),
      body: Center(
        child: Text("App升级演示"),
      ),
    );
  }
}
