
import 'package:dio/dio.dart';
import 'dart:math';

class RandomListApi {
  static Future<List> getLists() async {
    try {

      var rng = new Random();

        var tmp=rng.nextInt(100);




        Response res = await Dio().get("https://gank.io/api/v2/random/category/GanHuo/type/Android/count/"+tmp.toString());

        var data = res.data;
      List _lists = data['data'];
//      print(_lists);
      return _lists;
    } catch(err) {
      return [];
    }
  }
}