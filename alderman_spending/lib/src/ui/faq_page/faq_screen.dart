import 'package:flutter/material.dart';
import 'package:alderman_spending/src/ui/navigation/navigation_drawer.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyNavigationDrawer(),
      appBar: AppBar(
        title: const Text('Frequently Asked Questions'),
      ),
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
          children: const [
            FAQWidget(
              question: "What's a menu item?",
              answer:
                  "Check out the menu items tab to see a description, image, and price for the project Alderpeople can spend money on.",
            ),
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

class FAQWidget extends StatelessWidget {
  final String answer;
  final String question;

  const FAQWidget({
    Key? key,
    required this.question,
    required this.answer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          question,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        Text(
          answer,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
