import 'package:flutter/material.dart';
import 'package:phogo/screens/category-list/categorylistscreen.dart';

void main() => runApp(MyApp());

class ImageBin {
  ImageBin(String url, List<String> tags) {
    this.url = url;
    this.tags = tags;
  }

  String url;
  List<String> tags;
}

class ImageCategory {
  String title;
  List<ImageBin> images;

  ImageCategory(String title, List<ImageBin> images) {
    this.images = images;
    this.title = title;
  }
}

class ImageCategories extends State<ImageGrid> {
  final _imageList = new List<ImageBin>();
  final _categories = new List<ImageCategory>();

  ImageCategories() {
    var familyCategory = new ImageCategory("FAMILY", List<ImageBin>());
    var nsfwCategory = new ImageCategory("NSFW", List<ImageBin>());
    var memeCategory = new ImageCategory("MEMES", List<ImageBin>());
    var selfieCategory = new ImageCategory("SELFIES", List<ImageBin>());
    var partyCategory = new ImageCategory("PARTY", List<ImageBin>());
    var officeCategory = new ImageCategory("OFFICE", List<ImageBin>());

    this._categories.add(familyCategory);
    this._categories.add(nsfwCategory);
    this._categories.add(memeCategory);
    this._categories.add(selfieCategory);
    this._categories.add(partyCategory);
    this._categories.add(officeCategory);

    for (var i = 2; i < 200; i++) {
      var isFamily = i % 2 == 0;
      var isNsfw = i % 3 == 0;
      var isMeme = i % 4 == 0;
      var isSelfie = i % 5 == 0;
      var isParty = i % 6 == 0;
      var isOffice = i % 6 == 0;

      var tags = <String>[""];

      if (isFamily) {
        tags = <String>["family"];
        familyCategory.images
            .add(new ImageBin("https://picsum.photos/40/40?random=${i}", tags));
      }

      if (isNsfw) {
        tags = <String>["nsfw"];
        nsfwCategory.images
            .add(new ImageBin("https://picsum.photos/40/40?random=${i}", tags));
      }

      if (isMeme) {
        tags = <String>["meme"];
        memeCategory.images
            .add(new ImageBin("https://picsum.photos/40/40?random=${i}", tags));
      }

      if (isSelfie) {
        tags = <String>["selfie"];
        selfieCategory.images
            .add(new ImageBin("https://picsum.photos/40/40?random=${i}", tags));
      }

      if (isParty) {
        tags = <String>["party"];
        partyCategory.images
            .add(new ImageBin("https://picsum.photos/40/40?random=${i}", tags));
      }

      if (isOffice) {
        tags = <String>["office"];
        officeCategory.images
            .add(new ImageBin("https://picsum.photos/40/40?random=${i}", tags));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PHOGO'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(5),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: 'Search Images',
              ),
            ),
            Divider(),
            Expanded(
                child: GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    childAspectRatio: 1.0,
                    padding: const EdgeInsets.all(0),
                    mainAxisSpacing: 1.0,
                    crossAxisSpacing: 1.0,
                    children:
                        this._categories.map((ImageCategory imageCategory) {
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
                                return Scaffold(
                                  appBar: AppBar(
                                    title: Text(imageCategory.title),
                                  ),
                                  body: GridView.count(
                                    crossAxisCount: 4,
                                    childAspectRatio: 1.0,
                                    padding: const EdgeInsets.all(4.0),
                                    mainAxisSpacing: 4.0,
                                    crossAxisSpacing: 4.0,
                                    children: imageCategory.images
                                        .map((ImageBin image) {
                                      return Image.network(image.url, fit: BoxFit.cover,);
                                    }).toList(),
                                  ),
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
                                    children: imageCategory.images
                                        .take(4)
                                        .map((ImageBin image) {
                                      return new Image.network(
                                        image.url,
                                        fit: BoxFit.fitWidth,
                                      );
                                    }).toList(),
                                  ),
                                ),
                                Text(
                                  imageCategory.title,
                                  style: TextStyle(color: Colors.grey),
                                  textAlign: TextAlign.left,
                                )
                              ],
                            )),
                        // child: Container(
                        //   decoration: BoxDecoration(
                        //     image: DecorationImage(
                        //       image:
                        //           NetworkImage(imageCategory.images.first.url),
                        //       fit: BoxFit.fitWidth,
                        //       alignment: Alignment.topCenter,
                        //     ),
                        //   ),
                        //   child: Text(imageCategory.title),
                        // ),
                      );
                    }).toList()))
          ],
        ),
      ),
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        // Add 20 lines from here...
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Manage'),
            ),
            body: ListView(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () {},
                ),
                FlatButton(
                  onPressed: () {},
                  child: Text("Scan Photos"),
                ),
                IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () {},
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ImageGrid extends StatefulWidget {
  @override
  ImageCategories createState() {
    return ImageCategories();
  }
}

class MyApp extends StatelessWidget {
  MyApp() {}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CategoryListScreen(),
      theme:
          ThemeData(primaryColor: Colors.blue, accentColor: Colors.blueAccent),
    );
  }
}
