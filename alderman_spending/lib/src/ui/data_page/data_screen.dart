import 'package:flutter/material.dart';
import 'package:alderman_spending/src/ui/chart_page/chart_screen.dart';
import 'package:alderman_spending/src/ui/navigation/navigation_drawer.dart';

class DataPage extends StatelessWidget {
  final int initialWard;
  final int initialYear;
  const DataPage({super.key, this.initialWard = 1, this.initialYear = 2023});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyNavigationDrawer(),
      appBar: AppBar(
        title: const Text('Ward Spending'),
        // title: Text('$initialWard - $initialYear'),
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
    child: ChartScreen(),
  );
}

Widget _buildWideContainers() {
  return const Center(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          flex: 1,
          child: ChartScreen(),
        ),
      ],
    ),
  );
}
