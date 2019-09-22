
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 对ScreenUtil进行包装，方便后期替换
class ScreenHelper{

  //初始化
  static void init(BuildContext context){
    ScreenUtil.instance = ScreenUtil(width: 750,height: 1334)..init(context);
  }
  
  //设置宽度
  static double width(double width){
    return ScreenUtil.getInstance().setWidth(width);
  }

  //设置高度
  static double height(double height){
    return ScreenUtil.getInstance().setHeight(height);
  }

  //屏幕宽度
  static double get screenWidthDp => ScreenUtil.screenWidthDp;
}