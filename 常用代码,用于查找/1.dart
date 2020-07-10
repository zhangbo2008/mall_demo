// 购买按钮.

import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';



Container(
alignment: Alignment.bottomRight, // 这个参数非常重要,对齐直接就弄到左右了.
padding: EdgeInsets.all(20),//内部padding也很重要.
width: 10,
child: FloatingActionButton(
onPressed: (){print(111111);},
child: Text('购买'),
),
margin: EdgeInsets.fromLTRB(0,0,0,10), //margin经常没用.
),











class ListRefresher extends StatelessWidget {
  final Function onRefresh;
  final Function onLoading;
  final Widget child;
  final RefreshController refreshController;

  ListRefresher({this.onRefresh, this.onLoading, this.child, this.refreshController});

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: false,
      header: BezierCircleHeader(),
      footer: CustomFooter(
        builder: (BuildContext context, LoadStatus mode) {
          Widget body;
          if (mode == LoadStatus.idle) {
            body = Text("Pull to Refresh");
          } else if (mode == LoadStatus.loading) {
            body = CircularProgressIndicator();
          } else if (mode == LoadStatus.failed) {
            body = Text("Load Failed! Click retry!");
          } else {
            body = Text("No More Data");
          }
          return Container(
            height: 55.0,
            child: Center(child: body),
          );
        },
      ),
      controller: refreshController,
      onRefresh: onRefresh,
      onLoading: onLoading,
      child: child,
    );
  }
}




