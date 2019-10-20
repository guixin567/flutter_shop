import 'package:flutter/material.dart';
import 'package:flutter_jd/common/util/ScreenHelper.dart';
import 'package:flutter_jd/product/detail/tabs/DetailContent.dart';
import 'package:flutter_jd/product/detail/tabs/ProductContent.dart';
import 'package:flutter_jd/product/detail/tabs/ReviewContent.dart';

class ProductDetailPage extends StatefulWidget {
  final arguments;

  ProductDetailPage({this.arguments});

  @override
  _ProductDetailPageState createState() =>
      _ProductDetailPageState(arguments: arguments);
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final arguments;

  _ProductDetailPageState({this.arguments});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Container(
              width: ScreenHelper.width(400),
              child: TabBar(
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: Colors.red,
                tabs: <Widget>[
                  Tab(
                    text: "商品",
                  ),
                  Tab(
                    text: "详情",
                  ),
                  Tab(
                    text: "评价",
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                buildShowMenu(context);
              },
              icon: Icon(Icons.more_horiz),
            )
          ],
        ),
        body: Stack(
          children: <Widget>[
            TabBarView(
              children: <Widget>[
                ProductContent(),
                DetailContent(),
                ReviewContent(),
              ],
            ),
            Positioned(
              width: ScreenHelper.screenWidthDp,
              bottom: 0,
              child: Container(
                padding: EdgeInsets.only(left: 10,right: 10),
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                  color: Colors.black12,
                ))),
                child: Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Icon(Icons.shopping_cart),
                        Text("购物车"),
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left:16.0,right: 8.0),
                        child: FlatButton(
                          color: Colors.red,
                          textColor: Colors.white,
                          child: Text("加入购物车"),
                          onPressed: () {},
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left:8.0,right: 8.0),
                        child: FlatButton(
                          color: Colors.red,
                          textColor: Colors.white,
                          child: Text("立即购买"),
                          onPressed: () {},
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future buildShowMenu(BuildContext context) {
    return showMenu(
        context: context,
        position: RelativeRect.fromLTRB(700, 80, 0, 20),
        items: [
          PopupMenuItem(
            child: Row(
              children: <Widget>[Icon(Icons.home), Text("首页")],
            ),
          ),
          PopupMenuItem(
            child: Row(
              children: <Widget>[Icon(Icons.search), Text("搜索")],
            ),
          )
        ]);
  }
}
