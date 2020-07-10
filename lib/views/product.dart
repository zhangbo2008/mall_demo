// 目前是一些段子区, 用api获取有趣文本.
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_mall_cart/api/v2api.dart';

class ProductViews extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProductViewsState();
  }

}

class ProductViewsState extends State<ProductViews> {

  List Hots = [];

  @override
  void initState() {
    setDataList();
    super.initState();
  }

  void setDataList() async {
    List _lists = await V2API.getHot();
    setState(() {
      Hots = _lists;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Hots.isEmpty ? Center(
        child: CircularProgressIndicator(),
      ) : ListTTY(context)
    );
  }

  Widget ListTTY(BuildContext context) {
    List<Widget> _render = Hots.map((dynamic item){
      return Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Image.network(
                item['member']['avatar_large'],
                fit: BoxFit.cover,
              ),
              width: 82,
              height:82,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24)
              ),
              margin: EdgeInsets.only(
                right: 12
              ),
            ),
            Expanded(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Text(
                      item['title'],
                      style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).accentColor
                      ),
                    ),
                    Html(
                      data: item['content_rendered'],
                      style: {
                        "p": Style(
                          fontSize: FontSize(15)
                        )
                      }
                    )
                  ],
                ),
                margin: EdgeInsets.only(bottom: 12),
              ),
            )
          ],
        ),
        padding: EdgeInsets.only(
          top: 12,
          bottom: 20
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey[300]
            )
          )
        ),
      );
    }).toList();
    return Container(
      // TODO 分隔线
      child: ListView(
        children: _render,
        padding: EdgeInsets.all(8),
      ),
    );
  }

}