import 'package:shared_preferences/shared_preferences.dart';

// 封装 本地存储的类
class Storage {
// 封装异步无返回的一个保存方法 ，静态方法 不需要再实例化
  static Future<void> setString(key, value) async {
    // 获取实例 赋值给变量 异步方法
    SharedPreferences sp = await SharedPreferences.getInstance();
    // 保存数据 保存过后可以在其他页面获取到保存的数据
    sp.setString(key, value);
  }

  // 封装 获取数据方法，需要有返回值 String 类型
  static Future<String> getString(key) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    // 获取保存的数据
    return sp.getString(key);
  }

  // 封装 移除数据方法 无返回值
  static Future<void> remove(key) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    // 移除保存的数据
    sp.remove(key);
  }
}
