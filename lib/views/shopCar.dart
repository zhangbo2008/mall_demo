//这个代码实现一个计数器,在各个页面中共享数据,从而达到购物车数据和用于数据在各个页面共享的效果.
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mall_cart/pages/detail.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:flutter_mall_cart/config/const.dart';
import 'dart:async';
import 'package:flutter_mall_cart/app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:oktoast/oktoast.dart';
//import '../pages/detail.dart';
import 'package:w_popup_menu/w_popup_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_mall_cart/api/home.dart';





// 购物车的加减条: 注意这里面的逻辑跟detail里面的加减条不一样. 这个加减条需要联动consumer做信号处理.



class NumChangeWidget extends StatefulWidget {


  final double height;
  int num=1;
  final ValueChanged<int> onValueChanged;

  var dangqianwupin;
// 注意这里面默认值需要设置1, 因为没有傻逼为了买0个还点进去.!!!!!!!!!!!!!!!
  NumChangeWidget({Key key, this.height = 36.0, this.num = 1, this.onValueChanged,this.dangqianwupin=''}) : super(key: key);

  @override
  _NumChangeWidgetState createState() {
    print(this.dangqianwupin);

    return _NumChangeWidgetState(dangqianwupin:this.dangqianwupin); //一层一层传进去.
  }
}
var tmp999;//临时变量,用于函数之间通信.
class _NumChangeWidgetState extends State<NumChangeWidget> {
  var height;

  var num;

  var dangqianwupin;

  var onValueChanged;


  _NumChangeWidgetState({Key key, this.height = 36.0, this.num = 1, this.onValueChanged,this.dangqianwupin=''});





  var buttonsize= 30.0;


  @override
  Widget build(BuildContext context) {
   print(this.dangqianwupin);
   print('传入的参数是上面这个');


    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(2.0)),
        border: Border.all(color: Colors.grey, width: 0.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: 3000,
          )// 这个是pad,

          ,

          SizedBox(
            height: 3000,
          )// 这个是pad,

,



          Consumer<MyModel>(
              builder: (context, model, child) {
                return
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.num -= 1;

                        if (widget.onValueChanged != null) {
                          widget.onValueChanged(widget.num);
                        }
                      });


                      model.updateproduct(this.dangqianwupin, widget.num);
                      print('查看当前的model');
                      print('${model.product}');
                      print("guankan !!!!!!!!!!!!!!!!!!!!!!!!!!!!")//确实更新到字典了!!!!!!!!
                      ;
                    },


                    //返回为void的函数不能有入参,
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
                  );}),






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

        Consumer<MyModel>(
            builder: (context, model, child) {
          return
          GestureDetector(
            onTap: () {
              setState(() {
                widget.num += 1;

                if (widget.onValueChanged != null) {
                  widget.onValueChanged(widget.num);
                }
              });


              model.updateproduct(this.dangqianwupin, widget.num);
              print('查看当前的model');
              print('${model.product}');
              print("guankan !!!!!!!!!!!!!!!!!!!!!!!!!!!!")
              ;
            },


            //返回为void的函数不能有入参,
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
          );}),
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

   void addNum() {
    setState(() {
      widget.num += 1;

      if (widget.onValueChanged != null) {
        widget.onValueChanged(widget.num);
      }
    });
  }
}




//  下面是核心代码!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

class myViews3 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AboutDemoViewsState();
  }
}


class AboutDemoViewsState extends State<myViews3> {


var data;

  @override       //这个函数是初始化, 定义一些数据,让下面方便使用, 下面就不用每次都获取了!!!!!!!!!!
  void initState() {
    print('44444444444444444444444444');
    getDouBan() async {
      var data2 = await AppHomeApi.getDouBanApi();
      setState(() {
        print('3242342342342342');
        print(data);
        print('9999999999999999999999999922222222222222222222222222');
data=data2;

      });
    }
    getDouBan();
    super.initState();  //注意这个一定要写上才能做init. 因为init里面的默认方法一定要调用.
  }





