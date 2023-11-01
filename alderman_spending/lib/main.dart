import 'package:alderman_spending/src/ui/menu_items_page/menu_items_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'src/data/providers/selected_data.dart';
import 'src/data/providers/selected_data_choropleth.dart';
import 'src/data/providers/selected_locale.dart';
import 'src/ui/about_page/about_screen.dart';
import 'src/ui/chart_page/chart_screen.dart';
import 'src/ui/faq_page/faq_screen.dart';
import 'src/ui/home_screen/home_screen.dart';
import 'src/ui/ward_finder_page/ward_finder_screen.dart';
import 'src/ui/choropleth_map/choropleth_map.dart';
import 'src/ui/navigation/navigation_drawer.dart';
import 'src/ui/widgets.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SelectedData()),
        ChangeNotifierProvider(create: (context) => SelectedDataMap()),
        ChangeNotifierProvider(create: (context) => LocaleProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);

    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('es', 'US'),
        Locale('pl', 'US'),
      ],
      locale: localeProvider.currentLocale,
      title: "Alderman Spending",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // initialRoute: '/home',
      // routes: generateRoutes(), // Use the generated routes
      home: HomeScreen(),
    );
  }

  // Map<String, WidgetBuilder> generateRoutes() {
  //   return {
  //     '/home': (context) => HomeScreen(),
  //     '/faq': (context) => FAQScreen(),
  //     // '/finder': (context) => PageWithDrawer(child: WardFinderScreen()),
  //     // '/items': (context) => PageWithDrawer(child: MenuItemsScreen()),
  //     // '/charts': (context) => PageWithDrawer(child: ChartScreen()),
  //     // '/about': (context) => PageWithDrawer(child: AboutScreen()),
  //     // '/choropleth': (context) => PageWithDrawer(child: ChoroplethMapPage()),
  //   };
  // }
}

// class PageWithDrawer extends StatelessWidget {
//   const PageWithDrawer({Key? key, required this.child}) : super(key: key);

//   final Widget child;

//   @override
//   Widget build(BuildContext context) {
//     final localeProvider = Provider.of<LocaleProvider>(context);
//     return Scaffold(
//       drawer: ScaffoldDrawer(localeProvider: localeProvider),
//       body: Center(
//         child: Stack(children: [const MenuButton(), child]),
//       ),
//     );
//   }
// }

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Color color = Theme.of(context).primaryColor;
    // Widget buttonSection = Row(
    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //   children: [
    //     _buildButtonColumn(color, Icons.call, 'CALL'),
    //     _buildButtonColumn(color, Icons.near_me, 'ROUTE'),
    //     _buildButtonColumn(color, Icons.share, 'SHARE'),
    //   ],
    // );
    return Scaffold(
        appBar: AppBar(
          title: const Text('Ward-Wise'),
        ),
        drawer: const MyNavigationDrawer(),
        body: ListView(            
            children: [
            Image.asset(            
              'images/chicago_flag.png',            
              width: 600,            
              height: 240,            
              fit: BoxFit.cover,            
              ),            
            titleSection,
            // buttonSection, 
            // textSection,
            // ElevatedButton(
            //   child: Text("Tap on this"),
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: Colors.red,
            //     elevation: 0,
            //   ), 
            //   onPressed: () {
            //     Navigator.push(
            //       context, 
            //       MaterialPageRoute(builder: (context) => const WardFinderScreen())
            //     );
            //     },
            //   ),          
            ],
        ),
      );
  }

  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}

