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
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("热搜",style: TextStyle(
              fontWeight: FontWeight.w600
            ),),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              runSpacing: 10,
              spacing: 10,
              children: <Widget>[
                new TagText(text: "Mack Book",),
                new TagText(text: "联想笔记本",),
                new TagText(text: "小新笔记本",),
                new TagText(text: "Mack Book",),
                new TagText(text: "Mack Book",),
                new TagText(text: "联想笔记本",),
                new TagText(text: "小新笔记本",),
                new TagText(text: "Mack Book",),
              ],
            ),
            Divider(height: ScreenHelper.height(40),color: Colors.grey[300],thickness: 10,),
            Text("历史搜索",style: TextStyle(
              fontWeight: FontWeight.w600
            ),),
            Divider(height: ScreenHelper.height(1),),
            Container(
              alignment: Alignment.centerLeft,
              height: ScreenHelper.height(60),
                child: Text("女装",textAlign: TextAlign.center,)),
            Divider(height: ScreenHelper.height(1),),
            Container(
                alignment: Alignment.centerLeft,
                height: ScreenHelper.height(60),
                child: Text("男装")),
            Divider(height: ScreenHelper.height(1),),
            Container(
                alignment: Alignment.centerLeft,
                height: ScreenHelper.height(60),
                child: Text("笔记本")),
            Divider(height: ScreenHelper.height(1),),
            Container(
                alignment: Alignment.centerLeft,
                height: ScreenHelper.height(60),
                child: Text("cup")),
            InkWell(
              onTap: (){},
              child: Container(
                margin: EdgeInsets.only(top: 10),
                width: double.infinity,
                alignment: Alignment.center,
                height: ScreenHelper.height(70),
                decoration: BoxDecoration(
                  border:Border.all(color: Colors.grey[200]),

                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.delete),
                    Text("清空历史记录"),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TagText extends StatelessWidget {
  final text;
  const TagText({
    Key key,this.text
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 8,right: 8,top: 5,bottom: 5),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child:Text(text,textAlign: TextAlign.center,),
    );
  }
}
