import 'package:flutter/material.dart';
import 'package:alderman_spending/src/ui/choropleth_map/choropleth_map.dart';
import 'package:alderman_spending/src/ui/chart_page/chart_screen.dart';
import 'package:alderman_spending/src/ui/navigation/navigation_drawer.dart';

class CategoryMapPage extends StatelessWidget {
  const CategoryMapPage({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyNavigationDrawer(),
      appBar: AppBar(
        title: const Text('Spending by Category'),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth > 800) {
            return _buildWideContainers();
          } else {
            return _buildNarrowContainer();
          }
        },
      ),
    );
  }
}

Widget _buildNarrowContainer() {
  return const Center(
    child: ChoroplethMapPage(),
  );
}

Widget _buildWideContainers() {
  return const Center(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          flex: 1,
          child: ChoroplethMapPage(),
        ),
      ],
    ),
  );
}
