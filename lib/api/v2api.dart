import 'package:dio/dio.dart';
import 'package:flustars/flustars.dart';

class V2API {
  /**
   * 获取 `v2ex` 热门主题
   */
  static Future<List> getHot() async {
    try {
      Response res = await Dio().get("https://www.v2ex.com/api/topics/hot.json");
//      LogUtil.e(res);
      print('接收到了热门主题');
      List _data = res.data;
      return _data;
    } catch (e) {
      LogUtil.e(e);
      return [];
    }
  }
}