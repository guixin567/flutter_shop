import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jd/main/cart/CartPage.dart';
import 'package:flutter_jd/main/category/CategoryPage.dart';
import 'package:flutter_jd/main/find/FindPage.dart';
import 'package:flutter_jd/main/home/HomePage.dart';
import 'package:flutter_jd/main/me/MePage.dart';

final routes = {
  "/main/home":(context,{arguments}) => HomePage(arguments:arguments),
  "/main/category":(context) =>CategoryPage(),
  "/main/find":(context) => FindPage(),
  "/main/cart":(context) =>CartPage(),
  "/main/me":(context) =>MePage(),
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