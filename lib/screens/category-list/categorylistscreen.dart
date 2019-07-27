import 'dart:io';
import 'package:flutter/material.dart';
import 'package:phogo/blocs/bloc_provider.dart';
import 'package:phogo/blocs/category_bloc.dart';
import 'package:phogo/models/imagebin.dart';
import 'package:phogo/screens/category-list/components/body.dart';
import 'package:phogo/screens/category-list/components/charts.dart';
import 'package:phogo/screens/image-search/imagesarch.dart';
import 'package:phogo/services/imageapi.dart';
import 'package:phogo/services/imagecategoryservice.dart';

class CategoryListScreen extends StatefulWidget {
  @override
  CategoryList createState() {
    return CategoryList();
  }
}

class CategoryList extends State<CategoryListScreen>
    with TickerProviderStateMixin {
  CategoriesBloc _categoriesBloc;
  bool _isScanInProgress = false;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _categoriesBloc = BlocProvider.of<CategoriesBloc>(context);
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('KANTABEN'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: _openSearch),
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Distribution", style: Theme.of(context).textTheme.caption),
            Divider(),
            SizedBox(
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  ImageCountChart(
                    categories: _categoriesBloc.categories,
                  ),
                  ImageCountChart(
                    categories: _categoriesBloc.categories,
                  ),
                ],
              ),
              height: 200,
            ),
            Text("Categories", style: Theme.of(context).textTheme.caption),
            Divider(),
            Body(imageCategories: _categoriesBloc.categories)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: RotationTransition(
          child: Icon(
            Icons.refresh,
          ),
          turns: Tween(begin: 0.0, end: 1.0).animate(this._animationController),
        ),
        onPressed: () {
          processImageCategories().listen((List<ImageBin> images) {
            _categoriesBloc.inAddImages.add(images);
          });
        },
      ),
    );
  }

  void _openSearch() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return ImageSearchScreen();
        },
      ),
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Manage'),
            ),
            body: StreamBuilder<ImageBin>(
              stream: getImageFiles(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }

                if (snapshot.connectionState == ConnectionState.done) {
                  return Text("Done");
                }

                if (snapshot.hasError) {
                  return Text("Error Occurred ${snapshot.error}");
                }

                if (snapshot.hasData) {
                  var data = snapshot.data;
                  return Image.file(File("${data.url}"));
                }
                return Text("UnExpected");
              },
            ),
          );
        },
      ),
    );
  }
}
