import 'package:flutter/material.dart';
import 'package:phogo/models/imagebin.dart';

class Body extends StatelessWidget {
  final Future<List<ImageBin>> filtered;

  Body({this.filtered});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ImageBin>>(
        future: filtered,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: GridView.count(
                crossAxisCount: 4,
                childAspectRatio: 1.0,
                padding: const EdgeInsets.all(4.0),
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0,
                children: snapshot.data.map((ImageBin image) {
                  return Image.network(
                    image.url,
                    fit: BoxFit.cover,
                  );
                }).toList(),
              ),
            );
          } else {
            return Text("Error Occurred");
          }
        });
  }
}
