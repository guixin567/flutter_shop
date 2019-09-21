import 'package:flutter/material.dart';
import 'package:flutter_jd/common/route/RoutePath.dart';

class HomePage extends StatefulWidget {
  final arguments;
  HomePage({this.arguments});
  @override
  _HomePageState createState() => _HomePageState(arguments:arguments);
}

class _HomePageState extends State<HomePage> {
  final arguments;
  _HomePageState({this.arguments});

  @override
  Widget build(BuildContext context) {
    return Container(
       child: Column(
         children: <Widget>[
           RaisedButton(
             child: Text("Route to Search"),
             onPressed: (){
               Navigator.pushNamed(context,routeSearch);
             },
           )

         ],
       ),
    );
  }
}
