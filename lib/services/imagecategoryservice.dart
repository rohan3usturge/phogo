import 'package:phogo/models/imagebin.dart';
import 'package:phogo/models/imagecategory.dart';
import 'package:phogo/provider/dbprovider.dart';
import 'package:phogo/services/imageapi.dart';

Stream<List<ImageBin>> processImageCategories() async* {
  var categories = await DBProvider.db.getCategories(false);
  var nonOther = categories
      .where((ImageCategory category) => category.categoryName != "Other");
  var other = categories
      .firstWhere((ImageCategory category) => category.categoryName == "Other");

  var imageFiles = getImageFiles();
  var list = <ImageBin>[];
  var batchSize = 10;

  await for (var image in imageFiles) {
    var matchedCategory = other;
    if (list.length == batchSize) {
      list = <ImageBin>[];
    }
    for (var category in nonOther) {
      if (category.tags.any((tag) => image.tags.contains(tag))) {
        matchedCategory = category;
        break;
      }
    }
    image.categoryId = matchedCategory.id;
    list.add(image);
    if (list.length == batchSize) {
      yield list;
    }
  }
  if (list.length > 0) {
    yield list;
  }
}
