import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ToastStyle extends Diagnosticable {
  const ToastStyle({
    this.position = ToastPosition.bottom,
    this.textSize = 14.0,
    this.margin = const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
    this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    this.color,
    this.textColor,
    this.duration,
  });

  final Color color;               // 背景颜色
  final Color textColor;           // 文本颜色
  final double textSize;           // 文字大小
  final EdgeInsetsGeometry padding;// 内边距
  final EdgeInsetsGeometry margin; // 外边距
  final ToastPosition position;    // 显示位置
  final Duration duration;         // 显示时间
}

enum ToastPosition { top, center, bottom, }

enum _ToastType { text, loading, success, error, info, custom }

class Toast {
  static OverlayEntry _overlayEntry; // UI浮层
  static Timer _timer;      // 计时，如果计时大于 _seconds，则移除Toast

  // 加载中
  static void loading(BuildContext context, {String message}) => Toast.showLoading(context, message: message);
  static void showLoading(BuildContext context, {String message, ToastStyle style}) =>
      _showToast(
          context,
          message: message,
          type: _ToastType.loading,
          style: style == null ? ToastStyle(position: ToastPosition.center) : style
      );

  // 自定义
  static void custom(BuildContext context, Widget customChild) => Toast.showCustom(context, customChild);
  static void showCustom(BuildContext context, Widget customChild, {ToastStyle style}) =>
      _showToast(
          context,
          customChild: customChild,
          type: _ToastType.custom,
          style: style == null ? ToastStyle() : style
      );

  // 文本
  static void text(BuildContext context, String message) => Toast.showText(context, message);
  static void showText(BuildContext context, String message, {ToastStyle style}) =>
    _showToast(
      context,
      message: message,
      type: _ToastType.text,
      style: style == null ? ToastStyle() : style
    );

  // 成功
  static void success(BuildContext context, String message) => Toast.showSuccess(context, message);
  static void showSuccess(BuildContext context, String message, {ToastStyle style}) =>
      _showToast(
        context,
        message: message,
        type: _ToastType.success,
        style: style == null ? ToastStyle(position: ToastPosition.center) : style,
      );

  // 失败
  static void error(BuildContext context, String message) => Toast.showError(context, message);
  static void showError(BuildContext context, String message, {ToastStyle style}) =>
      _showToast(
        context,
        message: message,
        type: _ToastType.error,
        style: style == null ? ToastStyle(position: ToastPosition.center) : style,
      );

  // 消息
  static void info(BuildContext context, String message) => Toast.showInfo(context, message);
  static void showInfo(BuildContext context, String message, {ToastStyle style}) =>
      _showToast(
        context,
        message: message,
        type: _ToastType.info,
        style: style == null ? ToastStyle(position: ToastPosition.center) : style,
      );

  // 显示
  static void _showToast(
      BuildContext context,
      {
        String message,
        Widget customChild,
        _ToastType type,
        ToastStyle style
      }
  ) async {
    // 显示之前先把之前的浮层清空
    _cancelToast();
    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) => SafeArea(
        // 当类型为 _ToastType.loading 时，
        // 我希望页面布局的事件不被执行，在 _containerWidget 外面包裹一层 Material 并且设置颜色，
        // 其它类型直接加载 _containerWidget
        child: type == _ToastType.loading ? Material(
            // 在 _containerWidget 外面包裹一层 Material 并且设置颜色之后，事件就不能穿透了
            color: Colors.transparent,
            child: _containerWidget(context,
                message: message,
                customChild: customChild,
                type: type,
                style: style),
          ) : _containerWidget(
            context,
            message: message,
            customChild: customChild,
            type: type,
            style: style),
      ),
    );
    // 当 Toast 类型不为 _ToastType.custom 和 _ToastType.loading，
    // 并且 style.duration == null 时，
    // 我们给它一个默认值 Duration(seconds: 3)
    _startTimer((type != _ToastType.custom
        && style.duration == null
        && type != _ToastType.loading) ? Duration(seconds: 3) : style.duration);
    Overlay.of(context).insert(_overlayEntry);
  }

  // 开启倒计时
  static void _startTimer(Duration duration) {
    // 当 duration == null 时，Toast 长存不自动消失
    if (duration == null) return;
    _timer = Timer(duration, (){
      _cancelToast();
    });
  }

  // 取消倒计时
  static _cancelTimer() async {
    _timer?.cancel();
    _timer = null;
  }

  // 移除Toast
  static _cancelToast() async {
    _cancelTimer();
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  // 移除Toast，当 Toast 类型为 _ToastType.custom 和 _ToastType.loading
  // 并且 style.duration == null 时 Toast 不会自动消失，
  // 需要暴露一个方法给用户主动调用
  static cancel() async {
    _cancelToast();
  }
}

