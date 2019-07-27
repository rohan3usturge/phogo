import 'imagebin.dart';

class ImageCategory {
  int id;
  final String categoryName;
  List<ImageBin> images;
  final List<String> tags;
  ImageCategory({this.id, this.categoryName, this.tags, this.images});

  // Create a Note from JSON data
  factory ImageCategory.fromJson(Map<String, dynamic> json) {
    var id = json["id"];
    var categoryName = json["categoryName"];
    var tags = json["tags"].toString().split(",");
    var imageCategory = new ImageCategory(
      id: id,
      categoryName: categoryName,
      tags: tags,
    );
    return imageCategory;
  }

  // Convert our Note to JSON to make it easier when we store it in the database
  Map<String, dynamic> toJson() => {
        "id": this.id,
        "categoryName": this.categoryName,
        "tags": tags.join(",")
      };
}
