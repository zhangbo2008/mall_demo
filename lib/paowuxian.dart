import 'dart:ui';


import 'package:add_cart_parabola/add_cart_parabola.dart';
import 'package:flutter/material.dart';




//void main() => runApp(MyApp());

class MyApp21 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);



  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  GlobalKey floatKey = GlobalKey();
  GlobalKey rootKey = GlobalKey();   //开始坐标
  GlobalKey rootKey2 = GlobalKey();
  Offset floatOffset ;//结束坐标

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      RenderBox renderBox = floatKey.currentContext.findRenderObject();
      floatOffset = renderBox.localToGlobal(Offset.zero);//floatingActionButton 的坐标.
      print('dayindongzuo' );
      print(floatOffset);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key:rootKey2,
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Container(
          key: rootKey,


          child:  RaisedButton(

            color: Colors.blue,
            child: Text("button "),
            onPressed: (){
              setState(() {
                OverlayEntry entry = OverlayEntry(
                    builder: (ctx){
                      return ParabolaAnimateWidget(rootKey2,Offset(1,2),Offset(100,200), Icon(Icons.cancel,color: Colors.greenAccent,),(i){},)
                      ;
                    }
                );
                Overlay.of(rootKey.currentContext).insert(entry);



              });
            },
          )







        ,

      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow,
        key: floatKey,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }



  Widget generateItem(int index){
    Function callback ;


    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var w=queryData.size.width;
    var h =queryData.size.height;
    Offset temp;
    temp = new Offset(w/2, h/2);

    RenderBox renderBox = floatKey.currentContext.findRenderObject();
    floatOffset = renderBox.localToGlobal(Offset.zero);
    //GlobalKey itemKey = GlobalKey();



    return RaisedButton(

      color: Colors.blue,
      child: Text("button "),
      onPressed: (){
        setState(() {
          OverlayEntry entry = OverlayEntry(
            builder: (ctx){
              return ParabolaAnimateWidget(rootKey2,temp,floatOffset, Icon(Icons.cancel,color: Colors.greenAccent,),callback,)
              ;
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



}











