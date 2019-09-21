import 'package:flutter/material.dart';
import 'package:flutter_jd/common/util/ScreenHelper.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatefulWidget {
  final arguments;

  HomePage({this.arguments});

  @override
  _HomePageState createState() => _HomePageState(arguments: arguments);
}

class _HomePageState extends State<HomePage> {
  final arguments;

  _HomePageState({this.arguments});

  @override
  Widget build(BuildContext context) {
    ScreenHelper.init(context);
    return ListView(
      children: <Widget>[
        bannerLayer(),
        SizedBox(height: ScreenHelper.height(10),),
        titleLayer("猜你喜欢"),
        hotProductLayer(),
        SizedBox(height: ScreenHelper.height(10),),
        titleLayer("热门推荐"),
      ],
    );
  }

  ///顶部Banner
  bannerLayer() {
    List<Map> imgList = [
      {
        "url":
            "https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=577169893,2262228506&fm=26&gp=0.jpg"
      },
      {
        "url":
            "https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=3441742992,2765570575&fm=26&gp=0.jpg"
      },
      {
        "url":
            "https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=384115025,2366469586&fm=26&gp=0.jpg"
      },
    ];
    return Container(
        child: AspectRatio(
      aspectRatio: 2 / 1,
      child: Swiper(
        itemCount: imgList.length,
        itemBuilder: (context, index) {
          return Image.network(
            imgList[index]["url"],
            fit: BoxFit.cover,
          );
        },
        pagination: SwiperPagination(),
        autoplay: true,
      ),
    ));
  }

  ///标题
  titleLayer(title) {
    return Container(
      height: ScreenHelper.height(36),
      margin: EdgeInsets.only(left: ScreenHelper.width(10)),
      padding: EdgeInsets.only(left: ScreenHelper.width(10)),
      decoration: BoxDecoration(
          border: Border(
              left: BorderSide(
        color: Colors.red,
        width: 4,
      ))),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.black54,
        ),
      ),
    );
  }

  ///热门商品
  hotProductLayer() {
    return Container(
      margin: EdgeInsets.only(top: ScreenHelper.height(20)),
      padding: EdgeInsets.only(left: ScreenHelper.width(20)),
      height: ScreenHelper.height(144),
      child:  ListView.builder(
        scrollDirection: Axis.horizontal ,
        itemBuilder: (context,index){
          return Column(
            children: <Widget>[
              Container(
                width: ScreenHelper.width(100),
                height: ScreenHelper.height(100),
                margin: EdgeInsets.only(right: ScreenHelper.width(20)),
                child: Image.network("https://www.itying.com/images/flutter/hot${index+1}.jpg"),
              ),
              Text("第$index条")
            ],
          );
        },
        itemCount: 10,
      ),
    );
  }
}
