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
      initialRoute: '/charts',
      routes: generateRoutes(), // Use the generated routes
      home: PageWithDrawer(child: HomeScreen()),
    );
  }

  Map<String, WidgetBuilder> generateRoutes() {
    return {
      '/home': (context) => PageWithDrawer(child: HomeScreen()),
      '/faq': (context) => PageWithDrawer(child: FAQScreen()),
      '/finder': (context) => PageWithDrawer(child: WardFinderScreen()),
      '/items': (context) => PageWithDrawer(child: MenuItemsScreen()),
      '/charts': (context) => PageWithDrawer(child: ChartScreen()),
      '/about': (context) => PageWithDrawer(child: AboutScreen()),
      '/choropleth': (context) => PageWithDrawer(child: ChoroplethMapPage()),
    };
  }
}

class PageWithDrawer extends StatelessWidget {
  const PageWithDrawer({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    return Scaffold(
      drawer: ScaffoldDrawer(localeProvider: localeProvider),
      body: Center(
        child: Stack(children: [const MenuButton(), child]),
      ),
    );
  }
}

class ScaffoldDrawer extends StatelessWidget {
  const ScaffoldDrawer({
    Key? key,
    required this.localeProvider,
  }) : super(key: key);

  final LocaleProvider localeProvider;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            title: Text(AppLocalizations.of(context)!.home),
            onTap: () {
              // If not on route
              if (ModalRoute.of(context)!.settings.name != '/home') {
                Navigator.popAndPushNamed(context, '/home');
              }
            },
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.faq),
            onTap: () {
              if (ModalRoute.of(context)!.settings.name != '/faq') {
                Navigator.popAndPushNamed(context, '/faq');
              }
            },
          ),
          ListTile(
            title: Text("Ward Finder"),
            onTap: () {
              if (ModalRoute.of(context)!.settings.name != '/finder') {
                Navigator.popAndPushNamed(context, '/finder');
              }
            },
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.menuItems),
            onTap: () {
              if (ModalRoute.of(context)!.settings.name != '/items') {
                Navigator.popAndPushNamed(context, '/items');
              }
            },
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.spendingCharts),
            onTap: () {
              if (ModalRoute.of(context)!.settings.name != '/charts') {
                Navigator.popAndPushNamed(context, '/charts');
              }
            },
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.about),
            onTap: () {
              if (ModalRoute.of(context)!.settings.name != '/about') {
                Navigator.popAndPushNamed(context, '/about');
              }
            },
          ),
           ListTile(
            title: Text("Choropleth Map"), //need Applocalizations
            onTap: () {
              if (ModalRoute.of(context)!.settings.name != '/choropleth') {
                Navigator.popAndPushNamed(context, '/choropleth');
              }
            },
          ),
          // Row of 3 buttons for languages
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  localeProvider.updateLocale(const Locale('en', 'US'));
                },
                child: const Text('English'),
              ),
              ElevatedButton(
                onPressed: () {
                  localeProvider.updateLocale(const Locale('es', 'US'));
                },
                child: const Text('Español'),
              ),
              ElevatedButton(
                onPressed: () {
                  localeProvider.updateLocale(const Locale('pl', 'US'));
                },
                child: const Text('Polski'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
