import 'package:meta/meta.dart';
import 'imagebin.dart';

class ImageCategory {
  final String title;
  final List<ImageBin> images;

  ImageCategory({@required this.title, @required this.images}) {}
}
