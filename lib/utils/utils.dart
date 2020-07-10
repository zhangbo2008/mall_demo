import 'package:flutter/services.dart';
import'dart:async';

class PioUtils {  //PIO的英文拼写是“Programming Input/Output Model”
  /**
   * 创建指定长度的 `List`
   */
  static createListByLength({ int len = 6 }) {
    var result = new List(len);
    return result;
  }

  /**
   * 读取 `txt` 文本
   */
  static Future<String> readRawHelpText() async {
    try {
      var ctx = await rootBundle.loadString('lib/raw/help.txt');
//      print(ctx);
      return ctx;
    } catch (e) {
      throw FormatException('读取失败');
    }
  }

}