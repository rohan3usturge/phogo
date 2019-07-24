import 'package:flutter/material.dart';
import 'package:phogo/models/imagebin.dart';
import 'package:phogo/models/imagecategory.dart';
import 'package:phogo/screens/category/categoryscreen.dart';

class Body extends StatelessWidget {
  final Future<List<ImageCategory>> imageCategories;

  const Body({Key key, this.imageCategories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List<ImageCategory>>(
        future: imageCategories,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var categories = snapshot.data;
            return GridView.count(
              shrinkWrap : true,
              crossAxisCount: 2,
              childAspectRatio: 1.0,
              padding: const EdgeInsets.all(4.0),
              mainAxisSpacing: 1.0,
              crossAxisSpacing: 1.0,
              children: categories.map((ImageCategory category) {
                return new Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(1.0),
                    ),
                    elevation: 2,
                    margin: EdgeInsets.all(2),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return CategoryScreen(
                            imageCategory: category,
                          );
                        }));
                      },
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: GridView.count(
                              physics: new NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              primary: true,
                              crossAxisCount: 2,
                              childAspectRatio: 1.0,
                              padding: const EdgeInsets.all(4.0),
                              mainAxisSpacing: 1.0,
                              crossAxisSpacing: 1.0,
                              children:
                                  category.images.take(4).map((ImageBin image) {
                                return new Image.network(
                                  image.url,
                                  fit: BoxFit.fitWidth,
                                );
                              }).toList(),
                            ),
                          ),
                          Divider(),
                          Row(
                            children: <Widget>[
                              Text(
                                category.title,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: "Roboto",
                                ),
                                textAlign: TextAlign.center,
                              )
                            ],
                          )
                        ],
                      ),
                    ));
              }).toList(),
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          // By default, show a loading spinner.
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
