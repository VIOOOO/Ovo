// 创建模块 列表
class CommonModel {
  // 根据接口定义接收的参数
  final String icon;
  final String title;
  final String url;
  final bool hideAppBar;

  // 构造方法
  CommonModel({this.title, this.url, this.hideAppBar, this.icon});

  // 工厂方法
  factory CommonModel.fromJson(Map<String, dynamic> json) {
    return CommonModel(
      icon: json['icon'],
      title: json['title'],
      url: json['url'],
      hideAppBar: json['hideAppBar'],
    );
  }
}
