import 'package:flutter/material.dart';
import 'package:phogo/models/imagebin.dart';
import 'package:phogo/screens/image-search/components/body.dart';
import 'package:phogo/services/imageapi.dart';

class ImageSearchScreen extends StatefulWidget {
  @override
  ImageSearch createState() {
    return ImageSearch();
  }
}

class ImageSearch extends State<ImageSearchScreen> {
  Future<List<ImageBin>> filtered;

  @override
  void initState() {
    super.initState();
    filtered = search(null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: _search,
        ),
      ),
      body: Body(
        filtered: filtered,
      ),
    );
  }

  _search(text) {
    setState(() {
     this.filtered = search(text);
    });
  }
}
