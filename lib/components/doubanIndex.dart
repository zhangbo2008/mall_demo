
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mall_cart/pages/detail.dart';
//import 'package:learn_flutter/views/my_page.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';




class DouBanIndexComponent extends StatelessWidget {

  DouBanIndexComponent({
    Key key,
    this.lists
  }): super(key: key);

  List lists = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _titleWrapper(context), // 头标题
          _dataList(context, lists) //内容 : 包含子标题和图片
        ],
      ),
    );
  }

  Widget _dataList(context, List lists) {
//    print('看看数据');
//    print(lists);
    var _w = ScreenUtil.getScreenW(context);
    var itemW = _w * 168.5 / 360;
    List<Widget> listWrap = lists.map((item){ // 把每一个item 放入后面的函数中.得到一个迭代器.
      // 后面这个函数是匿名函数, 入参item 出餐是{return xxxxxx}
      return GestureDetector(  // 购买跳转在这里!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!---------------
        onTap: () {
//          这个函数表示点击下面child时候会触发这个tap函数.

          Navigator.of(context).push( //路由跳转到.  CatDetailPage(item: item) 这个. //并且用的是page内部跳转.
            MaterialPageRoute(builder: (ctx) {
              return CatDetailPage(item: item);
            })
          );
        },
        child: Container(
          width: itemW,
          child: Column(  // 核心就是用Column 来排版.
            children: <Widget>[
              Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    item["info"]["imgurl"],
                    width: itemW,
                    height: 130,
                    fit: BoxFit.cover,
                  ),
                ),
                margin: EdgeInsets.only(bottom: 4),
                padding: EdgeInsets.all(2.4)
              ),
              RichText(
                textAlign: TextAlign.left,
                textWidthBasis: TextWidthBasis.parent,
                text: TextSpan(
                  text: item['title'],

                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.red
                  ),
                  children: <InlineSpan>[


                    WidgetSpan(
                      child: Container(

                        child: Text(

                          item['info']['pingfen'],
                          style: TextStyle(
                            backgroundColor: Colors.blue,
                            color: Colors.white,
                          ),
                        ),
                      padding: EdgeInsets.only(left: 4, bottom: 2),
                      )
                    )
                  ]
                ),
                ),
            ],
          )
        ),
      );
    }).toList();
    return Container(
      child: Wrap(
        spacing: 2,
        children: listWrap.isEmpty ? [ Text("载入中") ] : listWrap,
      ),
      padding: EdgeInsets.only(bottom:20),
    );
  }

  Widget _titleWrapper(BuildContext context) {
    return Container(
      width: ScreenUtil.getScreenW(context),
      child: Center(
        child: Text(
          "最新电影",
          style: TextStyle(
            fontSize: 18,
//            decoration: TextDecoration.underline,
            decorationStyle: TextDecorationStyle.wavy,
            decorationColor: Theme.of(context).accentColor
          ),
        ),
      ),
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.only(bottom: 8, top: 8),
    );
  }

}