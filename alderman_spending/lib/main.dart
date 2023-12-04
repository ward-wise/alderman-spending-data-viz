import 'package:alderman_spending/src/ui/data_page/data_screen.dart';
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
    Color color = Theme.of(context).primaryColor;
    Widget buttonSection = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildButtonColumn(
            color, 'Find Your Ward', WardFinderScreen(), context),
        _buildButtonColumn(color, 'Explore Spending', DataPage(), context),
        _buildButtonColumn(
            color, 'Learn About Menu Items', MenuItemsScreen(), context),
      ],
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ward-Wise'),
      ),
      drawer: const MyNavigationDrawer(),
      body: ListView(
        children: [
          Image.asset(
            'assets/images/chicago_flag.png',
            width: 600,
            height: 240,
            fit: BoxFit.cover,
          ),
          titleSection,
          buttonSection,
          // textSection,
        ],
      ),
    );
  }

  Column _buildButtonColumn(Color color, String label, link, context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: ElevatedButton(
            child: Text(label),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[300],
              elevation: 0,
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => link));
            },
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
              '''Each year, Chicago alderpersonss get \$1.5 million in to spend on improvements in their ward. The spending is limited to "Menu Items", a list of specific projects that can be completed in each ward. Ward-Wise is intended to educate residents about these "Menu Items" and give them access to the spending history in their ward. It explains past spending in each ward and the options for future spending.
              ''',
              softWrap: true,
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
