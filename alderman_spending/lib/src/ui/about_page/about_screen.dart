import 'package:flutter/material.dart';
import 'package:alderman_spending/src/ui/navigation/navigation_drawer.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyNavigationDrawer(),
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(32),
        children: [
          Text(
            '''Ward Wise is a breakout group under Chi Hack Night. Our source code is available on GitHub. We use data scraped from the Chicago Capital Improvements Archive by Jake Smith and John C. Ruf.
              ''',
            // TODO add links, add repo, add data download button, give credit to John and Jake, give credit to ourselves
            softWrap: true,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
