// 最后一个界面,我的,负责控制登录,和记录账号信息.
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:flutter_mall_cart/config/const.dart';

class myViews2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AboutDemoViewsState();
  }

}

class AboutDemoViewsState extends State<myViews2> {

  @override
  Widget build(BuildContext context) {
    return LoginPage();
  }

}





class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = new GlobalKey<FormState>();

  String _userID;
  String _password;
  bool _isChecked = true;
  bool _isLoading;
  IconData _checkIcon = Icons.check_box;

  void _changeFormToLogin() {
    _formKey.currentState.reset();
  }

  void _onLogin() {
    final form = _formKey.currentState;
    form.save();

    if (_userID == '') {
      _showMessageDialog('账号不可为空');
      return;
    }
    if (_password == '') {
      _showMessageDialog('密码不可为空');
      return;
    }
  }

  void _showMessageDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text('提示'),
          content: new Text(message),
          actions: <Widget>[
            new FlatButton(
              child: new Text("ok"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _showEmailInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15.0, 10.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        style: TextStyle(fontSize: 15),
        decoration: new InputDecoration(
            border: InputBorder.none,
            hintText: '请输入帐号',
            icon: new Icon(
              Icons.email,
              color: Colors.grey,
            )),
        onSaved: (value) =>{ _userID = value.trim(),print(2222222222)}

      ),
    );
  }

  Widget _showPasswordInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15.0, 10.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        obscureText: true,
        autofocus: false,
        style: TextStyle(fontSize: 15),
        decoration: new InputDecoration(
            border: InputBorder.none,
            hintText: '请输入密码',
            icon: new Icon(
              Icons.lock,
              color: Colors.grey,
            )),
        onSaved: (value) => {_password = value.trim(), print(11111111)} //脱离焦点的时候就已经得到了
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CupertinoNavigationBar(
          backgroundColor: Colors.white,
          middle: const Text('欢迎登录拼少少'),
        ),
        body: ListView(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 30),
              height: 225,
              child: Image.network("https://img1.gamersky.com/image2020/06/20200630_gd_340_6/gamersky_01small_02_20206301255524.jpg"),
            ),
            Form(
              key: _formKey,   //key 来表示form的身份.
              child: Container(
                height: 130,
                padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                child: Card(
                  child: Column(  // column 需要配置flex
                    children: <Widget>[
                      _showEmailInput(),
                      Divider(
                        height: 0.5,
                        indent: 10.0,
                        color: Colors.grey[300],
                      ),
                      _showPasswordInput(),
                    ],
                  ),
                ),









              ),
            ),
            Container(
              height: 70,
              padding: const EdgeInsets.fromLTRB(35, 30, 35, 0),
              child: OutlineButton(
                child: Text('登录'),
                textColor: Colors.orange,
                color: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                borderSide: BorderSide(color: Colors.orange, width: 1),
                onPressed: () {
                  _onLogin();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 10, 50, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  IconButton(
                      icon: Icon(_checkIcon),
                      color: Colors.orange,
                      onPressed: () {
                        setState(() {
                          _isChecked = !_isChecked;
                          if (_isChecked) {
                            _checkIcon = Icons.check_box;
                          } else {
                            _checkIcon = Icons.check_box_outline_blank;
                          }
                        });
                      }),
                  Expanded(
                    child: RichText(
                        text: TextSpan(text: '我已经详细阅读并同意', style: TextStyle(color: Colors.black, fontSize: 13), children: <TextSpan>[
                          TextSpan(text: '《隐私政策》', style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline)),
                          TextSpan(text: '和'),
                          TextSpan(text: '《用户协议》', style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline))
                        ])),
                  )
                ],
              ),
            )
          ],
        ));
  }
}