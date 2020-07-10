//这个代码实现一个计数器,在各个页面中共享数据,从而达到购物车数据和用于数据在各个页面共享的效果.
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:flutter_mall_cart/config/const.dart';
import 'dart:async';
import 'package:flutter_mall_cart/app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
class myViews3 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AboutDemoViewsState();
  }
}










class AboutDemoViewsState extends State<myViews3> {

  @override
  Widget build(BuildContext context) {
    return MyHomePage();
  }

}


class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
//        appBar: AppBar(
//          title: Text('购物车'),
//        ),
        body: Column(
          children: <Widget>[
            Builder(
              builder: (context) {
                MyModel _model = Provider.of<MyModel>(context);
                return Container(
                    margin: const EdgeInsets.only(top: 20),
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.center,
                    color: Colors.lightBlueAccent,
                    child: Text('当前是：${_model.counter}'));
              },
            ),
            Consumer<MyModel>(// 把相应好的东西协商去即可!!!!!!!!!!!
              builder: (context, model, child) {
                return Container(
                  margin: const EdgeInsets.only(top: 20),
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.center,
                  color: Colors.lightGreen,
                  child: model.product.isNotEmpty ?  Text( '${model.product}'):Text( '购物车为空')

                );
              },
            ),
            Consumer<MyModel>(
              builder: (context, model, child) {
                return FlatButton(

                    color: Colors.tealAccent,
                    onPressed: model.incrementCounter,
                    child: Icon(Icons.add));
              },
            ),


            Consumer<MyModel>(
              builder: (context, model, child) {
                return FlatButton(

                    color: Colors.tealAccent,
                    onPressed: model.incrementCounter,
                    child: Icon(Icons.add));
              },
            ),
            Row(
              children: <Widget>[ Consumer<MyModel>(
                builder: (context, model, child) {
                  return FlatButton(

                      color: Colors.tealAccent,
                      onPressed: model.incrementCounter,
                      child: Icon(Icons.add));
                },
              ), Consumer<MyModel>(
                builder: (context, model, child) {
                  return FlatButton(

                      color: Colors.tealAccent,
                      onPressed: model.incrementCounter,
                      child: Icon(Icons.add));
                },
              ),],


            )






          ],
        ),

    );
  }
}

