import 'package:flutter/material.dart';
import 'package:phogo/models/imagebin.dart';
import 'package:phogo/models/imagecategory.dart';

class Body extends StatelessWidget {
  final ImageCategory imageCategory;

  Body({this.imageCategory});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GridView.count(
        crossAxisCount: 4,
        childAspectRatio: 1.0,
        padding: const EdgeInsets.all(4.0),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        children: imageCategory.images.map((ImageBin image) {
          return Image.network(
            image.url,
            fit: BoxFit.cover,
          );
        }).toList(),
      ),
    );
  }
}
