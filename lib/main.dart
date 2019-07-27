import 'package:flutter/material.dart';
import 'package:phogo/blocs/bloc_provider.dart';
import 'package:phogo/blocs/category_bloc.dart';
import 'package:phogo/provider/dbprovider.dart';
import 'package:phogo/screens/category-list/categorylistscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        child: CategoryListScreen(),
        bloc: CategoriesBloc(),
      ),
      theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.blueAccent,
          platform: TargetPlatform.iOS),
    );
  }

  @protected
  @mustCallSuper
  void dispose() {
    DBProvider.db.destroyDb();
  }
}
