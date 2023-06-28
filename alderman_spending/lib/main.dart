import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => SelectedData(),
    child: MyApp(),
  ));
}

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
                  VerticalDivider(
                    color: Colors.grey,
                    width: 0,
                    thickness: 1,
                  ),
                  Expanded(child: PieChartRegion()),
                ],
              );
            } else {
              return Column(
                children: [
                  Expanded(child: PieChartRegion()),
                  Divider(
                    color: Colors.grey,
                    height: 0,
                    thickness: 1,
                  ),
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
  List<WardItemLocationSpendingData>? _wardItemLocationSpendingData;
  @override
  void initState() {
    loadCategoryItemsData().then((data) {
      setState(() {
        _wardItemLocationSpendingData = data;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final selectedData = Provider.of<SelectedData>(context);
    if (_wardItemLocationSpendingData == null) {
      return CircularProgressIndicator();
    }
    if (_wardItemLocationSpendingData!.isEmpty) {
      return const Text("Error loading data");
    }
    if (selectedData.selectedCategory == null) {
      return const Center(child: Text("Select a category to see spending breakdown"));
    }
    final _selectedWardItems = _wardItemLocationSpendingData!
        .where((element) =>
            element.category == selectedData.selectedCategory &&
            element.ward == selectedData.selectedWard &&
            element.year == selectedData.selectedYear)
        .toList();
    return ListView.builder(
      itemBuilder: (context, index) {
        return Container(
          color: index % 2 == 0
              ? Colors.grey[200]
              : Colors.transparent, // Alternate background color
          child: ListTile(
            title: Text(
              _selectedWardItems[index].item,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            subtitle: Text(
              _selectedWardItems[index].location,
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 14,
              ),
            ),
            trailing: Text(
              NumberFormat.simpleCurrency()
                  .format(_selectedWardItems[index].cost),
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        );
      },
      itemCount: _selectedWardItems.length,
    );
  }
}

class PieChartRegion extends StatefulWidget {
  const PieChartRegion({super.key});

  @override
  PieChartRegionState createState() => PieChartRegionState();
}

class PieChartRegionState extends State<PieChartRegion> {
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
    if (_spendingData == null || _selectedWard == null || _selectedYear == null) {
      return null;
    }
    return _spendingData!.where((element) =>
        element.ward == _selectedWard && element.year == _selectedYear).toList();
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
        print(selectedData.selectedCategory);
      },
      title: ChartTitle(text: 'Spending per Category'),
      primaryXAxis: CategoryAxis(title: AxisTitle(text: 'Categories')),
      primaryYAxis: NumericAxis(title: AxisTitle(text: 'Spending')),
      series: <BarSeries<AnnualWardSpendingData, String>>[
        BarSeries<AnnualWardSpendingData, String>(
          dataSource: _filteredData!,
          onPointTap: (ChartPointDetails args) {
            selectedData.updateSelectedCategory(
                _filteredData![args.pointIndex!].category);
            print(selectedData.selectedCategory);
          },
          xValueMapper: (AnnualWardSpendingData data, _) => data.category,
          yValueMapper: (AnnualWardSpendingData data, _) => data.cost,
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
  var csvTable = const CsvToListConverter().convert(rawdata, eol: '\n', shouldParseNumbers: false);
  var spendingData = <AnnualWardSpendingData>[];

  for (var i = 1; i < csvTable.length; i++) {
    var item = csvTable[i];
    var newData = AnnualWardSpendingData(
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
  final csvTable = const CsvToListConverter().convert(rawdata, eol: '\n', shouldParseNumbers: false);
  final itemData = <WardItemLocationSpendingData>[];
  for(var i = 1; i < csvTable.length; i++) {
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