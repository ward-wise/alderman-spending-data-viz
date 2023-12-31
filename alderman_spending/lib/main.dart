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
import 'package:alderman_spending/src/ui/category_map_page/category_map_screen.dart';
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
      title: "Ward Wise - Aldermanic spending on neighborhood infrastructure",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ward Wise'),
      ),
      drawer: const MyNavigationDrawer(),
      body: ListView(
        children: [
          //   Image.asset(
          //   'assets/images/chicago_flag.png',
          //   width: 600,
          //   height: 240,
          //   fit: BoxFit.cover,
          // ),
          titleSection(context),
          buttonSection(context),
        ],
      ),
    );
  }
}

Widget titleSection(context) {
  return Container(
    padding: const EdgeInsets.all(32),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  'Welcome to Ward Wise!',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                  '''Each year, Chicago alders get \$1.5 million in "menu money" to spend at their discretion on neighborhood infrastructure in their ward. Use this tool to learn about the process, view past spending, and reach out to your alder.
              ''',
                  softWrap: true, style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buttonSection(context) {
  Color color = Theme.of(context).primaryColor;
  var children = [
    _buildButtonColumn(color, 'Find My Ward', '/find-my-ward', context),
    _buildButtonColumn(color, 'Explore Spending', '/ward-spending', context),
    _buildButtonColumn(color, 'Learn About Menu Items', '/menu-items', context),
  ];

  return LayoutBuilder(
    builder: (BuildContext context, BoxConstraints constraints) {
      if (MediaQuery.of(context).size.width < 600) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: children,
        );
      }
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: children,
      );
    },
  );
}

Column _buildButtonColumn(Color color, String label, String route, context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        padding: const EdgeInsets.all(20),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue[300],
            elevation: 0,
            padding: const EdgeInsets.all(25),
          ),
          child: Text(
            label,
            style: Theme.of(context).textTheme.labelLarge,
          ),
          onPressed: () {
            Navigator.pushNamed(context, route);
          },
        ),
      ),
    ],
  );
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    String? route;
    Map? queryParameters;
    if (settings.name != null) {
      var uriData = Uri.parse(settings.name!);
      route = uriData.path;
      queryParameters = uriData.queryParameters;
    }

    // var message =
    //     'generateRoute: Route $route, QueryParameters $queryParameters';
    // print(message);

    // route mapping
    final Map<String, WidgetBuilder> routes = {
      '/': (context) => const HomeScreen(),
      '/find-my-ward': (context) => const WardFinderScreen(),
      '/ward-spending': (context) {
        return DataPage(
          // pass query parameters
          initialWard: int.parse(queryParameters?['ward'] ?? '1'),
          initialYear: int.parse(queryParameters?['year'] ?? '2023'),
        );
      },
      '/category-map': (context) => const CategoryMapPage(),
      '/menu-items': (context) => const MenuItemsScreen(),
      '/faqs': (context) => const FAQScreen(),
      '/about': (context) => const AboutScreen(),
    };

    final WidgetBuilder builder =
        routes[route] ?? ((context) => const HomeScreen());

    return MaterialPageRoute(
      builder: builder,
      settings: settings,
    );
  }
}
