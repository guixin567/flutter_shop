import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jd/common/constant/ArgumentKey.dart';
import 'package:flutter_jd/common/constant/RequestURL.dart';
import 'package:flutter_jd/common/route/RoutePath.dart';
import 'package:flutter_jd/common/util/ImageUtil.dart';
import 'package:flutter_jd/common/util/ScreenHelper.dart';
import 'package:flutter_jd/main/category/bean/left_category_entity.dart';
import 'package:flutter_jd/main/category/bean/right_category_entity.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> with AutomaticKeepAliveClientMixin{
  int leftSelectIndex = 0;
  LeftCategoryEntity leftCategoryEntity;
  RightCategoryEntity rightCategoryEntity;

  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    super.initState();
    _leftCategoryData();
  }

  @override
  Widget build(BuildContext context) {
    var leftWidth = ScreenHelper.screenWidthDp / 4;
    var rightItemWidth = (ScreenHelper.screenWidthDp - leftWidth - 20 - 20) / 4;
    var rightItemHeight = rightItemWidth + ScreenHelper.height(32);
    return Container(
      child: Row(
        children: <Widget>[
          _leftContainer(leftWidth),
          _rightContainer(rightItemWidth, rightItemHeight),
        ],
      ),
    );
  }

  ///左边布局
  _leftContainer(leftWidth) {
    if (leftCategoryEntity == null ||
        leftCategoryEntity.result == null ||
        leftCategoryEntity.result.length == 0) {
      return Container(
        width: leftWidth,
        height: double.infinity,
      );
    }
    return Container(
      width: leftWidth,
      height: double.infinity,
      child: ListView.builder(
        itemCount: leftCategoryEntity.result.length,
        itemBuilder: (context, index) {
          return Column(
            children: <Widget>[
              InkWell(
                child: Container(
                  color:
                      leftSelectIndex == index ? Colors.black12 : Colors.white,
                  height: 60,
                  alignment: Alignment.center,
                  child: Text("${leftCategoryEntity.result[index].title}"),
                ),
                onTap: () {
                  setState(() {
                    leftSelectIndex = index;
                    _rightCategoryData(leftCategoryEntity.result[index].sId);
                  });
                },
              ),
              Divider(
                height: 1,
              )
            ],
          );
        },
      ),
    );
  }

  ///右边布局
  _rightContainer(double rightItemWidth, double rightItemHeight) {
    if (rightCategoryEntity == null ||
        rightCategoryEntity.result == null ||
        rightCategoryEntity.result.length == 0) {
      return Expanded(
        flex: 1,
        child: Container(),
      );
    }
    return Expanded(
      flex: 1,
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(10),
        child: GridView.builder(
            itemCount: rightCategoryEntity.result.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: rightItemWidth / rightItemHeight,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(context, routeProductList,arguments: {ArgumentKey.goodsId:"${rightCategoryEntity.result[index].pid}"});
                },
                child: Container(
                  width: (ScreenHelper.screenWidthDp - 100 - 60) / 3,
                  child: Column(
                    children: <Widget>[
                      AspectRatio(
                        aspectRatio: 1 / 1,
                        child: Image.network(
                            ImageUtil.getImageUrl(rightCategoryEntity.result[index].pic)),
                      ),
                      Container(
                        height: ScreenHelper.height(32),
                        child: Text(rightCategoryEntity.result[index].title),
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }

  ///左边数据的请求
  void _leftCategoryData() async {
    var response = await Dio().get(leftCategoryUrl);
    setState(() {
      leftCategoryEntity = LeftCategoryEntity.fromJson(response.data);
      if (leftCategoryEntity != null && leftCategoryEntity.result[0] != null) {
        _rightCategoryData(leftCategoryEntity.result[0].sId);
      }
    });
  }

  ///右边数据的请求
  void _rightCategoryData(id) async {
    var response = await Dio().get("$rightCategoryUrl$id");
    setState(() {
      rightCategoryEntity = RightCategoryEntity.fromJson(response.data);
    });
  }
}
