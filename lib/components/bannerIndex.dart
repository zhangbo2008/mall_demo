import 'package:flutter/material.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter_swiper/flutter_swiper.dart';


class BannerIndexSwiper extends StatelessWidget { //仍然是一个widget

  BannerIndexSwiper({
    Key key,
    @required this.banners
  }): super(key: key);

  /**
   * 轮播图
   */
  List<String> banners = [];

  @override  //入口还是build函数
  Widget build(BuildContext context) {
    double _w = ScreenUtil.getScreenW(context);
    double _h = _w * 540.0 / 1080.0; //保证图片是2:1的
    bool flag = banners.isEmpty;
    return Container(
      width: _w,
      height: _h,
      decoration: BoxDecoration(
        color: !flag ? null : Colors.yellow, //存在就不放颜色,不存在就放黄色
      ),
      child: flag ? emptyText() : swiper(),  //如果是空的,那么就放空的test站位.否则就swiper函数
      margin: EdgeInsets.only(
        top: !flag ? 12 : 0
      ),
    );
  }

  Widget emptyText() {
    return Center(
      child: Text(
        "图片载入中",
        style: TextStyle(
          fontSize: 42,
          color: Colors.black
        ),
      ),
    );
  }












  Widget swiper() {
    return Swiper(  //swiper是一个插件. 配置点参数就能实现轮播
        autoplayDisableOnInteraction : true,  //当手动操作时候停止autoplay
      autoplay: true,   //让自己滚动
      itemBuilder: (BuildContext ctx, index) {
        return Container(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              banners[index],
              fit: BoxFit.cover,
            ),
          ),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.pink.withOpacity(0.2),
                spreadRadius: 4,
                blurRadius: 14,
                offset: Offset(0, 1), // changes position of shadow
              ),
            ],
          ),
        );
      },
      itemCount: banners.length,
      viewportFraction: 0.8,
      scale: 0.9,
      pagination: new SwiperPagination(

        margin: EdgeInsets.only(top: 59)
      ),
    );
  }

}