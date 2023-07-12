import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => SelectedData(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alderman Spending',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
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
              return const Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: BarChartRegion(),
                  ),
                  VerticalDivider(
                    color: Colors.grey,
                    width: 1,
                    thickness: 1,
                  ),
                  Expanded(
                    flex: 1,
                    child: DetailRegion(),
                  ),
                ],
              );
            } else {
              return const Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: BarChartRegion(),
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 1,
                    thickness: 1,
                  ),
                  Expanded(
                    flex: 1,
                    child: DetailRegion(),
                  ),
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
  List<WardItemLocationSpendingData>? _wardItemLocationSpendingData;
  int? _selectedWard;
  int? _selectedYear;
  List<WardItemLocationSpendingData>? _filteredData;

  @override
  void initState() {
    loadCategoryItemsData().then((data) {
      setState(() {
        _wardItemLocationSpendingData = data;
        _filteredData = _filterData();
      });
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final selectedData = Provider.of<SelectedData>(context);
    if (_selectedWard != selectedData.selectedWard ||
        _selectedYear != selectedData.selectedYear) {
      _selectedWard = selectedData.selectedWard;
      _selectedYear = selectedData.selectedYear;
      _filteredData = _filterData();
    }
    super.didChangeDependencies();
  }

  List<WardItemLocationSpendingData>? _filterData() {
    if (_wardItemLocationSpendingData == null ||
        _selectedWard == null ||
        _selectedYear == null) {
      return null;
    }
    return _wardItemLocationSpendingData!
        .where((element) =>
            element.ward == _selectedWard && element.year == _selectedYear)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final selectedData = Provider.of<SelectedData>(context);
    if (_wardItemLocationSpendingData == null) {
      return const CircularProgressIndicator();
    }
    if (_wardItemLocationSpendingData!.isEmpty) {
      return const Text("Error loading data");
    }
    if (selectedData.selectedCategory == null ||
        selectedData.selectedCategory == "") {
      return const Center(
          child: Text("Select a category to see spending breakdown"));
    }

    final selectedWardItems = _filteredData!
        .where((element) => element.category == selectedData.selectedCategory)
        .toList();
    return ListView.builder(
      itemBuilder: (context, index) {
        return Container(
          color: index % 2 == 0
              ? Colors.grey[200]
              : Colors.transparent, // Alternate background color
          child: ListTile(
            title: Text(
              selectedWardItems[index].item,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            subtitle: Text(
              selectedWardItems[index].location,
              style: const TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 14,
              ),
            ),
            trailing: Text(
              NumberFormat.simpleCurrency(decimalDigits: 0)
                  .format(selectedWardItems[index].cost),
              style: const TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        );
      },
      itemCount: selectedWardItems.length,
    );
  }
}

class BarChartRegion extends StatefulWidget {
  const BarChartRegion({super.key});

  @override
  BarChartRegionState createState() => BarChartRegionState();
}

// TODO Highlight selected category, make pretty animations
class BarChartRegionState extends State<BarChartRegion> {
  List<AnnualWardSpendingData>? _spendingData;
  int? _selectedWard;
  int? _selectedYear;
  List<AnnualWardSpendingData>? _filteredData;

  @override
  void initState() {
    loadAnnualCategorySpendingData().then((data) {
      setState(() {
        _spendingData = data;
        _filteredData = _filterData();
      });
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final selectedData = Provider.of<SelectedData>(context);
    if (_selectedWard != selectedData.selectedWard ||
        _selectedYear != selectedData.selectedYear) {
      _selectedWard = selectedData.selectedWard;
      _selectedYear = selectedData.selectedYear;
      _filteredData = _filterData();
    }
    super.didChangeDependencies();
  }

  List<AnnualWardSpendingData>? _filterData() {
    if (_spendingData == null ||
        _selectedWard == null ||
        _selectedYear == null) {
      return null;
    }
    return _spendingData!
        .where((element) =>
            element.ward == _selectedWard && element.year == _selectedYear)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    if (_spendingData == null) {
      return const CircularProgressIndicator();
    }
    if (_spendingData!.isEmpty) {
      return const Text("Error loading data");
    }
    if (_filteredData == null) {
      return const Text("No data available for the selected ward and year");
    }
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

  Widget wardYearSelector() {
    final selectedData = Provider.of<SelectedData>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        DropdownButton<int>(
          // set menumaxheight to quarter of the screen height
          menuMaxHeight: MediaQuery.of(context).size.height / 4,
          value: selectedData._selectedWard,
          onChanged: (int? newValue) {
            selectedData.updateSelectedWard(newValue!);
            selectedData.updateSelectedCategory('');
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
          value: selectedData._selectedYear,
          onChanged: (int? newValue) {
            selectedData.updateSelectedYear(newValue!);
            selectedData.updateSelectedCategory('');
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
    final selectedData = Provider.of<SelectedData>(context);

    return SfCartesianChart(
      onAxisLabelTapped: (axisLabelTapArgs) {
        selectedData.updateSelectedCategory(axisLabelTapArgs.text);
      },
      title: ChartTitle(text: 'Spending by Category'),
      primaryXAxis: CategoryAxis(labelStyle: const TextStyle(fontSize: 16)),
      primaryYAxis: NumericAxis(
        axisLabelFormatter: (axisLabelRenderArgs) {
          final value = axisLabelRenderArgs.value;
          if (value >= 1000000) {
            final double valueInMillions = value / 1000000;
            final formattedValue =
                '${NumberFormat('#,##0.##').format(valueInMillions)}M';
            return ChartAxisLabel(
                formattedValue, axisLabelRenderArgs.textStyle);
          } else if (value >= 1000) {
            final formattedValue =
                '${NumberFormat('#,##0').format(value ~/ 1000)}k';
            return ChartAxisLabel(
                formattedValue, axisLabelRenderArgs.textStyle);
          } else {
            return ChartAxisLabel(NumberFormat('#,##0').format(value),
                axisLabelRenderArgs.textStyle);
          }
        },
      ),
      series: <BarSeries<AnnualWardSpendingData, String>>[
        BarSeries<AnnualWardSpendingData, String>(
          dataSource: _filteredData!,
          onPointTap: (ChartPointDetails args) {
            selectedData.updateSelectedCategory(
                _filteredData![args.pointIndex!].category);
          },
          xValueMapper: (AnnualWardSpendingData data, _) => data.category,
          yValueMapper: (AnnualWardSpendingData data, _) => data.cost,
          dataLabelSettings: DataLabelSettings(
            isVisible: true,
            labelAlignment: ChartDataLabelAlignment.outer,
            builder: (data, point, series, pointIndex, seriesIndex) => Text(
              "\$${NumberFormat.compact().format(data.cost)}",
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ),
        )
      ],
    );
  }
}

class SelectedData extends ChangeNotifier {
  int _selectedWard = 1;
  int _selectedYear = 2019;
  String? _selectedCategory;

  int get selectedWard => _selectedWard;
  int get selectedYear => _selectedYear;
  String? get selectedCategory => _selectedCategory;

  void updateSelectedWard(int ward) {
    _selectedWard = ward;
    notifyListeners();
  }

  void updateSelectedYear(int year) {
    _selectedYear = year;
    notifyListeners();
  }

  void updateSelectedCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }
}

class AnnualWardSpendingData {
  final int ward;
  final int year;
  final String category;
  final int cost;

  AnnualWardSpendingData({
    required this.ward,
    required this.year,
    required this.category,
    required this.cost,
  });
}

class WardItemLocationSpendingData {
  final int ward;
  final int year;
  final String item;
  final String category;
  final int cost;
  final String location;
  WardItemLocationSpendingData(
      {required this.ward,
      required this.year,
      required this.item,
      required this.category,
      required this.cost,
      required this.location});
}

Future<List<AnnualWardSpendingData>> loadAnnualCategorySpendingData() async {
  late String rawdata;
  try {
    rawdata = await rootBundle
        .loadString('assets/2019-2022_ward_category_totals.csv');
  } catch (e) {
    return [];
  }
  final csvTable = const CsvToListConverter()
      .convert(rawdata, eol: '\n', shouldParseNumbers: false);
  List<AnnualWardSpendingData> spendingData = [];
  for (var i = 1; i < csvTable.length; i++) {
    final item = csvTable[i];
    final newData = AnnualWardSpendingData(
      ward: int.parse(item[0].trim()),
      year: int.parse(item[1].trim()),
      category: item[2].trim(),
      cost: int.parse(item[3].trim()),
    );
    spendingData.add(newData);
  }
  return spendingData;
}

Future<List<WardItemLocationSpendingData>> loadCategoryItemsData() async {
  late String rawdata;
  try {
    rawdata = await rootBundle.loadString('assets/2019-2022_ward_items.csv');
  } catch (e) {
    return [];
  }
  final csvTable = const CsvToListConverter()
      .convert(rawdata, eol: '\n', shouldParseNumbers: false);
  List<WardItemLocationSpendingData> itemData = [];
  for (var i = 1; i < csvTable.length; i++) {
    final item = csvTable[i];
    final newData = WardItemLocationSpendingData(
      ward: int.parse(item[0].trim()),
      year: int.parse(item[1].trim()),
      item: item[2].trim(),
      category: item[3].trim(),
      location: item[4].trim(),
      cost: int.parse(item[5].trim()),
    );
    itemData.add(newData);
  }
  return itemData;
}
