import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// 照相和图片上传

class ImagePickerPage extends StatefulWidget {
  ImagePickerPage({Key key}) : super(key: key);

  @override
  _ImagePickerPageState createState() => _ImagePickerPageState();
}

class _ImagePickerPageState extends State<ImagePickerPage> {
  File _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ImagePicker 拍照、上传'),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                onPressed: _takePhoto,
                child: Text('拍照'),
              ),
              RaisedButton(
                onPressed: _openGallery,
                child: Text('选择照片'),
              ),
              _buildImage()
            ],
          ),
        ));
  }

  // 拍照
  _takePhoto() async {
    // 最好配置照片大小，以防止照片过大 好几M
    var image =
        await ImagePicker.pickImage(source: ImageSource.camera, maxWidth: 400);

    setState(() {
      _image = image;
    });
    // 上传图片
    this._uploadImage(image);
  }

  // 相册
  _openGallery() async {
    var image =
        await ImagePicker.pickImage(source: ImageSource.gallery, maxWidth: 400);

    setState(() {
      _image = image;
    });
  }

  // 定义组件 显示图片
  Widget _buildImage() {
    if (_image == null) {
      return Text('请选择图片');
    }
    return Image.file(this._image);
  }

  // 上传图片 _imageDir:本地文件路径
  _uploadImage(_imageDir) async {
    FormData formData = new FormData.from({
      "name": "wendo",
      "age": 16,
      "file": new UploadFileInfo(_imageDir, "xxx.jpg"),
    });
    //  Dio().post('远程地址',data:'上传的文件')
    var response = await Dio().post("http://jd.itying.com/imgupload", data: formData);
    print(response);
  }
}
