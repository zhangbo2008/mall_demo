import 'package:flutter/material.dart';
//import 'package:learn_flutter/views/shopCar.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'pages/loading.dart';

void main() => runApp(MainApp());

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
        ChangeNotifierProvider<MyModel>(create: (context) => MyModel()),
//          ChangeNotifierProvider<MyModel>(create: (context) => MyModel()),
    ],child:


      MaterialApp(
      debugShowCheckedModeBanner: false, // 设置这一属性即可
      routes: <String, WidgetBuilder>{ //静态路由表, 这些东西全局软件都可以直接调用.   Navigator.of(context).pushReplacementNamed("app");   静态路由没法传参数.
        "/": (BuildContext ctx)=> LoadingWrapper(),
        "app": (BuildContext ctx)=> Application(),
//        "cart":(BuildContext ctx)=> myViews3()
      },
    ));
    ;
  }

}