import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

const String mapShapePath =
    'assets/Wards-Boundaries.geojson';

class WardFinderScreen extends StatefulWidget {
  const WardFinderScreen({Key? key}) : super(key: key);

  @override
  State<WardFinderScreen> createState() => _WardFinderScreenState();
}

class _WardFinderScreenState extends State<WardFinderScreen> {
  late MapShapeSource dataSource;
  late int? _selectedWard;
  @override
  void initState() {
    _selectedWard = null;
    dataSource = MapShapeSource.asset(
      mapShapePath,
      shapeDataField: 'ward',
      dataCount: 50,
      primaryValueMapper: (int index) => (index+1).toString(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SfMaps(
        layers: [
          MapShapeLayer(
            source: dataSource,
            selectedIndex: _selectedWard ?? -1,
            onSelectionChanged: (value) {
              if(value == _selectedWard){return;}
              setState(() {
              _selectedWard = value;
              print(_selectedWard);
            });
            },
            selectionSettings: MapSelectionSettings(
              color: Colors.blue,
              strokeColor: Colors.black,
              strokeWidth: 2,
            ),
          ),
        ],
      ),
    );
  }
}
