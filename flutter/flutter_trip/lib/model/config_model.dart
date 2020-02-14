// 创建模块
class ConfigModel {
  // 根据接口定义接收的参数
  final String searchUrl;

  // 构造方法
  ConfigModel({this.searchUrl});

  // 工厂方法
  factory ConfigModel.fromJson(Map<String, dynamic> json) {
    return ConfigModel(searchUrl: json['searchUrl']);
  }

  // 反向json 方法
  Map<String, dynamic> toJson(){
    return {searchUrl:searchUrl};
  }
}
