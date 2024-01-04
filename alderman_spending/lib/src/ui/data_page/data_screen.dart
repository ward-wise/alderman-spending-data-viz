import 'package:alderman_spending/src/data/providers/selected_data.dart';
import 'package:flutter/material.dart';
import 'package:alderman_spending/src/ui/chart_page/chart_screen.dart';
import 'package:alderman_spending/src/ui/navigation/navigation_drawer.dart';
import 'package:provider/provider.dart';

class DataPage extends StatelessWidget {
  final int initialWard;
  final int initialYear;

  const DataPage({super.key, this.initialWard = 1, this.initialYear = 2023});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyNavigationDrawer(),
      body: Builder(
        builder: (BuildContext context) {
          // Use Builder widget to get a new context where Provider.of will work
          final selectedData =
              Provider.of<SelectedData>(context, listen: false);

          // Schedule the state update to occur after the build is complete
          Future.delayed(Duration.zero, () {
            selectedData.updateSelectedWard(initialWard);
            selectedData.updateSelectedYear(initialYear);
          });

          return LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              if (constraints.maxWidth > 800) {
                return _buildWideContainers();
              } else {
                return _buildNarrowContainer();
              }
            },
          );
        },
      ),
    );
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
}
