import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';

class DatePickerDemo extends StatefulWidget {
  DatePickerDemo({Key key}) : super(key: key);

  @override
  _DatePickerDemoState createState() => _DatePickerDemoState();
}

class _DatePickerDemoState extends State<DatePickerDemo> {
  // var now = DateTime.now();

  DateTime _nowDate = DateTime.now();
  var _nowTime = TimeOfDay(hour: 12, minute: 20);

  // 封装时间日期组件方法
  _showDatePicker() async {
    // showDatePicker(
    //   context: context,
    //   // 初始化日期
    //   initialDate: _nowDate,
    //   // 起始日期
    //   firstDate: DateTime(1980),
    //   // 结束日期
    //   lastDate: DateTime(2100),
    // ).then((result) {
    //   print(result);
    // });

    var result = await showDatePicker(
      context: context,
      // 初始化日期
      initialDate: _nowDate,
      // 起始日期
      firstDate: DateTime(1980),
      // 结束日期
      lastDate: DateTime(2100),
      // // 设置语言 非必须 需要首先配置多语言
      // locale: Locale('zh')
    );
    // print(result);

    setState(() {
      this._nowDate = result;
    });
  }

  _showTimePicker() async {
    var result = await showTimePicker(
      context: context,
      initialTime: _nowTime,
    );
    setState(() {
      this._nowTime = result;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // print(this.now);  // 2020-02-08 16:54:57.923463
    // // 将日期转换成时间戳
    // print(this.now.millisecondsSinceEpoch); // 1581152188204

    // // 将时间戳转回日期
    // print(DateTime.fromMillisecondsSinceEpoch(1581152188204));  // 2020-02-08 16:56:28.204

    // // 格式化当前时间 修改为带中文日期
    // print(formatDate(DateTime.now(), [yyyy, '年', mm, '月', dd, '日']));  // 2020年02月08日
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DatePicker 日期库组件'),
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
                      "${formatDate(_nowDate, [yyyy, '年', mm, '月', dd, '日'])}"),
                  Icon(Icons.arrow_drop_down),
                ],
              ),
              onTap: _showDatePicker,
            ),
            InkWell(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("${_nowTime.format(context)}"),
                  Icon(Icons.arrow_drop_down),
                ],
              ),
              onTap: _showTimePicker,
            ),
          ]),
        ],
      ),
    );
  }
}
