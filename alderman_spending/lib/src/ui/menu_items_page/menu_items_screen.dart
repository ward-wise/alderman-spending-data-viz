import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:hovering/hovering.dart';

final imagePath = 'assets/images/menu_items/AlleySpeedHumpProgram.png';
final title = 'Alley Speed Hump';
final subtitle =
    'The Alley Speed Hump Program is a new program that will install speed humps...';

class MenuItemsScreen extends StatelessWidget {
  const MenuItemsScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu Items'),
      ),
      body: ListView(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MenuItemDetailScreen(
                    imagePath: imagePath,
                    title: title,
                    subtitle: subtitle,
                  ),
                ),
              );
            },
            child: MenuListItem(
              imagePath: imagePath,
              title: title,
              subtitle: subtitle,
            ),
          ),
        ],
      ),
    );
  }
}

class MenuItemDetailScreen extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;

  MenuItemDetailScreen({
    required this.imagePath,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: 'menu_item_image',
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset(imagePath),
              ),
            ),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text("Average Cost: \$1,400 per block"),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text("This program is primarily designed to reduce vehicular traffic speed in residential alleys and will consist of installing raised rubber 'humps' on improved alleys. No resurfacing will be included as part of this program. CDOT recommends a survey of the affected residents before choosing a location and retains the final approval for each location. Due to the variety and shape of alleys throughout the City, actual quantities and prices will vary accordingly."),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuListItem extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;

  MenuListItem({
    required this.imagePath,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children:[ItemCard(imagePath: imagePath, title: title, subtitle: subtitle)]);
  }
}

class ItemCard extends StatelessWidget {
  const ItemCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
  });

  final String imagePath;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return HoverCrossFadeWidget(
      duration: Duration(milliseconds: 50),
      firstChild: Card(
        elevation: 4, // Add elevation for shadow effect
        child: ListTile(
          dense: false,
          leading: Image.asset(
            imagePath,
            fit: BoxFit.cover,
          ),
          title: Text(title),
          subtitle: Text(subtitle),
        ),
      ),
      secondChild: Card(
        color: Colors.grey[400],
        elevation: 4, // Add elevation for shadow effect
        child: ListTile(
          dense: false,
          leading: Image.asset(
            imagePath,
            fit: BoxFit.cover,
          ),
          title: Text(title),
          subtitle: Text(subtitle),
        ),
      ),
    );
  }
}
