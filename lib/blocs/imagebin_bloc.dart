import 'dart:async';
import 'package:phogo/blocs/bloc_provider.dart';
import 'package:phogo/models/imagebin.dart';
import 'package:phogo/provider/dbprovider.dart';

class ImageBinBloc implements BlocBase {
  final _imageBinsController = StreamController<List<ImageBin>>.broadcast();

  StreamSink<List<ImageBin>> get _inImages => _imageBinsController.sink;

  Stream<List<ImageBin>> get imageBins => _imageBinsController.stream;

  final _addCategoryController = StreamController<ImageBin>.broadcast();
  StreamSink<ImageBin> get inAddImageBin => _addCategoryController.sink;

  ImageBinBloc() {
    getImageBins();
    _addCategoryController.stream.listen(_handleAddNote);
  }

  @override
  void dispose() {
    _imageBinsController.close();
    _addCategoryController.close();
  }

  void getImageBins() async {
    List<ImageBin> imageBins = await DBProvider.db.getImages();
    _inImages.add(imageBins);
  }

  void _handleAddNote(ImageBin imageBin) async {
    await DBProvider.db.newImage(imageBin);
    getImageBins();
  }
}
