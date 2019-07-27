import 'dart:async';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:phogo/models/imagebin.dart';
import 'package:phogo/provider/dbprovider.dart';
import 'package:photo_manager/photo_manager.dart';

// Future<List<ImageCategory>> getImages() async {
//   var categories = new List<ImageCategory>();
//   var familyCategory =
//       new ImageCategory(title: "FAMILY", images: List<ImageBin>());
//   var nsfwCategory = new ImageCategory(title: "NSFW", images: List<ImageBin>());
//   var memeCategory =
//       new ImageCategory(title: "MEMES", images: List<ImageBin>());
//   var selfieCategory =
//       new ImageCategory(title: "SELFIES", images: List<ImageBin>());
//   var partyCategory =
//       new ImageCategory(title: "PARTY", images: List<ImageBin>());
//   var officeCategory =
//       new ImageCategory(title: "OFFICE", images: List<ImageBin>());

//   categories.add(familyCategory);
//   categories.add(nsfwCategory);
//   categories.add(memeCategory);
//   categories.add(selfieCategory);
//   categories.add(partyCategory);
//   categories.add(officeCategory);

//   for (var i = 2; i < 200; i++) {
//     var isFamily = i % 2 == 0;
//     var isNsfw = i % 3 == 0;
//     var isMeme = i % 4 == 0;
//     var isSelfie = i % 5 == 0;
//     var isParty = i % 6 == 0;
//     var isOffice = i % 6 == 0;

//     var tags = <String>[""];

//     if (isFamily) {
//       tags = <String>["family"];
//       familyCategory.images.add(new ImageBin(
//           url: "https://loremflickr.com/400/400/family/all?random=$i",
//           tags: tags));
//     }

//     if (isNsfw) {
//       tags = <String>["nsfw"];
//       nsfwCategory.images.add(new ImageBin(
//           url: "https://loremflickr.com/400/400/blurred/all?random=$i",
//           tags: tags));
//     }

//     if (isMeme) {
//       tags = <String>["meme"];
//       memeCategory.images.add(new ImageBin(
//           url: "https://loremflickr.com/400/400/meme/all?random=$i",
//           tags: tags));
//     }

//     if (isSelfie) {
//       tags = <String>["selfie"];
//       selfieCategory.images.add(new ImageBin(
//           url: "https://loremflickr.com/400/400/selfie/all?random=$i",
//           tags: tags));
//     }

//     if (isParty) {
//       tags = <String>["party"];
//       partyCategory.images.add(new ImageBin(
//           url: "https://loremflickr.com/400/400/party/all?random=$i",
//           tags: tags));
//     }

//     if (isOffice) {
//       tags = <String>["office"];
//       officeCategory.images.add(new ImageBin(
//           url: "https://loremflickr.com/400/400/office/all?random=$i",
//           tags: tags));
//     }
//   }

//   return categories;
// }

Future<List<ImageBin>> search(String text) async {
  var all = List<ImageBin>();
  if (text == null) {
    return all;
  }
  return await DBProvider.db.searchImages(text);
}

Stream<ImageBin> getImageFiles() async* {
  var result = await PhotoManager.requestPermission();
  if (!result) {
    PhotoManager.openSetting();
  } else {
    List<AssetPathEntity> list = await PhotoManager.getImageAsset();
    final ImageLabeler labeler = FirebaseVision.instance.imageLabeler();

    for (var item in list) {
      var assetList = await item.assetList;
      for (var asset in assetList) {
        var file = await asset.file;
        var firebaseVisionImage = FirebaseVisionImage.fromFile(file);
        final List<ImageLabel> labels =
            await labeler.processImage(firebaseVisionImage);
        var tags = labels
            .where((ImageLabel label) {
              return label.confidence > 0.5;
            })
            .map((ImageLabel label) => label.text)
            .toList();
        yield new ImageBin(tags: tags, url: file.path);
      }
    }
  }
}
