import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:meta/meta.dart';

class ImageBin {
  final String id;
  final String url;
  final List<String> tags;
  final List<ImageLabel> labels;

  ImageBin({@required this.url, @required this.tags, this.labels, this.id});

  // Create a Note from JSON data
  factory ImageBin.fromJson(Map<String, dynamic> json) => new ImageBin(
      id: json["id"],
      url: json["url"],
      labels: json["labels"],
      tags: json["tags"]);

  // Convert our Note to JSON to make it easier when we store it in the database
  Map<String, dynamic> toJson() =>
      {"id": id, "labels": labels, "url": url, "tags": tags};
}
