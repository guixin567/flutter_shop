import 'package:flutter/material.dart';
import 'package:flutter_jd/main/cart/CartPage.dart';
import 'package:flutter_jd/main/category/CategoryPage.dart';
import 'package:flutter_jd/main/find/FindPage.dart';
import 'package:flutter_jd/main/home/HomePage.dart';
import 'package:flutter_jd/main/me/MePage.dart';


class Tabs extends StatefulWidget {
  final int selectIndex;

  Tabs({this.selectIndex = 0});

  @override
  _TabsState createState() => _TabsState(selectIndex:selectIndex);
}

class _TabsState extends State<Tabs> {
  int selectIndex = 0;
  List mainPages = [HomePage(),CategoryPage(),FindPage(),CartPage(),MePage()];
  _TabsState({this.selectIndex});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("JD"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
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
        onTap: (index){
          setState(() {
            selectIndex = index;
          });
        },
      ),
      body: mainPages[selectIndex],
    );
  }
}
