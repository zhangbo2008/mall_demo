import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Random([int seed ])：创建一个随机数生成器
  final random = new Random();
  int dataSet = 50;

  void changeData() {
    setState(() {
      dataSet = random.nextInt(100);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
          child: new CustomPaint(
              size: new Size(200.0, 100.0),
              painter: new BarChartPainter(dataSet.toDouble())
          )
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: changeData,
        child: new Icon(Icons.refresh),
      ),
    );
  }
}

// CustomPaint：是将绘画委托给CustomPainter策略的控件
class BarChartPainter extends CustomPainter {
  static const barWidth = 10.0;

  BarChartPainter(this.barHeight);
  final double barHeight;

  /*
 void paint(
 Canvas canvas,
 Size size
 )
 当对象需要绘制时调用，它给出Canvas的坐标空间，使得原点位于框的左上角，
 框的面积是size参数的大小
 */
  @override
  void paint(Canvas canvas, Size size) {
    final paint = new Paint()
      ..color = Colors.blue[400]
      ..style = PaintingStyle.fill;
    // drawRect：使用给定的Paint绘制一个矩形，是否填充或描边（或两者）是由Paint.style控制
    canvas.drawRect(
      // Rect.fromLTWH(double left, double top, double width, double height)：
      // 从左上角和上边缘构造一个矩形，并设置其宽度和高度
        new Rect.fromLTWH(
            size.width-barWidth/2.0,
            size.height-barHeight,
            barWidth,
            barHeight
        ),
        paint
    );
  }

  /*
 bool shouldRepaint(
 CustomPainter,
 oldDelegate
 )
 当定制绘画委托类的新实例被提供给RenderCustomPaint对象时，
 或任何时候使用自定义绘画委托类的新实例创建新的CustomPaint对象
 （这相当于同一件事，因为后者是以前者实施）
 */
  @override
  bool shouldRepaint(BarChartPainter old) => barHeight != old.barHeight;
}