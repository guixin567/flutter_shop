import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jd/common/constant/ArgumentKey.dart';
import 'package:flutter_jd/common/constant/RequestURL.dart';
import 'package:flutter_jd/common/util/ImageUtil.dart';
import 'package:flutter_jd/common/util/Log.dart';
import 'package:flutter_jd/common/util/ScreenHelper.dart';
import 'package:flutter_jd/common/widget/LodingMoreView.dart';
import 'package:flutter_jd/common/widget/TagText.dart';
import 'package:flutter_jd/main/home/bean/product_entity.dart';
import 'package:flutter_jd/search/service/SearchService.dart';

class ProductListPage extends StatefulWidget {
  final arguments;

  ProductListPage({this.arguments});

  @override
  _ProductListPageState createState() =>
      _ProductListPageState(arguments: arguments);
}

class _ProductListPageState extends State<ProductListPage> {
  final arguments;
  var _page = 1;                                                                      //页面
  var _pageSize = "5";                                                                //一页数据
  ProductEntity _productEntity;
  List<ProductResult> _productList = [];
  ScrollController _controller = ScrollController();
  var _isRequesting = false;                                                          //正在请求
  final GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();
  var _hasMore = false;                                                               //是否加载更多
  var _hasNoData = false;                                                             //是否为空数据
  var _selectTabId = 1;                                                               //Tab选中的索引ID
  var _sort = "";                                                                     //接口里面排序
  var _cateId = "";
  var _searchWord = "";
  var _searchController = TextEditingController();

  var headerTabList = [
    {
      "id": 1, //通过ID来设置选中状态
      "title": "综合", //标题
      "fileds": "all", //跟sort一起组合成接口需要的排序字段
      "sort": -1,
    },
    {
      "id": 2,
      "title": "销量",
      "fileds": "salecount",
      "sort": -1,
    },
    {
      "id": 3,
      "title": "价格",
      "fileds": "price",
      "sort": -1,
    },
    {
      "id": 4,
      "title": "筛选",
    },
  ];

  _ProductListPageState({this.arguments});

  @override
  void initState() {
    super.initState();
    _cateId = arguments["${ArgumentKey.cateId}"]??"";
    _searchWord = arguments["${ArgumentKey.searchWord}"]??"";
    _searchController.text = _searchWord;
    _getProductList();
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        if (_hasMore) {
          _getProductList();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      appBar: initAppBar(),
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

  AppBar initAppBar() {
    if(_searchWord.isEmpty){
      return AppBar(
        title: Text("Product List"),
        actions: [Text("")],
      );
    }
    return AppBar(
      title: Container(
        height: ScreenHelper.height(76),
        padding: EdgeInsets.only(left: 15),
        decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(20)
        ),
        child: TextField(
          autofocus: false,
          controller: _searchController,
          onChanged: (value){
          },
          decoration: InputDecoration(
              border: InputBorder.none
          ),
        ),
      ),
      actions: <Widget>[
        InkWell(
          child: Container(
            padding: EdgeInsets.only(left:20,right: 20),
            alignment: Alignment.center,
            child: Text("搜索"),
          ),
          onTap: ()async{
            await SearchService.setSearchData(_searchController.text);
            if(_searchController.text.isNotEmpty)  _subHeaderChange(1);
          },

        )
      ],
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
          children: headerTabList.map((tab) {
            return Expanded(
              child: InkWell(
                child: Container(
                    height: double.infinity,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          tab["title"],
                          style: TextStyle(
                              color: (_selectTabId == tab["id"])
                                  ? Colors.red
                                  : Colors.grey),
                        ),
                        _showTabArrow(tab["id"],tab["sort"]),
                      ],
                    )),
                onTap: () {
                  setState(() {
                    _subHeaderChange(tab["id"]);
                  });
                },
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  void _subHeaderChange(id) {
      _selectTabId = id;
      var tab = headerTabList[id-1];
    if (id != 4) {
      _sort = "${tab["fileds"]}_${tab["sort"]}";
      _page = 1; //重置页码
      tab['sort'] = -1 * tab['sort']; //点击取反
      _productList = []; //重置数据
      _controller.jumpTo(0); //回到顶部
      _getProductList();
    } else {
      globalKey.currentState.openEndDrawer();
    }
  }

  ///无Tab列表
  Widget _productListWidget() {
    if (_productEntity == null ||
        _productEntity.result == null ||
        _productList.length == 0) {
      if(_hasNoData) return Center(child: Text("空数据"),);
      return LoadingMoreView();
    } else {
      return Container(
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
                                      new TagText("4G")
                                    ],
                                  ),
                                ),
                                Text("${_productList[index].price}￥")
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
  StatelessWidget showMoreWidget(int index) {
    if (_hasMore) {
      return index == _productList.length - 1 ? LoadingMoreView() : Text("");
    } else {
      return index == _productList.length - 1 ? Text("加载完了...") : Text("");
    }
  }

  void _getProductList() async {
    if (_isRequesting) return;
    _isRequesting = true;
    var url =
        "${productListUrl}cid=$_cateId&search=${_searchController.text}&page=$_page&pageSize=$_pageSize&sort=$_sort";
    Log.d('$url');
    var response = await Dio().get(url);
    setState(() {
      _productEntity = ProductEntity.fromJson(response.data);
      _productList.addAll(_productEntity.result);
      if (_productEntity.result.length > 0) {
        _page++;
        _hasMore = true;
      } else {
        _hasMore = false;
      }
      _hasNoData = _productList.isEmpty;
      _isRequesting = false;
    });
  }

  ///显示Tab上的箭头
  _showTabArrow(id,sort) {
    if(id == 2 || id == 3){
      return Icon(sort == -1 ? Icons.arrow_drop_down : Icons.arrow_drop_up,color: _selectTabId == id ? Colors.red : Colors.grey,);
    }else{
      return Text("");
    }
  }
}
