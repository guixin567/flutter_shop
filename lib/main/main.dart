import 'package:flutter/material.dart';
import 'package:flutter_jd/common/route/Route.dart';

import 'common/Tabs.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:Tabs(),
      theme:  ThemeData(primarySwatch: Colors.blue),
      onGenerateRoute: onCommonGeneratedRoute,
    );
  }





}

