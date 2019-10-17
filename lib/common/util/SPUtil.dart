import 'package:shared_preferences/shared_preferences.dart';

class SPUtils{

  /// 保存字符串
  static Future<void> setString(key,value) async{
    var sp = await SharedPreferences.getInstance();
    sp.setString(key, value);
  }

  ///获取字符串
  static Future<String> getString(key) async{
    var sp = await SharedPreferences.getInstance();
    return sp.get(key);
  }

  ///删除字符串
  static Future<void> remove(key) async{
    var sp = await SharedPreferences.getInstance();
    sp.remove(key);
  }
}