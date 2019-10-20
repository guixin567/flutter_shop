import 'package:flutter/material.dart';

class TagText extends StatelessWidget {
  final txt;
  const TagText(this.txt,{
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(txt),
      decoration: BoxDecoration(
          border:
              Border.all(color: Colors.grey),
          borderRadius: BorderRadius.all(
              Radius.circular(4))),
      padding: EdgeInsets.only(
          left: 5,
          right: 5,
          top: 0,
          bottom: 0),
      margin: EdgeInsets.only(right: 5),
    );
  }
}