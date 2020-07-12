
import 'package:add_cart_parabola/add_cart_parabola.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:flutter_mall_cart/config/const.dart';

class AboutDemoViews extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AboutDemoViewsState(); 
  }

}

class AboutDemoViewsState extends State<AboutDemoViews> {
  GlobalKey floatKey = GlobalKey();
  GlobalKey rootKey = GlobalKey();
  GlobalKey rootKey2 = GlobalKey();
  List lists = [
    "公司简介",
    "公司信息",
    "联系我们",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: Image.network(
              ConstKey.startupImg,
              fit: BoxFit.cover
            ),
            width: ScreenUtil.getScreenW(context),
            height: 150,
          ),
          _render(),
        ],
      ),
    );
  }
var tel='15122306087';
  Widget _render() {
    var _f = ListView.separated(
      itemBuilder: (BuildContext f, int index) {
        var ele = lists[index];
        return ListTile(
          title: Text(ele),
          leading: Icon(Icons.score),
          onTap: () {
            if (index == 2) { //根据index书写即可.





              showDialog(
                context: context,builder: (_) => NetworkGiffyDialog(
                  image: Image.network(ConstKey.startupImg),
                  title: Text(
                    '留言',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                  description: Text("xx互联网科技电话\n"+tel,textAlign:TextAlign.center ,style: TextStyle(fontSize: 13),),
                  onlyOkButton: true, // 一般true,只需要一个ok按钮就狗了.
                  buttonOkText: Text("退出"),
                onlyCancelButton: true, //把按钮都闭了
                  entryAnimation: EntryAnimation.DEFAULT,
                  onOkButtonPressed: () {

//                    Navigator.of(context).pushReplacementNamed("app");
                    Navigator.of(context).pop(); // 调回 ,调回这个常用.


                  },
                )
              );
            }

            if (index == 0) { //根据index书写即可.


              showDialog(
                  context: context,builder: (_) => NetworkGiffyDialog(
                image: Image.network( ConstKey.startupImg  ,height: 99999999.0),


                title:
/*
*
AutoSizeText(
  "A really long String",
  style: TextStyle(fontSize: 30.0),
  maxLines: 2,
)
*
*
*
*
*
*
* */


                Text(
                  '公司简介',
                  style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.w600
                  ),
                ),
                description: Text("xx互联网科技成立于2020年6月.经营范围：web开发,app开发,人工智能,大数据服务等\n",textAlign:TextAlign.start ,style: TextStyle(fontSize: 13),),
                onlyOkButton: true, // 一般true,只需要一个ok按钮就狗了.
                buttonOkText: Text("退出"),
                onlyCancelButton: true, //把按钮都闭了
                entryAnimation: EntryAnimation.DEFAULT,
                onOkButtonPressed: () {

//                    Navigator.of(context).pushReplacementNamed("app");
                  Navigator.of(context).pop(); // 调回 ,调回这个常用.


                },
              )
              );
            }

            if (index == 1) { //根据index书写即可.








              showDialog(
                  context: context,builder: (_) => NetworkGiffyDialog(
                image: Image.network(ConstKey.startupImg),
                title: Text(
                  '公司信息',
                  style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.w600
                  ),
                ),
                description: Text("""技术人员:在京东,头条,中科院各大研究所等具有多年经验的开发人员.毕业或就职于南开大学,北京大学,中科院等研究机构,大部分硕士以上学历,拥有多年的人工智能和大数据经验\n\n项目案例:文本对齐任务:翻译模型基于champollion算法,搭建整个用户登录,翻译匹配,用户自定义删除修改,后台控制管理等.  nlp基础平台搭建任务:文本分类,关键词提取,文本纠错,情感分析,地址(电话,姓名,信息,自动补全)识别  人脸考勤服务:基于facenet搭建人脸识别比对算法.""",textAlign:TextAlign.left ,style: TextStyle(fontSize: 10.9),overflow:TextOverflow.clip ,),
                onlyOkButton: true, // 一般true,只需要一个ok按钮就狗了.
               onlyCancelButton: true, //把按钮都闭了
//                buttonOkText: Text("退出"),
                entryAnimation: EntryAnimation.DEFAULT,
                onOkButtonPressed: () {
                  Navigator.of(context).pop(); // 调回 ,调回这个常用.
                },
              )
              );









            }
          },
        );
      },
      separatorBuilder: (BuildContext ctx, int x) {
        return Divider(
          height: 1,
          color: Theme.of(ctx).accentColor
        );
      },
      itemCount: lists.length
    );
    return Container(
      child: _f,
      // TODO: 高度不能这样算...
      width: ScreenUtil.getScreenW(context),
      height: ScreenUtil.getScreenH(context)-400 ,
    );
  }

}