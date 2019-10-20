import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jd/common/constant/ArgumentKey.dart';
import 'package:flutter_jd/common/constant/RequestURL.dart';
import 'package:flutter_jd/common/route/RoutePath.dart';
import 'package:flutter_jd/common/util/ImageUtil.dart';
import 'package:flutter_jd/common/util/ScreenHelper.dart';
import 'package:flutter_jd/main/home/bean/home_banner_entity.dart';
import 'package:flutter_jd/main/home/bean/product_entity.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatefulWidget {
  final arguments;

  HomePage({this.arguments});

  @override
  _HomePageState createState() => _HomePageState(arguments: arguments);
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin{
  final arguments;
  HomeBannerEntity homeBannerEntity;                                            //banner数据
  ProductEntity hotProductEntity;                                               //热门商品
  ProductEntity bottomProductEntity;                                            //底部商品



  _HomePageState({this.arguments});

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    bannerRequest();
    hotProductRequest();
    bottomProductRequest();
  }

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
        bottomProductLayer(),
      ],
    );
  }

  ///顶部Banner
  bannerLayer() {
    if(homeBannerEntity == null || homeBannerEntity.result == null || homeBannerEntity.result.length == 0){
      return Text("");
    }
    return Container(
        child: AspectRatio(
      aspectRatio: 2 / 1,
      child: Swiper(
        itemCount: homeBannerEntity.result.length,
        itemBuilder: (context, index) {
          var bannerUrl = "http://jd.itying.com/${homeBannerEntity.result[index].pic}".replaceAll("\\", "/");
          return Image.network(
            bannerUrl,
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
    if(hotProductEntity == null ||hotProductEntity.result == null || hotProductEntity.result.length == 0){
      return Text("");
    }
    return Container(
      margin: EdgeInsets.only(top: ScreenHelper.height(20)),
      padding: EdgeInsets.only(left: ScreenHelper.width(20)),
      height: ScreenHelper.height(144),
      child:  ListView.builder(
        scrollDirection: Axis.horizontal ,
        itemBuilder: _hotProductBuilder,
        itemCount: hotProductEntity.result.length,
      ),
    );
  }

  ///底部商品
  bottomProductLayer() {
    if(bottomProductEntity == null || bottomProductEntity.result == null || bottomProductEntity.result.length == 0){
      return Text("");
    }
    return Container(
      padding: EdgeInsets.all(10),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: bottomProductItems(),
      ),
    );
  }

  ///底部商品条目
  bottomProductItems() {
    List<Widget> productWidgets = [];
    for(ProductResult product in bottomProductEntity.result){
      var container = Container(
        width: (ScreenHelper.screenWidthDp - 30)/2,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(
              color: Color.fromRGBO(233, 233, 233, 0.9),
              width: 1,
            )
        ),

        child: InkWell(
          onTap: (){
            Navigator.pushNamed(context, routeProductDetail,arguments: {ArgumentKey.goodsId:"${product.sId}"});
          },
          child: Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  child: AspectRatio(
                    aspectRatio: 1/1,
                    child: Image.network(ImageUtil.getImageUrl(product.pic),fit: BoxFit.cover,),
                  ),
                ),
                SizedBox(height: 5,),
                Text(product.title,maxLines: 2,overflow: TextOverflow.ellipsis,),
                SizedBox(height: 5,),
                Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text("￥188",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Text("￥488",
                        style: TextStyle(
                          color: Colors.black54,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ),
                  ],
                )
              ]
          ),
        ),
      );
      productWidgets.add(container);
    }
    return productWidgets;
  }

  Widget _hotProductBuilder(BuildContext context, int index) {
    return Column(
      children: <Widget>[
        Container(
          width: ScreenHelper.width(100),
          height: ScreenHelper.height(100),
          margin: EdgeInsets.only(right: ScreenHelper.width(20)),
          child: Image.network(ImageUtil.getImageUrl(hotProductEntity.result[index].pic)),
        ),
        SizedBox(height: 5),
        Text("${hotProductEntity.result[index].price}")
      ],
    );
  }

  ///banner请求
  void bannerRequest() async {
    var dio = Dio();
    var response = await dio.get(bannerUrl);
    setState(() {
      homeBannerEntity = HomeBannerEntity.fromJson(response.data);
    });
  }

  ///水平商品请滶
  void hotProductRequest() async{
    var response = await Dio().get(youMayLikeUrl);
    setState(() {
      hotProductEntity = ProductEntity.fromJson(response.data);
    });
  }

  ///底部商品
  void bottomProductRequest() async{
    var response = await Dio().get(youMayLikeUrl);
    setState(() {
      bottomProductEntity = ProductEntity.fromJson(response.data);
    });
  }
}
