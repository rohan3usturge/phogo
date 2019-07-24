import 'package:charts_flutter/flutter.dart';
import 'package:flutter/widgets.dart';

@override
class ImageCountChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: PieChart(_createSampleData(), animate: true),
      height: 200,
    );
  }

  /// Create one series with sample hard coded data.
  static List<Series<LinearSales, int>> _createSampleData() {
    final data = [
      new LinearSales(0, 100),
      new LinearSales(1, 75),
      new LinearSales(2, 25),
      new LinearSales(3, 5),
    ];

    return [
      new Series<LinearSales, int>(
        id: 'Sales',
        domainFn: (LinearSales sales, i) => sales.year,
        measureFn: (LinearSales sales, i) => sales.sales,
        data: data,
      )
    ];
  }
}

class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}