  @override
  Widget build(BuildContext context) {

    print(data);
    print('67890');


    return
      Scaffold(
//        appBar: AppBar(
//          title: Text('购物车'),
//        ),
        body: Column(
          children: <Widget>[
            Consumer<MyModel>(// 把相应好的东西协商去即可!!!!!!!!!!!
              builder: (context, model, child) {




                /*2020-07-10,20点13 下面我就开始修改这个, 不再text一个字典,而是吧每一个商品画出来.*/
                return Container(
                  margin: const EdgeInsets.only(top: 20),
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.center,
                  color: Colors.lightGreen,
                  child: model.product.isNotEmpty ?
                  Column(children:
                 [
                   Text('购物车'),
                   SizedBox(
                     height: 30,
                   ),

                   Column( // model.product 这个才是传入的变量. 注意外面不要再套括号了!!!!!!!!! 套小括号可以,大括号不行.
                    children: _itemViewChild(model,context,data),

                  )

,



                   Row( // 下面2行是设置2个轴的对齐方向,也就是水平和数值方向对齐方法.
                     crossAxisAlignment:CrossAxisAlignment.center,
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: <Widget>[ SizedBox(
                       height: 2,
                     ),
                       FlatButton(
                         child: Text('支付'),
                       ),

                       Consumer<MyModel>(
                           builder: (context, model, child) {
var sum=0;
    model.product.forEach((String key,int value) {
      sum+=value;
      });




                             return FlatButton(     child: Text('$sum'));})
,

                     ],
                   )









                 ]






                  )
                      :Text( '购物车为空')

                ); // Text( '${model.product}')
              },
            ),

          ],
        ),

    );
  }
}



Widget fun1(){ // 把需要的widegt抽出来成为一个函数.需要的时候fun1() 调用返回这个widget即可.




  return Text('dafdsfasdf');

}





List<Widget> _itemViewChild(model,c,d) {
  print(d);
  print('876544331');
  print(model);
  var row = new Row(
    children: <Widget>[

      Text('1')
    ],
  );
  List<Widget> listWidget = List();
  listWidget.clear();
  listWidget.add(row);
  listWidget.add(new Baseline(
    baseline: 1,
    baselineType: TextBaseline.alphabetic,
    child: new Container(
      color: Color(0xFFededed),
      height: 1,
      width: double.infinity,
    ),
  ));

  List<Widget> listWidgetChild = List();
  listWidgetChild.clear();

// listAll = {"a":1,"b":2,"c":3};

  var tmp3=NumChangeWidget;
  print(tmp3);
  var urlmap=model.urls;
  print('ffffffffffffffffffff');
  print(urlmap);
  model.product.forEach((String key,int value){
    print("$key  $value");
    listWidgetChild.add(

        GestureDetector(



          onTap: () async{

var tmp;
            //获取item
key;
//            List data = await AppHomeApi.getDouBanApi();
//            print(data);
            print('8888888888888888888888888888');
            d.forEach((element) {
              if (element['title']==key){
                tmp=element;
              }


            });
//            item=data[key];



            Navigator.of(c).push( //路由跳转到.  CatDetailPage(item: item) 这个. //并且用的是page内部跳转.
                MaterialPageRoute(builder: (ctx) {
                  return CatDetailPage(item: tmp);
                }
                ));
          },






        onLongPress: () {print('333333333333333333333');} ,child:


      // 套一层Gesturedetector.
      Row( // 下面2行是设置2个轴的对齐方向,也就是水平和数值方向对齐方法.
      crossAxisAlignment:CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
SizedBox(height:50),



        Image.network(urlmap[key],width: 50,height: 50,),



        Text('$key          '),

//        Consumer<MyModel>(// 把相应好的东西协商去即可!!!!!!!!!!!,需要更新参数的套上一层consumer
//        builder: (context, model, child) {NumChangeWidget(num:value);}
        NumChangeWidget(num:value,dangqianwupin:(key))
      ],
    ))



    );
  });





//  for (var b = 0; b < listAll.item.length; b++) {
//    var selected = listAll.item[b].selected;
//    listWidgetChild.add(Text('dsfadsf'));
//  }
  listWidget= listWidgetChild;

  return listWidget;
}

















