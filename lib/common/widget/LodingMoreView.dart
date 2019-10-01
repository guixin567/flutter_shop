import 'package:flutter/material.dart';

class LoadingMoreView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      alignment: Alignment.center,
      child: CircularProgressIndicator(
        strokeWidth: 2.0,
      ),
    );
  }
}
