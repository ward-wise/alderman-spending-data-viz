import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'src/data/providers/selected_data.dart';
import 'src/data/providers/selected_locale.dart';
import 'src/ui/about_page/about_screen.dart';
import 'src/ui/chart_page/chart_screen.dart';
import 'src/ui/faq_page/faq_screen.dart';
import 'src/ui/home_screen/home_screen.dart';
import 'src/ui/widgets.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SelectedData()),
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
      '/charts': (context) => PageWithDrawer(child: ChartScreen()),
      '/about': (context) => PageWithDrawer(child: AboutScreen()),
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
              Navigator.popAndPushNamed(context, '/home');
            },
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.faq),
            onTap: () {
              Navigator.popAndPushNamed(context, '/faq');
            },
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.spendingCharts),
            onTap: () {
              Navigator.popAndPushNamed(context, '/charts');
            },
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.about),
            onTap: () {
              Navigator.popAndPushNamed(context, '/about');
            },
          ),
          // Switch which toggles between en and es
          SwitchListTile(
            title: const Text("English / Español"),
            value: localeProvider.currentLocale.languageCode == 'es',
            onChanged: (value) {
              if (value) {
                localeProvider.updateLocale(const Locale('es', 'US'));
              } else {
                localeProvider.updateLocale(const Locale('en', 'US'));
              }
            },
            activeThumbImage: const AssetImage('assets/images/mexico.png'),
            inactiveThumbImage: const AssetImage('assets/images/usa.png'),
          ),
        ],
      ),
    );
  }
}
