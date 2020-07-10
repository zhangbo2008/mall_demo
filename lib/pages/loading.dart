
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mall_cart/utils/utils.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:flutter_mall_cart/config/const.dart';
import 'package:flustars/flustars.dart';

import 'package:common_utils/common_utils.dart';

class LoadingWrapper extends StatefulWidget {//动态页面用stateful
  @override
  State<StatefulWidget> createState() {
    print(1111111);
    return LoadingWrapperState();
  }

}

class LoadingWrapperState extends State<LoadingWrapper> {

  /**
   * 定时器时间
   */
  int _s = ConstKey.startupTime;

  /**
   * 首页启动文本
   */
  String _startupHelp = "<h1>欢迎使用</h1>";

  TimerUtil mTimerUtil; //定时器插件.

  @override initState() {
    getContentHTML();
    Timer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        bgImg(),
        content(

            _startupHelp

        ),
        smButton()
      ],
    );
  }

  /**
   * 获取首页 `html`
   */
  void getContentHTML() async { //读取文本做io处理,都需要做async await套起来.
    String result;
    try {
      result = await PioUtils.readRawHelpText();
      print('duqudaole' );
    } catch (err) {
      print('duqushibai');
      result = "<h4>欢迎使用</h4>";
    }
    print("结果为: " + result);
    setState(()=> {
      _startupHelp = result //读取之后做文本更新.
    });
  }

  /**
   * 定时器
   */
  void Timer() {
    mTimerUtil = TimerUtil(
        mInterval: 1000,
        mTotalTime: ConstKey.startupTime
    );
    mTimerUtil.startCountDown(); //启动
    mTimerUtil.setOnTimerTickCallback(
            (tick) { //每一次tick调用这个函数
      setState(()=> { // if 里面 表示时间流光之后,自动跳转.
/*
* 出现这个错误的原因是：在 Dart 2.5 以前的版本，control-flow-collections 还是一个实验版本，并没有正式的去用；但在 Dart 2.5 之后这个功能已经可以正式使用，只需更新 pubspec.yaml 中的最低 Dart 版本就解决了：
*
*
*
* */
        _s = tick,if (tick==0){Navigator.of(context).pushReplacementNamed("app")

        }
      });
    }

    );



  }


  /**
   * 内容
   */
  Widget content(String html) {  //content输入html, 返回一个widget,所以我们需要设置这个widget.
    return Center(
      child: Container(
          alignment: Alignment.center,
          child: Container(
            child: HtmlWidget( //核心就是这个htmlwidget,输入html代码,返回一个widget
              html,
              textStyle: TextStyle(
                  fontSize: 12,
                  color: Colors.red,
                  decoration: TextDecoration.none,
                  backgroundColor:Colors.transparent
              ),
            ),
            color: Colors.transparent,
            padding: EdgeInsets.all(8.2),
          )
      ),
    );
  }

  /**
   * 启动背景图片
   */  //这里面使用默认参数
  Widget bgImg({ String src =  ConstKey.startupImg }) {
    return Image.network(
        src,
        width: ScreenUtil.getScreenW(context),
        height: ScreenUtil.getScreenH(context),
        fit: BoxFit.cover
    );
  }

  /**
   * 跳过按钮
   */
  Widget smButton() {
    double _padding = 18;
    double __s = _s / 1000;
    String _txt = __s.toStringAsFixed(0);
    String _concat = ConstKey.startupSkipText;
    if (__s > 0) _concat += '$_txt' + '秒';
    return Positioned(
        child: RaisedButton.icon(
          onPressed: () {
            if (0 == 0) {  // 这么写就让用户随时可以跳转.节省时间.随时按这个按钮都可以额.
              Navigator.of(context).pushReplacementNamed("app");
            }
          },
          icon: Icon(Icons.skip_next),
          label: RichText(
            text: TextSpan(
                children: <InlineSpan>[
                  TextSpan(
                      text: _concat
                  )
                ]
            ),
          ),
          color: Colors.blueAccent,
          textColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(42.0),
          ),
          padding: EdgeInsets.only(left: _padding, right: _padding),
        ),
        right: 18.6,
        top: 24.0
    );
  }

}