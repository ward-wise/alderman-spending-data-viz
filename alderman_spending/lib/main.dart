import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:csv/csv.dart';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:syncfusion_flutter_charts/charts.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alderman Spending',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            if (constraints.maxWidth / constraints.maxHeight > 1.3) {
              return Row(
                children: [
                  Expanded(child: DetailRegion()),
                  Expanded(child: PieChartRegion()),
                ],
              );
            } else {
              return Column(
                children: [
                  Expanded(child: PieChartRegion()),
                  Expanded(child: DetailRegion()),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

class DetailRegion extends StatefulWidget {
  const DetailRegion({super.key});

  @override
  State<DetailRegion> createState() => _DetailRegionState();
}

class _DetailRegionState extends State<DetailRegion> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class PieChartRegion extends StatefulWidget {
  @override
  _PieChartRegionState createState() => _PieChartRegionState();
}

class _PieChartRegionState extends State<PieChartRegion> {
  List<AnnualWardSpendingData>? _spendingData;
  int _selectedWard = 1;
  int _selectedYear = 2019;
  late String _selectedCategory;
  @override
  void initState() {
    loadSpendingData().then((data) {
      setState(() {
        _spendingData = data;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_spendingData == null) {
      return CircularProgressIndicator(); // show loading spinner
    } else {
      return Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
        child: Column(
          children: [
            wardYearSelector(),
            Expanded(child: wardYearCategorySpending()),
          ],
        ),
      );
    }
  }

  Widget wardYearSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        DropdownButton<int>(
          // set menumaxheight to quarter of the screen height
          menuMaxHeight: MediaQuery.of(context).size.height / 4,
          value: _selectedWard,
          onChanged: (int? newValue) {
            setState(() {
              _selectedWard = newValue!;
            });
          },
          items: List<int>.generate(50, (i) => i + 1)
              .map<DropdownMenuItem<int>>((int value) {
            return DropdownMenuItem<int>(
              value: value,
              child: Text('Ward $value'),
            );
          }).toList(),
        ),
        DropdownButton<int>(
          value: _selectedYear,
          onChanged: (int? newValue) {
            setState(() {
              _selectedYear = newValue!;
            });
          },
          items: <int>[2019, 2020, 2021, 2022]
              .map<DropdownMenuItem<int>>((int value) {
            return DropdownMenuItem<int>(
              value: value,
              child: Text('$value'),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget wardYearCategorySpending() {
    return SfCartesianChart(
      onAxisLabelTapped: (axisLabelTapArgs) {
        setState(() {
          _selectedCategory = axisLabelTapArgs.text;
        });
        print(_selectedCategory);
      },
      title: ChartTitle(text: 'Spending per Category'),
      primaryXAxis: CategoryAxis(title: AxisTitle(text: 'Categories')),
      primaryYAxis: NumericAxis(title: AxisTitle(text: 'Spending')),
      series: <BarSeries<AnnualWardSpendingData, String>>[
        BarSeries<AnnualWardSpendingData, String>(
            dataSource: _spendingData!
                .where((element) =>
                    element.ward == _selectedWard &&
                    element.year == _selectedYear)
                .toList(),
            onPointTap: (ChartPointDetails args) {
              setState(() {
                _selectedCategory = _spendingData![args.pointIndex!].category;
              });
              print(_selectedCategory);
            },
            xValueMapper: (AnnualWardSpendingData data, _) => data.category,
            yValueMapper: (AnnualWardSpendingData data, _) => data.cost,
            dataLabelMapper: (datum, index) =>
                "${datum.category}\n\$${NumberFormat("#,##0").format(datum.cost)}"),
      ],
    );
  }
}

class AnnualWardSpendingData {
  final int ward;
  final int year;
  final String category;
  final double cost;

  AnnualWardSpendingData({
    required this.ward,
    required this.year,
    required this.category,
    required this.cost,
  });
}

Future<List<AnnualWardSpendingData>> loadSpendingData() async {
  final rawdata =
      await rootBundle.loadString('/2019-2022_ward_category_totals.csv');

  // Split raw data by new lines and commas
  var lines = rawdata.split('\n');
  var csvTable = lines.map((line) => line.split(',')).toList();
  var spendingData = <AnnualWardSpendingData>[];

  for (var i = 1; i < csvTable.length; i++) {
    var item = csvTable[i];

    // Make sure to trim whitespace around the values after splitting by comma
    var newData = AnnualWardSpendingData(
      ward: int.parse(item[0].trim()),
      year: int.parse(item[1].trim()),
      category: item[2].trim(),
      cost: double.parse(item[3].trim()),
    );
    spendingData.add(newData);
  }

  return spendingData;
}
