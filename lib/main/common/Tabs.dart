import 'package:flutter/material.dart';
import 'package:flutter_jd/common/route/RoutePath.dart';
import 'package:flutter_jd/common/util/ScreenHelper.dart';
import 'package:flutter_jd/main/cart/CartPage.dart';
import 'package:flutter_jd/main/category/CategoryPage.dart';
import 'package:flutter_jd/main/find/FindPage.dart';
import 'package:flutter_jd/main/home/HomePage.dart';
import 'package:flutter_jd/main/me/MePage.dart';

class Tabs extends StatefulWidget {
  final int selectIndex;

  Tabs({this.selectIndex = 0});

  @override
  _TabsState createState() => _TabsState(selectIndex: selectIndex);
}

class _TabsState extends State<Tabs> {
  int selectIndex = 0;
  PageController _pageController;
  List<Widget> mainPages = [
    HomePage(),
    CategoryPage(),
    FindPage(),
    CartPage(),
    MePage()
  ];

  _TabsState({this.selectIndex});

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: selectIndex);
  }

  @override
  Widget build(BuildContext context) {
    ScreenHelper.init(context);
    return Scaffold(
      appBar: generateTabAppBar(context,selectIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.red,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("首页"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            title: Text("分类"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.find_in_page),
            title: Text("发现"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shop),
            title: Text("购物车"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text("我的"),
          ),
        ],
        currentIndex: selectIndex,
        onTap: (index) {
            setState(() {
              selectIndex = index;
             _pageController.jumpToPage(index);
          });
        },
      ),
      body: PageView(
          controller: _pageController,
          children: mainPages,
          onPageChanged: (index) {
            setState(() {
              selectIndex = index;
            });
          },
        physics: NeverScrollableScrollPhysics(),
          ),
    );
  }

  AppBar generateTabAppBar(BuildContext context, int selectIndex) {
    if(4 != selectIndex){
      return AppBar(
        title: InkWell(
          onTap: (){
            Navigator.pushNamed(context,routeSearch);
          },
          child: Container(
            padding: EdgeInsets.only(left: 10,right: 10),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            height: ScreenHelper.height(76),
            child: Row(
              children: <Widget>[
                Icon(Icons.search),
                Text("Search")
              ],
            ),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.settings_overscan),
          iconSize: 28,
          color: Colors.black12,
          onPressed: (){

          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.message),
            iconSize: 28,
            color: Colors.black12,
            onPressed: (){

            },
          )
        ],
      );
    }else{
      return AppBar(
        title: Text("用户中心",style: TextStyle(
          fontSize: ScreenHelper.size(34)
        ),),
      );
    }

  }
}
