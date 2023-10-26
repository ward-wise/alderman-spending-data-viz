import 'package:flutter/material.dart';
import 'package:alderman_spending/src/ui/navigation/navigation_drawer.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyNavigationDrawer(),
      appBar: AppBar(title: const Text('FAQ'),),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth / constraints.maxHeight > 1.3) {
            return GridViewFAQ(columns: 2);
          }
          return GridViewFAQ(columns: 1);
        },
      ),
    );
  }
}

class GridViewFAQ extends StatelessWidget {
  final int columns;

  const GridViewFAQ({super.key, required this.columns});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(50),
        child: GridView.count(
          crossAxisCount: columns,
          children: [
            FAQCollapsableWidget(
                question: "What's a menu item?",
                answer:
                    "Check out the menu items tab to see a description, image, and price for the project Alderpeople can spend money on.")
          ],
        ));
  }
}

class FAQCollapsableWidget extends StatelessWidget {
  final String answer;

  final String question;

  const FAQCollapsableWidget(
      {super.key, required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      collapsedBackgroundColor: Theme.of(context).cardColor,
      backgroundColor: Theme.of(context).cardColor,
      tilePadding: EdgeInsets.fromLTRB(50, 0, 50, 0),
      childrenPadding: EdgeInsets.fromLTRB(50, 0, 50, 0),
      title: Text(question),
      children: <Widget>[Text(answer)],
    );
  }
}
