import 'dart:io';
import 'package:path/path.dart';
import 'package:phogo/models/imagebin.dart';
import 'package:phogo/models/imagecategory.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  // Create a singleton
  DBProvider._();

  static final DBProvider db = DBProvider._();
  Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await initDB();
    this._createCategories();
    return _database;
  }

  initDB() async {
    // Get the location of our app directory. This is where files for our app,
    // and only our app, are stored. Files in this directory are deleted
    // when the app is deleted.
    String documentsDir = await getDatabasesPath();
    await Directory(documentsDir).create(recursive: true);

    String path = join(documentsDir, 'phogo.db');

    return await openDatabase(path, version: 1, onOpen: (db) async {},
        onCreate: (Database db, int version) async {
      // Create the note table
      await db.execute('''
                CREATE TABLE imagebin(
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    categoryId INTEGER, 
                    url TEXT,
                    tags TEXT
                )
            ''');

      await db.execute('''
                CREATE TABLE imageCategory(
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    categoryName TEXT, 
                    tags TEXT
                )
            ''');
    });
  }

  Future<ImageBin> newImage(ImageBin imagebin) async {
    final db = await database;
    var res = await db.insert('imagebin', imagebin.toJson());
    imagebin.id = res;
    return imagebin;
  }

  Future<void> newImages(List<ImageBin> imagebins) async {
    final db = await database;
    var batch = db.batch();
    for (var imagebin in imagebins) {
      batch.insert('imagebin', imagebin.toJson());
    }
    await batch.commit();
  }

  Future<ImageCategory> newCategory(ImageCategory imageCategory) async {
    final db = await database;
    var res = await db.insert('imageCategory', imageCategory.toJson());
    imageCategory.id = res;
    return imageCategory;
  }

  Future<List<ImageBin>> getImages() async {
    final db = await database;
    var res = await db.query('imagebin');
    List<ImageBin> images = res.isNotEmpty
        ? res.map((image) => ImageBin.fromJson(image)).toList()
        : [];

    return images;
  }

  Future<List<ImageBin>> searchImages(String text) async {
    final db = await database;
    var res = await db
        .rawQuery("SELECT * FROM imagebin where tags like '%?%'", [text]);
    List<ImageBin> images = res.isNotEmpty
        ? res.map((image) => ImageBin.fromJson(image)).toList()
        : [];

    return images;
  }

  Future<List<ImageCategory>> getCategories(bool includeImages) async {
    final db = await database;
    var categoriesFromDb = await db.query('imageCategory');

    List<ImageCategory> imageCategories = categoriesFromDb.isNotEmpty
        ? categoriesFromDb
            .map((image) => ImageCategory.fromJson(image))
            .toList()
        : [];

    if (imageCategories.length > 0 && includeImages) {
      var imagesFromDb = await getImages();
      for (var category in imageCategories) {
        category.images = imagesFromDb
            .where((ImageBin img) => img.categoryId == category.id)
            .toList();
      }
    }

    return imageCategories;
  }

  Future<ImageBin> getImage(int id) async {
    final db = await database;
    var res = await db.query('Image', where: 'id = ?', whereArgs: [id]);

    return res.isNotEmpty ? ImageBin.fromJson(res.first) : null;
  }

  Future _createCategories() async {
    await this.newCategory(new ImageCategory(
        categoryName: "Family",
        tags: ["people", "family", "parents", "siblings"]));

    await this.newCategory(new ImageCategory(
        categoryName: "Party", tags: ["dance", "party", "friends", "beer"]));

    await this.newCategory(new ImageCategory(categoryName: "Other", tags: []));
  }
}
