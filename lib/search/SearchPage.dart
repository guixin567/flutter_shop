import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jd/common/constant/ArgumentKey.dart';
import 'package:flutter_jd/common/route/RoutePath.dart';
import 'package:flutter_jd/common/util/ScreenHelper.dart';
import 'package:flutter_jd/search/service/SearchService.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var searchWord;
  var historyListData = [];

  @override
  void initState() {
    super.initState();
    _getHistoryData();
  }

  Widget _historyWidget1() {
    if (historyListData.isEmpty) return Text("");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Divider(
          height: ScreenHelper.height(40),
          color: Colors.grey[300],
          thickness: 10,
        ),
        Text(
          "历史搜索",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        Column(
          children: historyListData.map((value) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ListTile(
                  title: Text(value),
                  onLongPress: () {
                    _showAlertDialog(value);
                  },
                ),
                Divider(height: ScreenHelper.height(1))
              ],
            );
          }).toList(),
        ),
        InkWell(
          onTap: () async {
            await SearchService.clearHistorySearchList();
            _getHistoryData();
          },
          child: Container(
            margin: EdgeInsets.only(top: 10),
            width: double.infinity,
            alignment: Alignment.center,
            height: ScreenHelper.height(70),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[200]),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.delete),
                Text("清空历史记录"),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: ScreenHelper.height(76),
          padding: EdgeInsets.only(left: 15),
          decoration: BoxDecoration(
              color: Colors.grey[200], borderRadius: BorderRadius.circular(20)),
          child: TextField(
            autofocus: false,
            onChanged: (value) {
              searchWord = value;
            },
            decoration: InputDecoration(border: InputBorder.none),
          ),
        ),
        actions: <Widget>[
          InkWell(
            child: Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              alignment: Alignment.center,
              child: Text("搜索"),
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, routeProductList,
                  arguments: {ArgumentKey.searchWord: searchWord});
              if (searchWord.isNotEmpty)
                SearchService.setSearchData(searchWord);
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "热搜",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              runSpacing: 10,
              spacing: 10,
              children: <Widget>[
                new TagText(
                  text: "Mack Book",
                ),
                new TagText(
                  text: "联想笔记本",
                ),
                new TagText(
                  text: "小新笔记本",
                ),
                new TagText(
                  text: "Mack Book",
                ),
                new TagText(
                  text: "Mack Book",
                ),
                new TagText(
                  text: "联想笔记本",
                ),
                new TagText(
                  text: "小新笔记本",
                ),
                new TagText(
                  text: "Mack Book",
                ),
              ],
            ),
            _historyWidget1(),
          ],
        ),
      ),
    );
  }

  void _getHistoryData() async {
    var historySearchList = await SearchService.getHistorySearchList();
    setState(() {
      this.historyListData = historySearchList;
    });
  }

  void _showAlertDialog(value) async {
    await showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("提示信息"),
            content: Text("确定删除$value?"),
            actions: <Widget>[
              FlatButton(
                child: Text("删除"),
                onPressed: () async{
                    await SearchService.removeHistoryData(value);
                  _getHistoryData();
                  Navigator.pop(context,"OK");
                },
              ),
              FlatButton(
                child: Text("取消"),
                onPressed: () {
                  Navigator.pop(context,"Cancel");
                },
              ),
            ],
          );
        }
    );
  }
}


class TagText extends StatelessWidget {
  final text;

  const TagText({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 8, right: 8, top: 5, bottom: 5),
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Text(
        text,
        textAlign: TextAlign.center,
      ),
    );
  }
}
