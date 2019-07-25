import 'dart:io';

import 'package:flutter/material.dart';
import 'package:phogo/models/imagecategory.dart';
import 'package:phogo/screens/category-list/components/body.dart';
import 'package:phogo/screens/category-list/components/charts.dart';
import 'package:phogo/screens/image-search/imagesarch.dart';
import 'package:phogo/services/imageapi.dart';

class CategoryListScreen extends StatefulWidget {
  @override
  CategoryList createState() {
    return CategoryList();
  }
}

class CategoryList extends State<CategoryListScreen> {
  Future<List<ImageCategory>> imageCategories;

  @override
  void initState() {
    super.initState();
    imageCategories = getImages();
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
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.all(0),
        children: <Widget>[
          ImageCountChart(categories: imageCategories,),
          Body(imageCategories: imageCategories)
        ],
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
            body: FutureBuilder<List<String>>(
              future: getImageFiles(),
              builder: (context, snapshot){
                if ( snapshot.hasData ) {
                  var data = snapshot.data;
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, i){
                      return ListTile(title: Image.file(File(data[i])),);
                    }, 
                  );
                } else {
                  return Text("Error Occurred");
                }
              },
            ),
          );
        },
      ),
    );
  }
}
