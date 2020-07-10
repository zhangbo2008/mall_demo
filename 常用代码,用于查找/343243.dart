//获取屏幕宽和高


MediaQueryData queryData;
queryData = MediaQuery.of(context);
var w=queryData.size.width;
var h =queryData.size.height;
print('打印宽度');
print(w);
print(h);