Widget titleSection = Container(
  padding: const EdgeInsets.all(32),
  child: Row(
    children: [
      Expanded(
        /*1*/
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /*2*/
            Container(
              padding: const EdgeInsets.only(bottom: 8),
              child: const Text(
                'Welcome to Ward-Wise!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Text(
              '''Each year, Chicago alders get \$1.5 million in "menu money" to spend at their discretion on capital improvements in their ward. This tool is intended to help residents have a say in the process. It explains past spending in each ward and the options for future spending.
                Use the tool:
                Find my ward or skip to the past ward spending breakdown
                Read answers to frequently asked questions
                See the alder menu options
                Contact your ward to get involved in the improvement process''',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    ],
  ),
);

// Widget textSection = Container(
//   padding: const EdgeInsets.all(32),
//   child: const Text(
//     '''
//     Alderpersons get a menu of items from which they can choose
//     ''',
//     softWrap: true,
//   ),
// );

// class NavigationDrawer extends StatelessWidget {
//   const NavigationDrawer({
//     Key? key,
//     // required this.localeProvider,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(child: ListView(
//         children: [
//           ListTile(
//             title: Text("Home"),
//             onTap: () {
//               // If not on route
//               if (ModalRoute.of(context)!.settings.name != '/home') {
//                 Navigator.popAndPushNamed(context, '/home');
//               }
//             },
//           ),
//           ListTile(
//             title: Text("FAQ"),
//             onTap: () {
//                 Navigator.of(context).push(MaterialPageRoute(
//                   builder: (context) => const ChoroplethMapPage(),));
//               }
//           ),
//           ListTile(
//             title: Text("Ward Finder"),
//             onTap: () {
//               if (ModalRoute.of(context)!.settings.name != '/finder') {
//                 Navigator.popAndPushNamed(context, '/finder');
//               }
//             },
//           ),
//           ListTile(
//             title: Text("Menu Items"),
//             onTap: () {
//               if (ModalRoute.of(context)!.settings.name != '/items') {
//                 Navigator.popAndPushNamed(context, '/items');
//               }
//             },
//           ),
//           ListTile(
//             title: Text("Spending charts"),
//             onTap: () {
//               if (ModalRoute.of(context)!.settings.name != '/charts') {
//                 Navigator.popAndPushNamed(context, '/charts');
//               }
//             },
//           ),
//           ListTile(
//             title: Text("About"),
//             onTap: () {
//               if (ModalRoute.of(context)!.settings.name != '/about') {
//                 Navigator.popAndPushNamed(context, '/about');
//               }
//             },
//           ),
//            ListTile(
//             title: Text("Choropleth Map"), //need Applocalizations
//             onTap: () {
//               if (ModalRoute.of(context)!.settings.name != '/choropleth') {
//                 Navigator.popAndPushNamed(context, '/choropleth');
//               }
//             },
//           ),
//         ]  
//       )
//     );
//   }
// }

// class NavigationDrawer extends StatelessWidget {
//   const NavigationDrawer({
//     Key? key,
//     // required this.localeProvider,
//   }) : super(key: key);

//   // final LocaleProvider localeProvider;

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: ListView(
//         children: [
//           ListTile(
//             title: Text(AppLocalizations.of(context)!.home),
//             onTap: () {
//               // If not on route
//               if (ModalRoute.of(context)!.settings.name != '/home') {
//                 Navigator.popAndPushNamed(context, '/home');
//               }
//             },
//           ),
//           ListTile(
//             title: Text(AppLocalizations.of(context)!.faq),
//             onTap: () {
//               if (ModalRoute.of(context)!.settings.name != '/faq') {
//                 Navigator.popAndPushNamed(context, '/faq');
//               }
//             },
//           ),
//           ListTile(
//             title: Text("Ward Finder"),
//             onTap: () {
//               if (ModalRoute.of(context)!.settings.name != '/finder') {
//                 Navigator.popAndPushNamed(context, '/finder');
//               }
//             },
//           ),
//           ListTile(
//             title: Text(AppLocalizations.of(context)!.menuItems),
//             onTap: () {
//               if (ModalRoute.of(context)!.settings.name != '/items') {
//                 Navigator.popAndPushNamed(context, '/items');
//               }
//             },
//           ),
//           ListTile(
//             title: Text(AppLocalizations.of(context)!.spendingCharts),
//             onTap: () {
//               if (ModalRoute.of(context)!.settings.name != '/charts') {
//                 Navigator.popAndPushNamed(context, '/charts');
//               }
//             },
//           ),
//           ListTile(
//             title: Text(AppLocalizations.of(context)!.about),
//             onTap: () {
//               if (ModalRoute.of(context)!.settings.name != '/about') {
//                 Navigator.popAndPushNamed(context, '/about');
//               }
//             },
//           ),
//            ListTile(
//             title: Text("Choropleth Map"), //need Applocalizations
//             onTap: () {
//               if (ModalRoute.of(context)!.settings.name != '/choropleth') {
//                 Navigator.popAndPushNamed(context, '/choropleth');
//               }
//             },
//           ),
//           // Row of 3 buttons for languages
//           // Row(
//           //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           //   children: [
//           //     ElevatedButton(
//           //       onPressed: () {
//           //         localeProvider.updateLocale(const Locale('en', 'US'));
//           //       },
//           //       child: const Text('English'),
//           //     ),
//           //     ElevatedButton(
//           //       onPressed: () {
//           //         localeProvider.updateLocale(const Locale('es', 'US'));
//           //       },
//           //       child: const Text('Español'),
//           //     ),
//           //     ElevatedButton(
//           //       onPressed: () {
//           //         localeProvider.updateLocale(const Locale('pl', 'US'));
//           //       },
//           //       child: const Text('Polski'),
//           //     ),
//           //   ],
//           // ),
//         ],
//       ),
//     );
//   }
// }