import 'package:flutter/material.dart';
import 'package:phogo/models/imagecategory.dart';
import 'package:phogo/screens/category/components/body.dart';


class CategoryScreen extends StatelessWidget {

  ImageCategory imageCategory;

  CategoryScreen({this.imageCategory});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(imageCategory.title),
      ),
      body: Body(imageCategory: imageCategory),
    );
  }
}
