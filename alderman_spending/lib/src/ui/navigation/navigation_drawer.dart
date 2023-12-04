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
          Navigator.pushNamed(context, '/');
        },
      ),
      ListTile(
        title: const Text("Find My Ward"),
        onTap: () {
          Navigator.pushNamed(context, '/find-my-ward');
        },
      ),
      ListTile(
        title: const Text("View Ward Spending"), //need Applocalizations
        onTap: () {
          Navigator.pushNamed(context, '/ward-spending');
        },
      ),
      ListTile(
        title: const Text("Categorical Spending Map"), //need Applocalizations
        onTap: () {
          Navigator.pushNamed(context, '/category-map');
        },
      ),
      ListTile(
        title: const Text("View Spending Menu"),
        onTap: () {
          Navigator.pushNamed(context, '/menu-items');
        },
      ),
      ListTile(
        title: const Text("FAQs"),
        onTap: () {
          Navigator.pushNamed(context, '/faqs');
        },
      ),
      // ListTile(
      //   title: const Text("About"),
      //   onTap: () {
      //       Navigator.of(context).push(MaterialPageRoute(
      //         builder: (context) => const FAQScreen(),));
      //     },
      // ),
    ]));
  }
}
