import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:hovering/hovering.dart';
import 'package:alderman_spending/src/data/models/menu_item_info.dart';
import 'package:alderman_spending/src/data/loaders.dart';
import 'package:intl/intl.dart';

const baseImagePath = 'assets/images/menu_items/';
final menuItems = loadMenuItems();

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

  MenuItemDetailScreen({required this.menuItemInfo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            subTitle: Text(
              '${NumberFormat.simpleCurrency(decimalDigits: 0).format(menuItemInfo.cost)} per ${menuItemInfo.measurement}',
              style: TextStyle(fontSize: 16),
            ),
            shadow: BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            )),
        content: Column(
          children: [
            Text(
              menuItemInfo.description,
              style: TextStyle(fontSize: 16),
              overflow: TextOverflow.fade,
            ),
            // builder to loop through notes, if not null. use index to number notes
            if (menuItemInfo.notes != null)
              ListView.builder(
                shrinkWrap: true,
                itemCount: menuItemInfo.notes!.length,
                itemBuilder: (context, index) {
                  return Text(
                    'Note ${index + 1}: ${menuItemInfo.notes![index]}',
                    style: TextStyle(fontSize: 12),
                  );
                },
              ),
          ],
        ),
      )

          // child: Column(
          //   // mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Hero(
          //       tag: 'menu_item_image',
          //       child: Padding(
          //         padding: const EdgeInsets.all(20.0),
          //         child: Image.asset(baseImagePath + menuItemInfo.imgFilename),
          //       ),
          //     ),
          //     SizedBox(height: 10),
          //     GFBorder(
          //         type: GFBorderType.rRect,
          //         dashedLine: [10, 0],
          //         child: Column(
          //           children: [
          //             Text(
          //               menuItemInfo.title,
          //               style:
          //                   TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          //             ),
          //             SizedBox(height: 8),
          //             Text(
          //               '${NumberFormat.simpleCurrency(decimalDigits: 0).format(menuItemInfo.cost)} per ${menuItemInfo.measurement}',
          //               style: TextStyle(fontSize: 16),
          //             ),
          //           ],
          //         )),
          //     SizedBox(height: 8),
          //     Padding(
          //         padding: const EdgeInsets.all(20.0),
          //         child: Text(
          //           menuItemInfo.description,
          //           style: TextStyle(fontSize: 16),
          //         )),
          //   ],
          // ),
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
    return Card(
      margin: EdgeInsets.fromLTRB(5, 8, 5, 8),
      elevation: 5, // Add elevation for shadow effect
      child: ListTile(
        dense: false,
        leading: Image.asset(
          imagePath,
          fit: BoxFit.cover,
          scale: 2,
        ),
        title: Text(
          title,
          style: TextStyle(fontSize: 20),
        ),
        subtitle: Text(
          "${NumberFormat.simpleCurrency(decimalDigits: 0).format(cost)} Per $unit",
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
