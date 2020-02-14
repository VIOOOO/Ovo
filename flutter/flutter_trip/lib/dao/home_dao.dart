import 'dart:async';
import 'dart:convert';
import 'package:flutter_trip/model/home_model.dart';
import 'package:http/http.dart' as http;

const Home_URL = 'https://www.devio.org/io/flutter_app/json/home_page.json';

// 首页大接口
class HomeDao {
  static Future<HomeModel> fetch() async {
    final response = await http.get(Home_URL);
    if(response.statusCode == 200){
      // 避免 json 内中文字符出现乱码
      Utf8Decoder utf8decoder = Utf8Decoder();
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return HomeModel.fromJson(result);
    }else{
      // 报错处理
      throw Exception("网络异常");
    }
  }
}
