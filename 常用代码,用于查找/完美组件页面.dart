import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'dart:async';
import 'package:flutter/material.dart';

import '../app.dart';
























// 好像应该用stateless
class CatDetailPage extends StatefulWidget {

  var item;

  CatDetailPage({
    Key key,
    this.item
  }): super(key: key);
  @override
  State<StatefulWidget> createState() {
    return CatDetailPageState(item: item);
  }

}

class CatDetailPageState extends State<CatDetailPage> {

  CatDetailPageState({
    Key key,
    this.item
  });
  RefreshController _refreshController =RefreshController(initialRefresh: false);
  var item;
  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    print(111111111111111);
    _refreshController.refreshToIdle(); //刷新上面.
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
var a=1;
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }
  @override
  Widget build(BuildContext context) {
    return      // 这个地方应该用Notification报一下.

//        ChangeNotifierProvider<MyModel>( create: (context) => MyModel(),
//    child:


    Scaffold(
      appBar: AppBar(
        title: Text("详情页"),
      ),
      body:
//      Row(
//        children: <Widget>[

        Column(
          children: <Widget>[
//            Container(
//              height: 40.0,
//              child: Text('sssssssssssssss'),
//            ),




            Flexible( // 在ListView上在包裹一层Flexible
              child:        SmartRefresher(   // 上下拉动都加载.包上一层上下刷新的组件.
          enablePullDown: true,
          enablePullUp: true,
          header: WaterDropHeader(),

          footer: CustomFooter(
              builder: (BuildContext context, LoadStatus mode) {
                Widget body;
                if (mode == LoadStatus.idle) {

                } else if (mode == LoadStatus.loading) {
                  body = CircularProgressIndicator();
                } else if (mode == LoadStatus.failed) {
                  body = Text("加载失败");
                } else if (mode == LoadStatus.canLoading) {
                  body = Text("加载更多");
                } else {
                  body = Text("没有更多");
                }
                return Container(
                  height: 50.0,
                  child: Center(child: body),
                );
              }
          ),
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          controller: _refreshController,   // 控制器
          child:
        //下面是刷新的内容.组件是一个listview
              ListView(
//          physics: new NeverScrollableScrollPhysics(),

                  children: <Widget>[
                    Container(
                      height: 500, //让滑动

                      child: Image.network(
                          item['info']['imgurl']
                      ),
                      decoration: BoxDecoration(
                          color: Colors.yellow[50]
                      ),
                      padding: EdgeInsets.all(24),
                    ),
                    Container(
                      child: Text(
                          item['title'],
                          style: TextStyle(
                              fontSize: 32,
                              color: Theme.of(context).accentColor
                          )
                      ),
                      margin: EdgeInsets.fromLTRB(12,12,12,12),
                    ),
                    Text(
                        item['info']['yanyuan']
                    )
                  ]
                //添加按钮.
              ),
            )),

//            Consumer<MyModel>(
//              builder: (context, model, child) {
//                return Container(
//                  margin: const EdgeInsets.only(top: 20),
//                  width: MediaQuery.of(context).size.width,
//                  padding: const EdgeInsets.all(20),
//                  alignment: Alignment.center,
//                  color: Colors.lightGreen,
//                  child: Text(
//                    '${model.counter}',
//                  ),
//                );
//              },
//            ),




    Container(

    padding: EdgeInsets.fromLTRB(200,10,10,10,), //设置空间的位置.
    child: Row(
//        crossAxisAlignment: CrossAxisAlignment.stretch,
crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
//
//      Container(
//        width: 10,
//        height: 10,
//        color: Colors.red,
//      ),


//      Consumer(builder: (BuildContext context,
//          model, Widget child) {
//        print('Text1重绘了。。。。。。');
//
//        return Text(
//          //获取数据
//          'Text1 : ${model.value}',
//          style: TextStyle(fontSize: 20),
//        );
//      }),

      Consumer<MyModel>( //写一个button

          builder: (context, model, child) {
            return FloatingActionButton(

// onPressed 里面输入一个void callback, 所以他不能直接写函数.需要把盗用的写{}里面就行了.
                onPressed: (){print(item['title']);model.addproduct(item['title']);},
                child: Text("购物车")

            );

          }),



      SizedBox(width: 20,),  // 这个是padding 组件,用来拉开组件之间的距离
      Consumer<MyModel>( //写一个button

          builder: (context, model, child) {
            return FloatingActionButton(

// onPressed 里面输入一个void callback, 所以他不能直接写函数.需要把盗用的写{}里面就行了.
                onPressed: (){print(item['title']);model.addproduct(item['title']);},
                child: Text("购买")

            );

          })

,



      ]))









          ],
        ),



      )
      ;


  }

}