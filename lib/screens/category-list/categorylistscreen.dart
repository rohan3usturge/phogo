import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:phogo/models/imagebin.dart';
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

  List<ImageBin> imageBins = new List<ImageBin>();

  @override
  void initState() {
    super.initState();
    imageCategories = getImages();

    getImageFiles().listen((imageBin) {
      // this.setState(() {
        this.imageBins.add(imageBin);
      // });
    });
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
                    categories: imageCategories,
                  ),
                  ImageCountChart(
                    categories: imageCategories,
                  ),
                ],
              ),
              height: 200,
            ),
            Text("Categories", style: Theme.of(context).textTheme.caption),
            Divider(),
            Body(imageCategories: imageCategories)
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 10,
        backgroundColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.grain),
            title: Text('Scan'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.healing),
            title: Text('Heal'),
          ),
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
            body: ListView.builder(
              itemBuilder: (context, i){
                return Text("Hi");
              },
              itemCount: this.imageBins.length,
              // children: <Widget>[
              //   StreamBuilder<ImageBin>(
              //     stream: getImageFiles(),
              //     builder: (context, snapshot) {
              //       if (snapshot.connectionState == ConnectionState.waiting) {
              //         return CircularProgressIndicator();
              //       }

              //       if (snapshot.connectionState == ConnectionState.done) {
              //         return Text("Done");
              //       }

              //       if (snapshot.hasError) {
              //         return Text("Error Occurred ${snapshot.error}");
              //       }

              //       if (snapshot.hasData) {
              //         var data = snapshot.data;
              //         return Text("${data.url}");
              //       }
              //       return Text("UnExpected");
              //     },
              //   )
              // ],
            ),
          );
        },
      ),
    );
  }
}
