import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jd/main/cart/CartPage.dart';
import 'package:flutter_jd/main/category/CategoryPage.dart';
import 'package:flutter_jd/main/common/Tabs.dart';
import 'package:flutter_jd/main/find/FindPage.dart';
import 'package:flutter_jd/main/home/HomePage.dart';
import 'package:flutter_jd/main/me/MePage.dart';
import 'package:flutter_jd/product/list/ProductListPage.dart';
import 'package:flutter_jd/search/SearchPage.dart';

import 'RoutePath.dart';

final routes = {
  routeRoot:(context)=>Tabs(),
  routeMainHome:(context,{arguments}) => HomePage(arguments:arguments),
  routeMainCategory:(context) =>CategoryPage(),
  routeMainFind:(context) => FindPage(),
  routeMainCart:(context) =>CartPage(),
  routeMainMe:(context) =>MePage(),
  routeSearch:(context) =>SearchPage(),
  routeProductList:(context,{arguments}) =>ProductListPage(arguments: arguments),
};


RouteFactory onCommonGeneratedRoute =(RouteSettings settings){
  var name = settings.name;
  Function pageBuilder = routes[name];
  if(settings.arguments!=null){
    return MaterialPageRoute(
        builder: (context)=>pageBuilder(context,arguments:settings.arguments)
    );
  }else{
      return MaterialPageRoute(
          builder: (context) => pageBuilder(context)
      );
  }
};