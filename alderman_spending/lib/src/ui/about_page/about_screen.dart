import 'package:flutter/material.dart';
import 'package:alderman_spending/src/ui/navigation/navigation_drawer.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ListView contents = ListView(
      padding: const EdgeInsets.all(32),
      children: [
        Text(
          '''Ward Wise is a breakout group under Chi Hack Night. Our source code is available on GitHub. We use data scraped from the Chicago Capital Improvements Archive by Jake Smith and John C. Ruf.
              ''',
          softWrap: true,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );

    return Scaffold(
      drawer: MyNavigationDrawer(),
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          // Desktop layout
          return Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 250.0), // Add your desired padding
            child: contents,
          );
        } else {
          // Mobile layout
          return contents;
        }
      }),
    );
  }
}
