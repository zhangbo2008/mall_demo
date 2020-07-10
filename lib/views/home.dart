//首页就是我们商城,用户购买物品. 里面都有一个添加按钮,用于添加物品.点完之后购物车中对应物品加1
//这个就是商城的购买区.
import 'package:flutter/material.dart';
import 'package:flutter_mall_cart/api/home.dart';
import 'package:flutter_mall_cart/components/bannerIndex.dart';
import 'package:flutter_mall_cart/components/doubanIndex.dart';

class HomeViews extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeViewsState();
  }

}

class HomeViewsState extends State<HomeViews> with AutomaticKeepAliveClientMixin{

  List<String> _banners = [];
  List _lists = [];

  getBanner() async {
    List<String> data = await AppHomeApi.getIndexBanners();
    setState(() {
//      print(data);//是图片链接组成的list
      _banners = data;
    });
  }

  getDouBan() async {
    List data = await AppHomeApi.getDouBanApi();
    setState(() {
      _lists = data;
    });
  }


  @override
  initState() {           // 页面首先获取数据放在initState方法里面.
    getBanner();
    getDouBan();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);//要点3
    return Container(
      child: ListView(
        children: <Widget>[









          BannerIndexSwiper(  //自己定义的组件.轮播器
            banners: _banners,










          ),
          DouBanIndexComponent(
            lists: _lists,
          )
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;//要点2

}