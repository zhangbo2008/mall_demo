import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'dart:async';
import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text("详情页"),
      ),
      body:
//      Row(
//        children: <Widget>[
       SmartRefresher(   // 上下拉动都加载.
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
        Column(
          children: <Widget>[
//            Container(
//              height: 40.0,
//              child: Text('sssssssssssssss'),
//            ),
            Flexible( // 在ListView上在包裹一层Flexible
              child: ListView(
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
            ),
            Container(
              height: 40.0,
              child: Text('下面操作栏'),
            )
          ],
        ),



      )
      ,);


  }

}