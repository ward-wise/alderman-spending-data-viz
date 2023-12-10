import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:alderman_spending/src/data/models/menu_item_info.dart';
import 'package:alderman_spending/src/data/loaders.dart';
import 'package:intl/intl.dart';
import 'package:alderman_spending/src/ui/navigation/navigation_drawer.dart';

const baseImagePath = 'assets/images/menu_items';

class MenuItemsScreen extends StatelessWidget {
  const MenuItemsScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MenuItemInfo>>(
      future: loadMenuItems(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error loading data'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No data available'));
        }

        final menuItems = snapshot.data!;

        return Scaffold(
          drawer: const MyNavigationDrawer(),
          appBar: AppBar(
            title: const Text('Aldermanic Menu Items'),
          ),
          body: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Column(
                      children: [
                        const SizedBox(height: 30),
                        Text(
                          "Each year, CDOT and OBM provide alderpersons a list of standard menu items. Costs are estimated based on previous years' costs. Alderpersons select items from this list to allocate their \$1.5 million budget.",
                          style: Theme.of(context).textTheme.bodyLarge,
                          softWrap: true,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Tap items to learn more.",
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                          softWrap: true,
                        ),
                        const SizedBox(height: 25),
                        if(MediaQuery.of(context).size.aspectRatio < 1.3)
                          ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: menuItems.length,
                          itemBuilder: (context, index) {
                            return MenuListItem(menuItemInfo: menuItems[index]);
                          },
                        )
                        else
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: menuItems.length,
                            primary: false,
                            // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            //   crossAxisCount: 3,
                            //   childAspectRatio: 1.5,
                            //   crossAxisSpacing: 20,
                            //   mainAxisSpacing: 20,
                            // ),
                            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 600,
                              childAspectRatio: 1.5,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20,
                            ),
                            itemBuilder: (context, index) {
                              return MenuGridItem(menuItemInfo: menuItems[index]);
                            },
                          )
                        
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        );
      },
    );
  }
}

class MenuListItem extends StatelessWidget {
  final MenuItemInfo menuItemInfo;

  const MenuListItem({super.key, required this.menuItemInfo});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: Colors.grey[300],
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MenuItemDetailScreen(
              menuItemInfo: menuItemInfo,
            ),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.fromLTRB(5, 8, 5, 8),
        elevation: 5,
        child: ListTile(
          dense: false,
          leading: Image.asset(
            '$baseImagePath/${menuItemInfo.imgFilename}',
            fit: BoxFit.cover,
            scale: 2,
          ),
          title: Text(
            menuItemInfo.title,
            style: const TextStyle(fontSize: 20),
          ),
          subtitle: Text(
            _parseCostMeasurement(menuItemInfo),
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}

class MenuGridItem extends StatelessWidget {
  final MenuItemInfo menuItemInfo;

  const MenuGridItem({Key? key, required this.menuItemInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: Colors.grey[300],
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MenuItemDetailScreen(
              menuItemInfo: menuItemInfo,
            ),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.all(8),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 8),
              Text(
                menuItemInfo.title,
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                _parseCostMeasurement(menuItemInfo),
                style: const TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Image.asset(
                '$baseImagePath/${menuItemInfo.imgFilename}',
                fit: BoxFit.cover,
                scale: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class MenuItemDetailScreen extends StatelessWidget {
  final MenuItemInfo menuItemInfo;
  static final _boxShadowSettings = BoxShadow(
    color: Colors.grey[500]!,
    spreadRadius: 5,
    blurRadius: 7,
    offset: const Offset(0, 3),
  );

  const MenuItemDetailScreen({super.key, required this.menuItemInfo});
  // TODO Add a back or close button
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GFCard(
        height: MediaQuery.of(context).size.height,
        elevation: 15,
        // padding: const EdgeInsets.all(20.0),
        image: Image.asset(
          '$baseImagePath/${menuItemInfo.imgFilename}',
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
            _parseCostMeasurement(menuItemInfo),
            style: const TextStyle(fontSize: 16),
          ),
          shadow: _boxShadowSettings,
        ),
        // margin: const EdgeInsets.all(20.0),
        // TODO Make this scrollable, overflows for some reason
        content: Column(
          children: [
            Text(
              menuItemInfo.description,
              style: const TextStyle(fontSize: 16),
            ),
            _parseNotes(),
          ],
        ),
      ),
    );
  }

  _parseNotes() {
    if (menuItemInfo.notes != null) {
      return Column(
        children: menuItemInfo.notes!
            .asMap()
            .entries
            .map((entry) => Text(
                  'Note ${entry.key + 1}: ${entry.value}',
                  style: const TextStyle(fontSize: 12),
                ))
            .toList(),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}

_parseCostMeasurement(MenuItemInfo menuItemInfo) {
  return '${NumberFormat.simpleCurrency(decimalDigits: 0).format(menuItemInfo.cost)} per ${menuItemInfo.measurement}';
}
