import 'package:charts_flutter/flutter.dart';
import 'package:flutter/widgets.dart';
import 'package:phogo/models/imagecategory.dart';

@override
class ImageCountChart extends StatelessWidget {
  final Stream<List<ImageCategory>> categories;
  ImageCountChart({this.categories});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200,
      child: StreamBuilder(
        stream: categories,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return PieChart(_createSampleData(snapshot.data),
                animate: true,
                behaviors: [
                  new DatumLegend(
                    position: BehaviorPosition.start,
                    horizontalFirst: false,
                    cellPadding: new EdgeInsets.all(5),
                    showMeasures: false,
                    legendDefaultMeasure: LegendDefaultMeasure.firstValue,
                    measureFormatter: (num value) {
                      return value == null ? '-' : '$value';
                    },
                  ),
                ],
                defaultRenderer: new ArcRendererConfig(arcWidth: 30));
          } else {
            return Text("Error Occurred ${snapshot.error}");
          }
        },
      ),
    );
  }

  /// Create one series with sample hard coded data.
  List<Series<ImageCategory, String>> _createSampleData(
      List<ImageCategory> categories) {
    return [
      new Series<ImageCategory, String>(
        id: 'Categories',
        domainFn: (ImageCategory category, i) => category.categoryName,
        displayName: "Categories",
        labelAccessorFn: (ImageCategory category, i) =>
            "${category.categoryName}",
        measureFn: (ImageCategory category, i) => category.images.length,
        data: categories,
      )
    ];
  }
}
