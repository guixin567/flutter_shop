import 'package:flutter/material.dart';
import 'package:flutter_jd/common/constant/ArgumentKey.dart';
import 'package:flutter_jd/common/util/ScreenHelper.dart';

class ProductListPage extends StatefulWidget {
  final arguments;

  ProductListPage({this.arguments});

  @override
  _ProductListPageState createState() =>
      _ProductListPageState(arguments: arguments);
}

class _ProductListPageState extends State<ProductListPage> {
  final arguments;
  _ProductListPageState({this.arguments});
  final GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    var goodsId = arguments["${ArgumentKey.goodsId}"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        title: Text("Product List"),
        actions: [
          Text("")
        ],
      ),
      endDrawer: Drawer(
        child: Text("Test Drawer"),
      ),
      body: Stack(
        children: <Widget>[
          _productListWidget(),
          _productHeaderWidget(),
        ],
      ),
    );
  }

  ///顶部Tab
  Positioned _productHeaderWidget() {
    return Positioned(
          height: 50,
          width: ScreenHelper.screenWidthDp,
          top: 0,
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey[300],
                ),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: InkWell(
                    child: Container(
                        height: double.infinity,
                        alignment: Alignment.center,
                        child: Text("综合")),
                    onTap: () {},
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: Container(
                      height: double.infinity,
                      alignment: Alignment.center,
                      child: Text("销量"),
                    ),
                    onTap: () {},
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: Container(
                        height: double.infinity,
                        alignment: Alignment.center,
                        child: Text("价格")),
                    onTap: () {},
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: Container(
                        height: double.infinity,
                        alignment: Alignment.center,
                        child: Text("筛选")),
                    onTap: () {
                      globalKey.currentState.openEndDrawer();
                    },
                  ),
                ),
              ],
            ),
          ),
        );
  }

  ///无Taab列表
  Container _productListWidget() {
    return Container(
      margin: EdgeInsets.only(top: 50),
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return Column(
              children: <Widget>[
                Container(
                  height: ScreenHelper.screenWidthDp / 4 + 20,
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: ScreenHelper.screenWidthDp / 4,
                        child: AspectRatio(
                          aspectRatio: 1 / 1,
                          child: Image.network(
                            "http://e.hiphotos.baidu.com/image/h%3D300/sign=a9e671b9a551f3dedcb2bf64a4eff0ec/4610b912c8fcc3cef70d70409845d688d53f20f7.jpg",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 10),
                          height: ScreenHelper.screenWidthDp / 4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "联想小新pro13,京东首发联想小新pro13,京小新pro13,京东首发联想东首发联想小新pro13,京东首发",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Container(
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      child: Text("4G"),
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4))),
                                      padding: EdgeInsets.only(
                                          left: 5, right: 5, top: 0, bottom: 0),
                                      margin: EdgeInsets.only(right: 5),
                                    )
                                  ],
                                ),
                              ),
                              Text("6599.00￥")
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Divider(
                  height: 1,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
