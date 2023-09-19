import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:hovering/hovering.dart';
import 'package:alderman_spending/src/data/models/menu_item_info.dart';
import 'package:alderman_spending/src/data/loaders.dart';
import 'package:intl/intl.dart';

const baseImagePath = 'assets/images/menu_items/AlleySpeedHumpProgram.png';
final menuItems = loadMenuItems().then((value) => value);

class MenuItemsScreen extends StatelessWidget {
  const MenuItemsScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Menu Items'),
        ),
        // use loadMenuItems() to make a builder
        body: FutureBuilder(
          future: menuItems,
          builder: (context, AsyncSnapshot<List<MenuItemInfo>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  // MenuListItem that can be clicked to produce MenuItemDetailScreen
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MenuItemDetailScreen(
                            menuItemInfo: snapshot.data![index],
                          ),
                        ),
                      );
                    },
                    child: MenuListItem(
                      imagePath: baseImagePath,
                      title: snapshot.data![index].title,
                      cost: snapshot.data![index].cost,
                      unit: snapshot.data![index].measurement,
                    ),
                  );
                },
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}

class MenuItemDetailScreen extends StatelessWidget {
  final MenuItemInfo menuItemInfo;

  MenuItemDetailScreen({required this.menuItemInfo});

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
                child: Image.asset(baseImagePath),
              ),
            ),
            SizedBox(height: 10),
            Text(
              menuItemInfo.title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              '${menuItemInfo.cost} per ${menuItemInfo.measurement}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  menuItemInfo.description,
                  style: TextStyle(fontSize: 16),
                )),
          ],
        ),
      ),
    );
  }
}

class MenuListItem extends StatelessWidget {
  final String imagePath;
  final String title;
  final int cost;
  final String unit;

  MenuListItem({
    required this.imagePath,
    required this.title,
    required this.cost,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ItemCard(imagePath: imagePath, title: title, cost: cost, unit: unit),
    ]);
  }
}

class ItemCard extends StatelessWidget {
  const ItemCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.cost,
    required this.unit,
  });

  final String imagePath;
  final String title;
  final int cost;
  final String unit;

  @override
  Widget build(BuildContext context) {
    return HoverCrossFadeWidget(
      duration: const Duration(milliseconds: 50),
      firstChild: Card(
        elevation: 4, // Add elevation for shadow effect
        child: ListTile(
          dense: false,
          leading: Image.asset(
            imagePath,
            fit: BoxFit.cover,
          ),
          title: Text(title),
          subtitle: Text(
              "${NumberFormat.simpleCurrency(decimalDigits: 0).format(cost)} Per $unit"),
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
          subtitle: Text(
              "${NumberFormat.simpleCurrency(decimalDigits: 0).format(cost)} Per $unit"),
        ),
      ),
    );
  }
}
