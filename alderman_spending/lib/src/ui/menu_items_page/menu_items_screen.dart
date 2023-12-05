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
          drawer: MyNavigationDrawer(),
          appBar: AppBar(
            title: const Text('Aldermanic Menu Items'),
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: menuItems.length,
                  itemBuilder: (context, index) {
                    return MenuListItem(menuItemInfo: menuItems[index]);
                  },
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
