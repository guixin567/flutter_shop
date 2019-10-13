import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jd/common/util/ScreenHelper.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: ScreenHelper.height(76),
          padding: EdgeInsets.only(left: 15),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(20)
          ),
          child: TextField(
            autofocus: false,

            decoration: InputDecoration(
                border: InputBorder.none
            ),
          ),
        ),
        actions: <Widget>[
          InkWell(
            child: Container(
              padding: EdgeInsets.only(left:20,right: 20),
              alignment: Alignment.center,
              child: Text("搜索"),
            ),
            onTap: (){},

          )
        ],
      ),
      body: Column(
        children: <Widget>[
        ],
      ),
    );
  }
}
