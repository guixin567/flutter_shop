import 'dart:convert';

import 'package:flutter_jd/common/constant/SPKey.dart';
import 'package:flutter_jd/common/util/Log.dart';
import 'package:flutter_jd/common/util/SPUtil.dart';

class SearchService {
  ///遇到的问题
  ///getString 指定await，方法加async
  ///保存搜索词
  static setSearchData(value) async {
   await getHistorySearchList().then((element){
     var historySearchListData = element;
     if (historySearchListData.contains(value)) historySearchListData.remove(value);
     historySearchListData.add(value);
     Log.d(historySearchListData);
     SPUtils.setString(
         SPKey.historySearchList, jsonEncode(historySearchListData));
   });

  }

  ///获取所有的历史搜索
  static Future<List> getHistorySearchList() async{
    var historySearchList = jsonDecode(await SPUtils.getString(SPKey.historySearchList) ?? "{}");
   return historySearchList is List ? historySearchList.toList() : List();
  }

  static clearHistorySearchList() async{
    var historySearchList = jsonDecode(await SPUtils.getString(SPKey.historySearchList)??"{}");
    if(historySearchList is List){
      historySearchList.clear();
    }
    await SPUtils.setString(SPKey.historySearchList, jsonEncode(historySearchList));
  }

  static void removeHistoryData(value) async{
    var historySearchList = jsonDecode(await SPUtils.getString(SPKey.historySearchList)??"{}");
    if(historySearchList is List && historySearchList.contains(value)){
      historySearchList.remove(value);
    }
    await SPUtils.setString(SPKey.historySearchList, jsonEncode(historySearchList));
  }
}
