import 'package:alderman_spending/main.dart';
import 'package:alderman_spending/src/ui/category_map_page/category_map_screen.dart';
import 'package:alderman_spending/src/ui/data_page/data_screen.dart';
import 'package:alderman_spending/src/ui/menu_items_page/menu_items_screen.dart';
import 'package:flutter/material.dart';
import 'package:alderman_spending/src/ui/about_page/about_screen.dart';
import 'package:alderman_spending/src/ui/chart_page/chart_screen.dart';
import 'package:alderman_spending/src/ui/faq_page/faq_screen.dart';
import 'package:alderman_spending/src/ui/home_screen/home_screen.dart';
import 'package:alderman_spending/src/ui/ward_finder_page/ward_finder_screen.dart';
import 'package:alderman_spending/src/ui/choropleth_map/choropleth_map.dart';

class MyNavigationDrawer extends StatelessWidget {
  const MyNavigationDrawer({
    Key? key,
    // required this.localeProvider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(children: [
      ListTile(
        title: const Text("Home"),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const MyApp(),
          ));
        },
      ),
      ListTile(
        title: const Text("Find My Ward"),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const WardFinderScreen(),
          ));
        },
      ),
      // ListTile(
      //   title: const Text("Spending charts"),
      //   onTap: () {
      //       Navigator.of(context).push(MaterialPageRoute(
      //         builder: (context) => const ChartScreen(),));
      //     },
      // ),
      // ListTile(
      //   title: const Text("About"),
      //   onTap: () {
      //       Navigator.of(context).push(MaterialPageRoute(
      //         builder: (context) => const FAQScreen(),));
      //     },
      // ),
      //  ListTile(
      //   title: const Text("Spending Map"), //need Applocalizations
      //   onTap: () {
      //       Navigator.of(context).push(MaterialPageRoute(
      //         builder: (context) => const ChoroplethMapPage(),));
      //   },
      // ),
      ListTile(
        title: const Text("Past Spending Data"), //need Applocalizations
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const DataPage(),
          ));
        },
      ),
      ListTile(
        title: const Text("Categorical Spending Map"), //need Applocalizations
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const CategoryMapPage(),
          ));
        },
      ),
      ListTile(
        title: const Text("Ward Spending Menu"),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const MenuItemsScreen(),
          ));
        },
      ),
      ListTile(
        title: const Text("FAQs"),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const FAQScreen(),
          ));
        },
      ),
    ]));
  }
}
