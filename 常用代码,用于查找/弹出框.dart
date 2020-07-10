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
                  entryAnimation: EntryAnimation.DEFAULT,
                  onOkButtonPressed: () {

//                    Navigator.of(context).pushReplacementNamed("app");
                    Navigator.of(context).pop(); // 调回 ,调回这个常用.


                  },
                )
              );