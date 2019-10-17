import 'dart:convert';

import 'package:flutter_jd/common/constant/SPKey.dart';
import 'package:flutter_jd/common/util/SPUtil.dart';

class SearchService {
  ///遇到的问题
  ///getString 指定await，方法加async
  ///保存搜索词
  static setSearchData(value) async {
    var historySearchListData;
   getHistorySearchList().then((element){
     historySearchListData = element;
   });
    if (historySearchListData.contains(value)) historySearchListData.remove(value);
    historySearchListData.add(value);
    print(historySearchListData);
    await SPUtils.setString(
        SPKey.historySearchList, jsonEncode(historySearchListData));
  }

  ///获取所有的历史搜索
  static Future<List> getHistorySearchList() async{
    var historySearchList = jsonDecode( await SPUtils.getString(SPKey.historySearchList) ?? "{}");
   return historySearchList is List ? historySearchList.toList() : List();
  }
}
