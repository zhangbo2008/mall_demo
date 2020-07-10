import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mall_cart/config/const.dart';
import 'package:flutter_mall_cart/views/shopCar.dart';
import 'package:giffy_dialog/giffy_dialog.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:add_cart_parabola/add_cart_parabola.dart';
import '../app.dart';

import 'dart:ui';

import 'package:add_cart_parabola/add_cart_parabola.dart';
import 'package:flutter/material.dart';

// 好像应该用stateless
class CatDetailPage extends StatefulWidget {
  var item;

  CatDetailPage({Key key, this.item}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    print(item);
    print('111111111111111111111111111111');
    return CatDetailPageState(item: item);
  }
}

class CatDetailPageState extends State<CatDetailPage> {
  CatDetailPageState({Key key, this.item});


  var item;



  Widget generateItem(int index){
    Function callback ;


    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var w=queryData.size.width;
    var h =queryData.size.height;
    var pingmuw=w;
    var pingmuh=h;
    Offset temp;
    temp = new Offset(w/2, h/2);
    //GlobalKey itemKey = GlobalKey();



    return RaisedButton(

      color: Colors.blue,
      child: Text("button"),
      onPressed: (){
        setState(() {
          OverlayEntry entry = OverlayEntry(
              builder: (ctx){
                return ParabolaAnimateWidget(rootKey,Offset(300,300),Offset(10,10), Icon(Icons.cancel,color: Colors.greenAccent,),callback,);
              }
          );
          Overlay.of(rootKey.currentContext).insert(entry);


          callback = (status){
            if(status == AnimationStatus.completed){
              entry?.remove();
            }
          };
        });

      },
    );
  }













  //引入动画的记忆状态.
  GlobalKey floatKey = GlobalKey();
  GlobalKey rootKey = GlobalKey();
  GlobalKey rootKey2 = GlobalKey();
  Offset floatOffset=new Offset(0, 0);
Function callback;
  Offset temp;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();





    WidgetsBinding.instance.addPostFrameCallback((_) {
      RenderBox renderBox = floatKey.currentContext.findRenderObject();
      floatOffset = renderBox
          .localToGlobal(Offset.zero); //floatingActionButton 的坐标. 对应floatkey 的
      print('dayindongzuo');
      print(floatOffset);
    });
  }

  var count=0;

  @override
  Widget build(BuildContext context) {
// 变量要写在build里面才能穿进去.
    MediaQueryData queryData;
      queryData =  MediaQuery.of(context);
    var w=queryData.size.width;
    var h =queryData.size.height;
    var pingmuw=w;
    var pingmuh=h;
    Offset temp;
    temp = new Offset(w/2, h/2);



    return    Scaffold(

      key: rootKey2,
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

          Flexible(
            // 在ListView上在包裹一层Flexible



            child:
            //下面是刷新的内容.组件是一个listview
            ListView(

//          physics: new NeverScrollableScrollPhysics(),

                children: <Widget>[
                  Container(
                    height: 500, //让滑动

                    child: Image.network(item['info']['imgurl']),
                    decoration: BoxDecoration(color: Colors.yellow[50]),
                    padding: EdgeInsets.all(24),
                  ),
                  Container(
                    child: Text(item['title'],
                        style: TextStyle(
                            fontSize: 32,
                            color: Theme.of(context).accentColor)),
                    margin: EdgeInsets.fromLTRB(12, 12, 12, 12),
                  ),
                  Text(item['info']['yanyuan'])
                ]
              //添加按钮.
            ),
          ),

          Container(
              key: rootKey,
              padding: EdgeInsets.fromLTRB(
                50,
                10,
                10,
                10,
              ), //设置空间的位置.
              child: Row(children: <Widget>[

                Consumer<MyModel>(
                  builder: (context, model, child) {
                    return FlatButton(
                        key: floatKey,
                        color: Colors.tealAccent,
                        onPressed: () {
                          Navigator.of(context).push(
                            //路由跳转到.  CatDetailPage(item: item) 这个. //并且用的是page内部跳转.
                              MaterialPageRoute(builder: (ctx) {
                                return myViews3();
                              })); //要用栈push这个跳转.这个跳转是最应该使用的.符合逻辑,因为推出时候,不按照层次来推出,而是按照浏览记录来退出,符合我们的需求!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//                      Navigator.of(context).pushReplacementNamed("cart");
                        },
                        child: Icon(Icons.add_shopping_cart));
                  },
                ),
                SizedBox(
                  width: 100,
                )// 这个是padding 组件,用来拉开组件之间的距离
//                generateItem(1),




                ,
//                Text(item['title']),


                Consumer<MyModel>(//写一个button

                    builder: (context, model, child) {
                      return FloatingActionButton(
                        //FloatingActionButton 这个东西要少用,貌似一行只能用1个.写多了,页面渲染不了.
// onPressed 里面输入一个void callback, 所以他不能直接写函数.需要把盗用的写{}里面就行了.
                          onPressed: () {
                            showDialog(

                                context: context,builder: (_) =>
                               Row( // 下面2行是设置2个轴的对齐方向,也就是水平和数值方向对齐方法.
                                 crossAxisAlignment:CrossAxisAlignment.center,
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: <Widget>[
                                         Container(width: 333,height: 600,color: Colors.white,  child:
                                         Column( // 下面2行是设置2个轴的对齐方向,也就是水平和数值方向对齐方法.
                                           crossAxisAlignment:CrossAxisAlignment.center,
                                           mainAxisAlignment: MainAxisAlignment.center,
                                           children: <Widget>[
Image.network(item['info']['imgurl']),
                                             Row( // 下面2行是设置2个轴的对齐方向,也就是水平和数值方向对齐方法.
                                               crossAxisAlignment:CrossAxisAlignment.center,
                                               mainAxisAlignment: MainAxisAlignment.center,
                                               children: <Widget>[

                                                 Text(item['title'],
                                                     style: TextStyle(
                                                         fontSize: 15,
                                                         color: Theme.of(context).accentColor, decoration: TextDecoration.none))
                                                  ,  // 文本修饰线),

//添加padding
                                                 SizedBox(
                                                   width: 20,
                                                 ),
                                                 NumChangeWidget()


                                               ],
                                             ),
                                             SizedBox(
                                               height: 30,
                                             ),

        // 添加一个确认和一个返回
                                             Row( // 下面2行是设置2个轴的对齐方向,也就是水平和数值方向对齐方法.
                                               crossAxisAlignment:CrossAxisAlignment.center,
                                               mainAxisAlignment: MainAxisAlignment.center,
                                               children: <Widget>[
                                                 RaisedButton(color: Colors.red,child:Text('不买滚蛋'),  onPressed: (){     Navigator.of(context).pop();} ),
                                                 SizedBox(
                                                   width: 100,
                                                 ),
                                                 RaisedButton(

                                                   color: Colors.blue,
                                                   child: Text("真香 "),
                                                   onPressed: (){

                                                     Navigator.of(context).pop();

                                                     setState(() {
                                                       OverlayEntry entry = OverlayEntry(
                                                           builder: (ctx){
                                                             return ParabolaAnimateWidget(rootKey2,Offset(pingmuw/2,pingmuh/2),Offset(100,200), Icon(Icons.cancel,color: Colors.greenAccent,),callback,)
                                                             ;
                                                           }
                                                       );



                                                       callback = (status){
                                                         if(status == AnimationStatus.completed){
                                                           entry.remove();
                                                           count+=1;
                                                           print('shopped');
                                                           print(count);
//                          entry?.remove();
                                                         }
                                                       };
                                                       Overlay.of(rootKey.currentContext).insert(entry);


                                                     });
                                                   },
                                                 ),



                                               ],
                                             )





                                           ],
                                         )
                                         ),
                                 ],
                            ));













                            print(item['title']);
                            model.addproduct(item['title']);

                            //做动画.
                          },
                          child: Text("购买"));
                    }),


              ])
          )










        ],
      ),
    );
  }
}

































