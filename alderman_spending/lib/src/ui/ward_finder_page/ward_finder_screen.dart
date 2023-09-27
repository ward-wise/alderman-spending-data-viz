import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

final MapShapePath = "/workspaces/alderman-spending/alderman_spending/assets/Wards-Boundaries.geojson";
late MapShapeSource dataSource;

class WardFinderScreen extends StatefulWidget {
  const WardFinderScreen({super.key});

  @override
  State<WardFinderScreen> createState() => _WardFinderScreenState();
}

class _WardFinderScreenState extends State<WardFinderScreen> {

  @override
void initState() {
  dataSource = MapShapeSource.asset(
    MapShapePath,
    shapeDataField: 'ward',
  );
  super.initState();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:SfMaps(layers: [MapShapeLayer(source: dataSource)],));
  }
}