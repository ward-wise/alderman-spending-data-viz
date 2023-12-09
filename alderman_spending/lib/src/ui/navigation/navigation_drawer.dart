import 'package:alderman_spending/main.dart';
import 'package:alderman_spending/src/ui/choropleth_map/item_spending_map.dart';
import 'package:alderman_spending/src/ui/menu_items_page/menu_items_screen.dart';
import 'package:alderman_spending/src/ui/ward_finder_page/ward_finder_iframe.dart';
import 'package:flutter/material.dart';
import 'package:alderman_spending/src/ui/about_page/about_screen.dart';
import 'package:alderman_spending/src/ui/chart_page/chart_screen.dart';
import 'package:alderman_spending/src/ui/faq_page/faq_screen.dart';
import 'package:alderman_spending/src/ui/home_screen/home_screen.dart';
import 'package:alderman_spending/src/ui/ward_finder_page/ward_finder_screen.dart';
import 'package:alderman_spending/src/ui/choropleth_map/choropleth_map.dart';
import 'package:alderman_spending/src/ui/data_page/data_screen.dart';

class MyNavigationDrawer extends StatelessWidget {
  const MyNavigationDrawer({
    Key? key,
    // required this.localeProvider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(child: ListView(
        children: [
          ListTile(
            title: const Text("Home"),
            onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MyApp(),));
              },
          ),
          ListTile(
            title: const Text("FAQ"),
            onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const FAQScreen(),));
              },
          ),
          ListTile(
            title: const Text("Ward Finder"),
            onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => WardFinderiFrame(),));
              },
          ),
          ListTile(
            title: const Text("Menu Items"),
            onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const MenuItemsScreen(),));
              },
          ),
          ListTile(
            title: const Text("Spending charts"),
            onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ChartScreen(),));
              },
          ),
          // ListTile(
          //   title: const Text("About"),
          //   onTap: () {
          //       Navigator.of(context).push(MaterialPageRoute(
          //         builder: (context) => const FAQScreen(),));
          //     },
          // ),
          ExpansionTile(
            title: Text("Maps"),
            children: [
              ListTile(
                  title: const Text("Citywide Spending Map"), //need Applocalizations
                  onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ChoroplethMapPage(),));
                  },
              ),
              ListTile(
                  title: const Text("Detailed Item Map"), //need Applocalizations
                  onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ItemSpendingiFrame(),));
                  },
              ),
            ],
          )
          //  ListTile(
          //   title: const Text("Data"), //need Applocalizations
          //   onTap: () {
          //       Navigator.of(context).push(MaterialPageRoute(
          //         builder: (context) => const DataPage(),));
          //   },
          // ),
        ]  
      )
    );
  }
}