import 'package:dio/dio.dart';


// https://api.vvhan.com/     这里面提供了大量接口,可以方便代码调试.

// 比如: 这个douban接口:  https://api.vvhan.com/douban.html


class AppHomeApi {

  /**
   * 获取首页`banner`图
   */
  static Future<List<String>> getIndexBanners() async {
    List<String> _result = new List<String>();
    try {  // 使用dio库包来发送网络请求.
      Response response = await Dio().get("https://gank.io/api/v2/banners");
      Map<String, dynamic> data = response.data;
      List _data = data['data'];
      List _banners = _data.map((e) => e['image']).toList();
      _result = new List<String>.from(_banners);
    } catch(e) {
      print(e);
    }
    return _result;
  }

  /**
   * 豆瓣接口
   */
  static getDouBanApi() async {
    try { 
      Response res = await Dio().get("https://api.vvhan.com/api/douban");


print(res.data);
print('3333333333333333333333333');
      Map<String, dynamic> _data = res.data;
      List data = _data['data'];
      return data;
    } catch (e) {
      print(e);
    }
  }
  
}