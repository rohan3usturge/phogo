import 'dart:async';
import 'package:phogo/blocs/bloc_provider.dart';
import 'package:phogo/models/imagebin.dart';
import 'package:phogo/models/imagecategory.dart';
import 'package:phogo/provider/dbprovider.dart';

class CategoriesBloc implements BlocBase {
  final _categoriesController =
      StreamController<List<ImageCategory>>.broadcast();

  StreamSink<List<ImageCategory>> get _inCategories =>
      _categoriesController.sink;

  Stream<List<ImageCategory>> get categories => _categoriesController.stream;

  final _addImagesStreamController =
      StreamController<List<ImageBin>>.broadcast();
  StreamSink<List<ImageBin>> get inAddImages => _addImagesStreamController.sink;

  CategoriesBloc() {
    getCategories();
    _addImagesStreamController.stream.listen(_handleAddNote);
  }

  @override
  void dispose() {
    _categoriesController.close();
    _addImagesStreamController.close();
  }

  void getCategories() async {
    List<ImageCategory> categories = await DBProvider.db.getCategories(true);
    _inCategories.add(categories);
  }

  void _handleAddNote(List<ImageBin> imageBins) async {
    await DBProvider.db.newImages(imageBins);
    getCategories();
  }
}
