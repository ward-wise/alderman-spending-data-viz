import 'dart:io';

import 'package:alderman_spending/src/ui/data_page/data_screen.dart';
import 'package:alderman_spending/src/ui/menu_items_page/menu_items_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';

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
    return Center(
      child: SizedBox(
        width: 1020,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Ward Wise'),
          ),
          drawer: const MyNavigationDrawer(),
          body: ListView(
            children: [
              Image.asset(
                'assets/images/wards.png',
                // width: 800,
                height: 220,
                fit: BoxFit.cover,
                color: Color.fromRGBO(0, 0, 0, 0.5),
                colorBlendMode: BlendMode.saturation,
              ),
              titleSection(context),
              buttonSection(context),
              bodySection(context),
              Container(
                height: 30,
                padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                color: Colors.white,
              ),
              Container(
                height: 50,
                padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                color: Colors.grey[300],
                child: Text(
                    "Links\nChi Hack Night\ngithub"
                ),
              ),
            ],
          ),
        ),
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
                  'Welcome to Ward Wise Chicago!',
                  style: Theme.of(context).textTheme.headlineLarge, 
                ),
              ),
              Text(
                'Keeping government spending accountable.',
                style: Theme.of(context).textTheme.headlineMedium,  
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget bodySection(context) {
    return GridView.count(
      shrinkWrap: true, 
      crossAxisCount: MediaQuery.of(context).size.width < 800 ? 1 : 2,
      childAspectRatio: 3,
      children: [
        Container(
          alignment: Alignment.center,
          child: Text(
            'What is a ward?',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 50, 0),
            child: Text.rich(
              TextSpan(children: [
                const TextSpan(
                  text: "Chicago is divided fifty legislative districts called \"wards\". Each ward contains roughly 50,000 redidents and elects an alderman to represent their interests on the city council. Don't know which ward you live in? Check out our ",
                 ),
                 TextSpan(
                  text: "ward finder.",
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.pushNamed(context, '/ward-spending');
                     },
                 ),
              ]),
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ),      
        Container(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(50, 0, 30, 0),
            child: Text(
              'Each year Chicago provides aldermen with \$1.5 million to spend on infrustructure improvements in their ward. The money must be spent on specific improvements approved by the city, known as menu items. Menu items include things like street resurfacing, bike lines, and street lights. Learn more.',
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.bodyLarge,  
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: Text(
            '\$1.5 Million/year \nin spending',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(50, 0, 30, 0),
            child: Text(
              'What is Ward Wise?',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall,  
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 50, 0),
            child: Text(
              "Ward Wise is a group of civic technologists who want to keep aldermen accountable and educate Chicago residents on how money is spent in their wards. We've collected more than 10 years of ward spending. On this site you can find a break down of spending in you ward, a summary of spending across the city, and a detailed map of each spending item's location and cost. Want to learn more? Check out our FAQ.",
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ),
      ],
    );
  }


Widget buttonSection(context) {
  Color color = Theme.of(context).primaryColor;
  var children = [
    _buildButtonColumn(color, 'Find My Ward', '/find-my-ward', context),
    _buildButtonColumn(color, 'Explore Spending', '/ward-spending', context),
    _buildButtonColumn(color, 'Learn About Menu Items', '/menu-items', context),
    _buildButtonColumn(color, 'Read FAQs', '/faqs', context),
  ];

  return LayoutBuilder(
    builder: (BuildContext context, BoxConstraints constraints) {
      if (MediaQuery.of(context).size.width < 800) {
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
    int ward = 1;
    try {
      ward = int.parse(queryParameters?['ward'] ?? '1');
    } catch (e) {
      ward = 1;
    }
    if (ward > 50 || ward < 1) {
      ward = 1;
    }
    int year = 2023;
    try {
      year = int.parse(queryParameters?['year'] ?? '2023');
    } catch (e) {
      year = 2023;
    }
    if (year > 2023 || year < 2012) {
      year = 2023;
    }
    // var message =
    //     'generateRoute: Route $route, QueryParameters $queryParameters';
    // print(message);

    // route mapping
    final Map<String, WidgetBuilder> routes = {
      '/': (context) => const HomeScreen(),
      '/find-my-ward': (context) => const WardFinderScreen(),
      // TODO refactor to use query parameters, turn DataPage into a stful widget
      '/ward-spending': (context) {
        return DataPage(
          // pass query parameters
          initialWard: ward,
          initialYear: year,
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
