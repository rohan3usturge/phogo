import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:meta/meta.dart';

class ImageBin {
  final String url;
  final List<String> tags;
  final List<ImageLabel> labels;

  ImageBin({@required this.url, @required this.tags, this.labels});
}
