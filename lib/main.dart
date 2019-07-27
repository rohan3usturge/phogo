import 'package:flutter/material.dart';
import 'package:phogo/screens/category-list/categorylistscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CategoryListScreen(),
      theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.blueAccent,
          platform: TargetPlatform.iOS),
    );
  }
}
