
import 'package:flutter/material.dart';
import 'package:flutter_mall_cart/api/list.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:flutter_mall_cart/api/list.dart';

class ListDemoViews extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return ListDemoViewsState();  
  }

}

class ListDemoViewsState extends State {

  List lists = [];

  @override
  void initState() {
    getList();
    super.initState();
  }

  void getList() async {
    var _lists = await RandomListApi.getLists();
    setState(() {
      lists = _lists;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: lists.isEmpty ? Center(
          child: CircularProgressIndicator(),
        ) : _render(),
      ),
    );
  }

  Widget _render() {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext ctx, int index) {
        var item = lists[index];
        return ListTile(
          title: Text(item['title'], style: TextStyle(color: Colors.blue)),
          subtitle: Text(item['author']),
          leading: Icon(Icons.airline_seat_flat_angled),
          trailing: Icon(Icons.arrow_forward),










        );
      },
      separatorBuilder: (BuildContext ctx, int index) {
        return Divider(
          color: Theme.of(context).accentColor,
          height: 1.0,
        );
      },
      itemCount: lists.length
    );
  }

}