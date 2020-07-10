import 'package:flutter/material.dart';
import 'package:learn_flutter/views/abouts.dart';
import 'package:learn_flutter/views/home.dart';
import 'package:learn_flutter/views/product.dart';
import 'package:learn_flutter/views/my_page.dart'; // 这个页面用于测试.
import 'package:learn_flutter/views/lists.dart';
import 'package:learn_flutter/views/my.dart';
import 'package:learn_flutter/views/shopCar.dart';
import 'package:provider/provider.dart';
/*这个app.dart控制的是主页面.*/              //所以把变量都存这里面.
import 'config/const.dart';

//非常重要的技术, 是用  IndexedStack 实现.

//数据model也放这里. 因为model是全局变量.所有页面都共享,app是所有的父页面.放这里逻辑就正确.
class MyModel with ChangeNotifier{
  //                                               <--- MyModel
  MyModel({this.counter = 0});

  int counter = 0;

  incrementCounter()  {

    counter++;
    print(counter);
    notifyListeners();
  }

  var product = Map<String,int >();


   addproduct(String a) {
     print(11111111111111111);
     print(product.isEmpty);
    print('你购买了');
    if (!product.containsKey(a))
    {product[a]=0;}
    {product[a]+=1;}
print('你购买了');
print(a);

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

    AboutDemoViews(),
    myViews3(),
    myViews2(),
//    MyPage(),
  ];

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

  @override
  Widget build(BuildContext context) {
    super.build(context);//要点3
    return
      Scaffold(


          body: IndexedStack(
            index: _currentIndex,
            children: PageViews,
          ),

      appBar: AppBar(
        title: Text(ConstKey.title),
        elevation: 8,
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

    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;//要点2

}