import 'package:flutter/material.dart';

import 'package:date_format/date_format.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';

class DatePickerPubDemo extends StatefulWidget {
  DatePickerPubDemo({Key key}) : super(key: key);

  @override
  _DatePickerPubDemoState createState() => _DatePickerPubDemoState();
}

class _DatePickerPubDemoState extends State<DatePickerPubDemo> {
  DateTime _dateTime = DateTime.now();

  // 查看组件使用方法，或者在案例中找到想使用的组件，直接拷贝代码来修改
  _showDatePicker() async {
    DatePicker.showDatePicker(
      context,
      pickerTheme: DateTimePickerTheme(
        showTitle: true,
        confirm: Text('确定', style: TextStyle(color: Colors.red)),
        cancel: Text('取消', style: TextStyle(color: Colors.cyan)),
      ),
      minDateTime: DateTime.parse("1980-05-12"),
      maxDateTime: DateTime.parse("2100-05-12"),
      // 初始化日期当前时间
      initialDateTime: _dateTime,
      // 格式
      // // 只有年月日
      // dateFormat: "yyyy-MMMM-dd",
      dateFormat: "yyyy年M月d日  EEE,H时:m分", // show TimePicker
      pickerMode: DateTimePickerMode.datetime, // show TimePicker

      // 语言
      locale: DateTimePickerLocale.zh_cn,
      // onClose: () => print("----- onClose -----"),
      onCancel: () => print('onCancel'),
      // // 改变 监听
      // onChange: (dateTime, List<int> index) {
      //   setState(() {
      //     _dateTime = dateTime;
      //   });
      // },

      // 确定 监听
      onConfirm: (dateTime, List<int> index) {
        setState(() {
          _dateTime = dateTime;
        });
      },
    );
  }

  _showTimePicker() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DatePickerPubDemo 第三方库时间组件'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            // 为了监听行内的日期，实现点击，使用组件 InkWell
            InkWell(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "${formatDate(_dateTime, [
                      yyyy,
                      '年',
                      mm,
                      '月',
                      dd,
                      '日 ',
                      HH,
                      ':',
                      nn
                    ])}",
                  ),
                  Icon(Icons.arrow_drop_down),
                ],
              ),
              onTap: _showDatePicker,
            ),
          ]),
        ],
      ),
    );
  }
}
