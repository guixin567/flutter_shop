import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jd/common/constant/ArgumentKey.dart';
import 'package:flutter_jd/common/constant/RequestURL.dart';
import 'package:flutter_jd/common/util/ImageUtil.dart';
import 'package:flutter_jd/common/util/ScreenHelper.dart';
import 'package:flutter_jd/common/widget/LodingMoreView.dart';
import 'package:flutter_jd/main/home/bean/product_entity.dart';

class ProductListPage extends StatefulWidget {
  final arguments;

  ProductListPage({this.arguments});

  @override
  _ProductListPageState createState() =>
      _ProductListPageState(arguments: arguments);
}

class _ProductListPageState extends State<ProductListPage> {
  final arguments;
  var _page = 1;                                                 //页面
  var _pageSize = "5";                                           //一页数据
  ProductEntity _productEntity;
  List<ProductResult> _productList = [];
  ScrollController _controller = ScrollController();
  var _isRequesting = false;                                     //正在请求
  var _hasMore = false;
  _ProductListPageState({this.arguments});
  final GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    var cateId = arguments["${ArgumentKey.cateId}"];
    _getProductList(cateId);
    _controller.addListener((){
      if(_controller.position.pixels == _controller.position.maxScrollExtent){
        if(_hasMore){
          _getProductList(cateId);
        }
      }
    });
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

  ///无Tab列表
   Widget _productListWidget() {
     if(_productEntity == null || _productEntity.result == null ||_productList.length == 0){
       return LoadingMoreView();
    }else{
      return  Container(
        margin: EdgeInsets.only(top: 50),
        child: Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: ListView.builder(
            controller: _controller,
            itemCount: _productList.length,
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
                              ImageUtil.getImageUrl(_productList[index].pic),
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
                                  _productList[index].title,
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
                  showMoreWidget(index),
                ],
              );
            },
          ),
        ),
      );
    }
  }
  //显示加载更多
  StatelessWidget showMoreWidget(int index){
    if(_hasMore){
      return index == _productList.length -1 ? LoadingMoreView(): Text("");
    }else{
      return index == _productList.length -1 ? Text("加载完了..."): Text("");
    }
  }

  void _getProductList(goodsId) async{
    if(_isRequesting) return;
    _isRequesting = true;
    var url = "${productListUrl}cid=$goodsId&page=$_page&pageSize=$_pageSize";
    print('$url');
    var response = await Dio().get(url);
    setState(() {
      _productEntity = ProductEntity.fromJson(response.data);
      _productList.addAll(_productEntity.result);
      if(_productEntity.result.length>0){
        _page++;
        _hasMore = true;
      }else{
        _hasMore = false;
      }
      _isRequesting = false;
    });
  }
}
