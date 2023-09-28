import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:hovering/hovering.dart';
import 'package:alderman_spending/src/data/models/menu_item_info.dart';
import 'package:alderman_spending/src/data/loaders.dart';
import 'package:intl/intl.dart';

const baseImagePath = 'assets/images/menu_items/';
final menuItems = loadMenuItems();

class MenuItemsScreen extends StatelessWidget {
  const MenuItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Menu Items'),
        ),
        body: FutureBuilder(
          future: menuItems,
          builder: (context, AsyncSnapshot<List<MenuItemInfo>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  // MenuListItem that can be clicked to produce MenuItemDetailScreen
                  // TODO, add routing or close button to MenuItemDetailScreen
                  return InkWell(
                    hoverColor: Colors.grey[300],
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
                      imagePath:
                          baseImagePath + snapshot.data![index].imgFilename,
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

  const MenuItemDetailScreen({super.key, required this.menuItemInfo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TODO Make look better
      body: Center(
          child: GFCard(
        elevation: 15,
        padding: const EdgeInsets.all(20.0),
        image: Image.asset(
          baseImagePath + menuItemInfo.imgFilename,
          fit: BoxFit.cover,
        ),
        showImage: true,
        title: GFListTile(
            title: Text(
              menuItemInfo.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            subTitle: Text(
              '${NumberFormat.simpleCurrency(decimalDigits: 0).format(menuItemInfo.cost)} per ${menuItemInfo.measurement}',
              style: const TextStyle(fontSize: 16),
            ),
            shadow: BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            )),
        // TODO Probably turn this into a scrollable text region
        content: Column(
          children: [
            Text(
              menuItemInfo.description,
              style: const TextStyle(fontSize: 16),
              overflow: TextOverflow.fade,
            ),
            if (menuItemInfo.notes != null)
              ListView.builder(
                shrinkWrap: true,
                itemCount: menuItemInfo.notes!.length,
                itemBuilder: (context, index) {
                  return Text(
                    'Note ${index + 1}: ${menuItemInfo.notes![index]}',
                    style: const TextStyle(fontSize: 12),
                  );
                },
              ),
          ],
        ),
      )),
    );
  }
}

class MenuListItem extends StatelessWidget {
  final String imagePath;
  final String title;
  final int cost;
  final String unit;

  const MenuListItem({
    super.key,
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
    return Card(
      margin: const EdgeInsets.fromLTRB(5, 8, 5, 8),
      elevation: 5,
      child: ListTile(
        dense: false,
        leading: Image.asset(
          imagePath,
          fit: BoxFit.cover,
          scale: 2,
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 20),
        ),
        subtitle: Text(
          "${NumberFormat.simpleCurrency(decimalDigits: 0).format(cost)} Per $unit",
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
