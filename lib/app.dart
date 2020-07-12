import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mall_cart/views/abouts.dart';
import 'package:flutter_mall_cart/views/home.dart';
import 'package:flutter_mall_cart/views/product.dart';
//import 'package:flutter_mall_cart/views/my_page.dart'; // 这个页面用于测试.
import 'package:flutter_mall_cart/views/lists.dart';
import 'package:flutter_mall_cart/views/my.dart';
import 'package:flutter_mall_cart/views/shopCar.dart';
import 'package:provider/provider.dart';
/*这个app.dart控制的是主页面.*/              //所以把变量都存这里面.
import 'config/const.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mall_cart/paowuxian.dart';

// model 一定要写在最上层,并且只写一个,然后调用时候就保证了引用唯一.
//数据model也放这里. 因为model是全局变量.所有页面都共享,app是所有的父页面.放这里逻辑就正确.
class MyModel with ChangeNotifier{
  //                                               <--- MyModel
  MyModel({this.counter = 0,this.url=''});
String url;
  int counter = 0;
  var urls = Map<String,String >();
  incrementCounter()  {

    counter++;
//    print(counter);
    notifyListeners();
  }

  var product = Map<String,int >();


   addproduct(String a,int num) {
     print(11111111111111111);
//     print(product.isEmpty);
    print('你购买了');
    if (!product.containsKey(a))
    {product[a]=0;}
    {product[a]+=num;}
print('你购买了');
print(a);

      notifyListeners();

  }

  addurls(String a,String num) {
    print(11111111111111111);
//     print(product.isEmpty);
 urls[a]=num;

    notifyListeners();

  }









   updateproduct(String a,int num) {  // 购物车里面实时更新数据.
  product[a]=num;

    notifyListeners();

  }




}



// 下面就是页面.
class Application extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {

    return ApplicationState();
  }

}

class ApplicationState extends State<Application> with AutomaticKeepAliveClientMixin{

  final List<Widget> PageViews = [








    HomeViews(),
    ProductViews(),
//    ListDemoViews(),
//
    AboutDemoViews(),
    myViews3(),  //购物车
    myViews2(),  //登录
//    MyPage(),
//        MyApp21(),
  ];
int cur1=0;
  int _currentIndex = 0;

  Widget _currentPage() {
    return PageViews[_currentIndex];
  }

  void changeBottomBar(int index) {
    if ((index + 1) > PageViews.length) return;
    setState(() {
      _currentIndex = index;
    });
  }
  DateTime lastPopTime;








  _backDeskTop() async {
    //初始化通信管道-设置退出到手机桌面
    String CHANNEL = "android/back/desktop";
    final platform = MethodChannel(CHANNEL);
    //通知安卓返回,到手机桌面
    try {
      final bool out = await platform.invokeMethod('backDesktop');
      if (out) debugPrint('返回到桌面');
    } on PlatformException catch (e) {
      debugPrint("通信失败(设置回退到安卓手机桌面:设置失败)");
      print(e.toString());
    }
    return Future.value(false);
  }


  SelectView(IconData icon, String text, String id) {
    return new PopupMenuItem<String>(
        value: id,
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new Icon(icon, color: Colors.blue),
            new Text(text),
          ],
        )
    );
  }



  @override
  Widget build(BuildContext context) {
    super.build(context);//要点3
    return  WillPopScope(   // 监听退出时间,让用户无法点击按钮就直接退出.
        onWillPop: () async {
          //真正的退出写这里.
      if(lastPopTime == null || DateTime.now().difference(lastPopTime) > Duration(seconds: 2)){
        lastPopTime = DateTime.now();
       //如果大于2s 就更新
      }else{
        lastPopTime = DateTime.now();
        // 退出app
//        await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
print("diaoyong le ma ?");
//      _backDeskTop();
//        Navigator.popUntil(context, ModalRoute.withName('/'));
//return true;
      }




    },




        child:
      Scaffold(


          body: IndexedStack(    // 通过这个来提供返回页面, 设置index 和children即可, 就会返回childern[index]
            index: _currentIndex,  //设置好每次点击按钮, index 更新.
            children: PageViews, //设置好所有的页面组成的list即可.
          ),

      appBar: AppBar(

        actions: <Widget>[
          // 非隐藏的菜单

          // 隐藏的菜单
          new PopupMenuButton<String>(
            itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
              this.SelectView(Icons.message, '发起群聊', 'A'),
              this.SelectView(Icons.group_add, '添加服务', 'B'),
              this.SelectView(Icons.cast_connected, '扫一扫码', 'C'),
            ],
            onSelected: (String action) {
              // 点击选项的时候
              switch (action) {
                case 'A': break;
                case 'B': break;
                case 'C': break;
              }
            },
          ),
        ],
        leading: new Icon(Icons.home),

          toolbarOpacity:0.7 ,
//        leading:  ,
        title: Text(ConstKey.title),
        elevation: 0,
      ),





      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) { // 这个来控制这些按钮的相应.
          changeBottomBar(index);
        },
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('首页'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            title: Text('段子'),
          ),
//          BottomNavigationBarItem(
//            icon: Icon(Icons.school),
//            title: Text('列表展示'),
//          ),












          BottomNavigationBarItem(
            icon: Icon(Icons.system_update),
            title: Text('关于我们'),
          ),


          BottomNavigationBarItem(
            icon: Icon(Icons.add_shopping_cart),
            title: Text('购物车'),
          ),
    BottomNavigationBarItem(
    icon: Icon(Icons.account_box),
    title: Text('我的')),



//
//
//          BottomNavigationBarItem(
//            icon: Icon(Icons.add_shopping_cart),
//            title: Text('测试'),
//          ),






        ]
      ),

    ));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;//要点2

}