// 加减条:




class NumChangeWidget extends StatefulWidget {

  final double height;
  int num=1;
  final ValueChanged<int> onValueChanged;
// 注意这里面默认值需要设置1, 因为没有傻逼为了买0个还点进去.!!!!!!!!!!!!!!!
  NumChangeWidget({Key key, this.height = 36.0, this.num = 1, this.onValueChanged}) : super(key: key);

  @override
  _NumChangeWidgetState createState() {
    return _NumChangeWidgetState();
  }
}

class _NumChangeWidgetState extends State<NumChangeWidget> {
var buttonsize= 30.0;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(2.0)),
        border: Border.all(color: Colors.grey, width: 0.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GestureDetector(
            onTap: _minusNum,
            child: Container(
              width: 32.0,
              alignment: Alignment.center,
              child:


              Icon(
                Icons.remove,
                color: Colors.red,
                semanticLabel: "user",
                size: buttonsize,
                textDirection: TextDirection.rtl,
              ),



            ),
          ),
          Container(
            width: 0.5,
            color: Colors.grey,
          ),
          Container(
            width: 62.0,
            alignment: Alignment.center,
            child: Text(widget.num.toString(), maxLines: 1, style: TextStyle(fontSize: 20.0, color: Colors.black),),
          ),
          Container(
            width: 0.5,
            color: Colors.grey,
          ),
          GestureDetector(
            onTap: _addNum,
            child: Container(
              width: 32.0,
              alignment: Alignment.center,
              child:



              Icon(
                Icons.add,
                color: Colors.red,
                semanticLabel: "user",
                size: buttonsize,
                textDirection: TextDirection.rtl,
              ),










            ),
          ),
        ],
      ),
    );
  }

  void _minusNum() {
    if (widget.num == 0) {
      return;
    }

    setState(() {
      widget.num -= 1;

      if (widget.onValueChanged != null) {
        widget.onValueChanged(widget.num);
      }
    });
  }

  void _addNum() {
    setState(() {
      widget.num += 1;

      if (widget.onValueChanged != null) {
        widget.onValueChanged(widget.num);
      }
    });
  }
}






