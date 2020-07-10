body: Container(
height: 250.0,
child: Swiper(
itemBuilder: (BuildContext context, int index) {
return Image.network(
"http://img.zcool.cn/community/01ed9c55499c160000019ae993c9a4.jpg@2o.jpg",
fit: BoxFit.fill,);
},
itemCount: 5,
scrollDirection: Axis.horizontal,
loop: true,
duration: 300,
autoplay: true,
onIndexChanged: (index) {
debugPrint("index:$index");
},
onTap: (index) {
debugPrint("点击了第:$index个");
},
//                control:SwiperControl(),
pagination: SwiperPagination(
alignment: Alignment.bottomRight,
margin: EdgeInsets.only(bottom: 20.0, right: 20.0),
builder: SwiperPagination.fraction
),
//                autoplayDelay: 3000,
autoplayDisableOnInteraction : true
),
)