// Toast内容容器
Widget _containerWidget(
  BuildContext context,
  {
    String message,
    Widget customChild,
    _ToastType type,
    ToastStyle style,
  }
) {

  MainAxisAlignment mainAxisAlignment;
  if (style.position == ToastPosition.top) {
    mainAxisAlignment = MainAxisAlignment.start;
  } else if (style.position == ToastPosition.center) {
    mainAxisAlignment = MainAxisAlignment.center;
  } else {
    mainAxisAlignment = MainAxisAlignment.end;
  }

  return Column(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: mainAxisAlignment,// 设置 Toast 显示的位置
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Flexible(
        child: Padding(
          padding: style.margin,
          child: Card(
            // 设置Toast背景色
            color: style.color != null ? style.color : isDarkMode() ? const Color(0xFFE0E0E0) : Colors.black87,
            child: Padding(
              padding: style.padding,
              // 当 Toast 的类型是 _ToastType.custom 时，加载自定义 Widget，否则加载内置的各类型 Widget
              child: type == _ToastType.custom ? customChild : _typeWidget(type, message, style),
            ),
          ),
        ),
      ),
    ],
  );
}

// 显示内容的Widget
Widget _typeWidget(_ToastType type, String message, ToastStyle style) {

  if (type == _ToastType.custom) {
    return null;
  }

  if (type == _ToastType.text) {
    return Text(
      message,
      style: TextStyle(
        fontSize: style.textSize,
        // 文本颜色
        color: style.textColor != null ? style.textColor : isDarkMode() ? const Color(0xFF2F2F2F) : Colors.white,
      ),
    );
  }

  final List<Widget> _widgets = <Widget>[];
  if (type == _ToastType.loading) {
    _widgets.add(CupertinoActivityIndicator(radius: 24,),);
  } else if (type == _ToastType.success) {
    _widgets.add(Icon(
      Icons.check_circle_outline,
      size: 36,
      color: Colors.green,
    ));
  } else if (type == _ToastType.error) {
    _widgets.add(Icon(
      Icons.highlight_off,
      size: 36,
      color: Colors.red,
    ));
  } else if (type == _ToastType.info) {
    _widgets.add(Icon(
      Icons.info_outline,
      size: 36,
      color: Colors.blue,
    ));
  }

  // 文本与 Icon 的距离
  double _textTop = 8;
  if (message.isEmpty) {
    _textTop = 0;
  }
  _widgets.add(
    Flexible(child: Padding(
      padding: EdgeInsets.only(top: _textTop),
      child: Text(message,
        style: TextStyle(
          fontSize: style.textSize,
          // 文本颜色
          color: style.textColor != null ? style.textColor : isDarkMode() ? const Color(0xFF2F2F2F) : Colors.white,
        ),
      ),
    ))
  );

  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: _widgets,
  );
}

// 判断是否是暗黑模式
bool isDarkMode() {
  bool isDarkMode;
  final ThemeMode themeMode = ThemeMode.system;
  if (themeMode == ThemeMode.light || themeMode == ThemeMode.dark) {
    isDarkMode = themeMode == ThemeMode.dark;
  } else {
    isDarkMode =
        WidgetsBinding.instance.window.platformBrightness == Brightness.dark;
  }
  return isDarkMode;
}