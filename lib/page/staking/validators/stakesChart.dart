import 'package:flutter/cupertino.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class StakesChart extends StatelessWidget {
  StakesChart(this.data, this.labels, this.labelFormatter, {this.animate});

  final List<String> labels;
  final List<charts.Series> data;
  final bool animate;

  final charts.BasicNumericTickFormatterSpec labelFormatter;

  factory StakesChart.withData(List<List<num>> ls, List<String> labels) {
    var formatter = charts.BasicNumericTickFormatterSpec((num value) {
      return labels[value.toInt()] ?? '';
    });
    return new StakesChart(
      _formatData(ls),
      labels,
      formatter,
      // Disable animations for image tests.
      animate: false,
    );
  }

  static List<charts.Series<num, num>> _formatData(List<List<num>> ls) {
    return [
      new charts.Series<num, num>(
        id: 'Elected stake',
        colorFn: (_, __) => charts.MaterialPalette.yellow.shadeDefault,
        domainFn: (_, int index) => index,
        measureFn: (num item, _) => item,
        data: ls[0],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return new charts.LineChart(
      data,
      defaultRenderer:
          new charts.LineRendererConfig(includeArea: true, stacked: true),
      animate: animate,
      domainAxis: charts.NumericAxisSpec(
        tickProviderSpec: charts.BasicNumericTickProviderSpec(
            desiredTickCount: labels.length),
        tickFormatterSpec: labelFormatter,
      ),
    );
  }
}
