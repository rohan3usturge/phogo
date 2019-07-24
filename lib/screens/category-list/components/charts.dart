import 'package:charts_flutter/flutter.dart';
import 'package:flutter/widgets.dart';
import 'package:phogo/models/imagecategory.dart';

@override
class ImageCountChart extends StatelessWidget {
  Future<List<ImageCategory>> categories;

  ImageCountChart({this.categories});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: categories,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return PieChart(_createSampleData(snapshot.data),
                animate: true,
                behaviors: [
                  new DatumLegend(
                    position: BehaviorPosition.end,
                    horizontalFirst: false,
                    cellPadding: new EdgeInsets.only(right: 4.0, bottom: 4.0),
                    showMeasures: true,
                    legendDefaultMeasure: LegendDefaultMeasure.firstValue,
                    measureFormatter: (num value) {
                      return value == null ? '-' : '${value}';
                    },
                  ),
                ],
                defaultRenderer:
                    new ArcRendererConfig(arcWidth: 30));
          } else {
            return Text("Error Occurred ${snapshot.error}");
          }
        },
      ),
      height: 200,
    );
  }

  /// Create one series with sample hard coded data.
  List<Series<ImageCategory, String>> _createSampleData(
      List<ImageCategory> categories) {
    return [
      new Series<ImageCategory, String>(
        id: 'Categories',
        domainFn: (ImageCategory category, i) => category.title,
        displayName: "Categories",
        labelAccessorFn: (ImageCategory category, i) => "${category.title}",
        measureFn: (ImageCategory category, i) => category.images.length,
        data: categories,
      )
    ];
  }
}
