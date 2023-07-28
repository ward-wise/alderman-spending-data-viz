import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'src/data/models/annual_ward_spending_data.dart';
import 'src/data/models/ward_item_location_spending_data.dart';
import 'src/data/providers/selected_data.dart';
import 'src/data/loaders.dart';
import 'src/utils/language.dart';

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
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('es', 'US'),
      ],
      title: "Alderman Spending",
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
      return Text(AppLocalizations.of(context)!.errorLoadingData);
    }
    if (selectedData.selectedCategory == null ||
        selectedData.selectedCategory == "") {
      return Center(
          child: Text(AppLocalizations.of(context)!.detailPlaceholder));
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
      return Text(AppLocalizations.of(context)!.errorLoadingData);
    }
    if (_filteredData == null) {
      return Text(AppLocalizations.of(context)!
          .noDataForWardYear(_selectedWard!, _selectedYear!));
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
          menuMaxHeight: MediaQuery.of(context).size.height / 3,
          value: selectedData.selectedWard,
          onChanged: (int? newValue) {
            selectedData.updateSelectedWard(newValue!);
            selectedData.updateSelectedCategory('');
          },
          items: List<int>.generate(50, (i) => i + 1)
              .map<DropdownMenuItem<int>>((int value) {
            return DropdownMenuItem<int>(
              value: value,
              child: Text(AppLocalizations.of(context)!.wardDropdown(value)),
            );
          }).toList(),
        ),
        DropdownButton<int>(
          value: selectedData.selectedYear,
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
      title: ChartTitle(text: AppLocalizations.of(context)!.chartTitle),
      primaryXAxis: CategoryAxis(labelStyle: const TextStyle(fontSize: 16)),
      primaryYAxis: NumericAxis(
        axisLabelFormatter: (axisLabelRenderArgs) {
          return ChartAxisLabel(
              NumberFormat.compact().format(axisLabelRenderArgs.value),
              axisLabelRenderArgs.textStyle);
        },
      ),
      series: <BarSeries<AnnualWardSpendingData, String>>[
        BarSeries<AnnualWardSpendingData, String>(
          selectionBehavior: SelectionBehavior(
            toggleSelection: false,
            enable: true,
            selectedColor: Colors.blue[800],
            unselectedColor: const Color(0xFF4b87b9),
            unselectedOpacity: 1,
          ),
          dataSource: _filteredData!,
          onPointTap: (ChartPointDetails args) {
            selectedData.updateSelectedCategory(
                _filteredData![args.pointIndex!].category);
          },
          xValueMapper: (AnnualWardSpendingData data, _) {
            if (Localizations.localeOf(context).languageCode == 'en') {
              return data.category;
            }
            return categoryTranslations[data.category];
          },
          yValueMapper: (AnnualWardSpendingData data, _) => data.cost,
          dataLabelSettings: DataLabelSettings(
            isVisible: true,
            labelAlignment: ChartDataLabelAlignment.outer,
            builder: (data, point, series, pointIndex, seriesIndex) => Text(
              NumberFormat.compactSimpleCurrency().format(data.cost),
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
