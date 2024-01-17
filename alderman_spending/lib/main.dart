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
import 'package:alderman_spending/src/ui/menu_items_page/menu_items_screen.dart';
import 'package:alderman_spending/src/ui/choropleth_map/choropleth_map.dart';
import 'package:alderman_spending/src/ui/item_map/item_spending_map.dart';
import 'src/ui/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
                height: 110,
                fit: BoxFit.cover,
                color: Color.fromRGBO(0, 0, 0, 0.5),
                colorBlendMode: BlendMode.saturation,
              ),
              titleSection(context),
              buttonSection(context),
              // bodySection(context),
              Container(
                height: 220,
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                color: Colors.white,
              ),
              bottomBar(context),
            ],
          ),
        ),
      ),
    );
  }
}

final String assetName = 'assets/imagages/ward-wise-logo.svg';
final Widget svg = SvgPicture.asset(assetName, semanticsLabel: 'Logo');

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
                  'Ward Wise',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
              SizedBox(height: 20),
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

Widget bodySection(context) {
  final isNarrowScreen = MediaQuery.of(context).size.width < 800;

  return Expanded(
      child: isNarrowScreen
          ? Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'What is a ward?',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 20, 50, 20),
                  child: Text.rich(
                    TextSpan(children: [
                      const TextSpan(
                          text:
                              "Chicago is divided fifty legislative districts called \"wards\". Each ward contains roughly 50,000 redidents and elects an alderman to represent their interests on the city council. Don't know which ward you live in? Check out our "),
                      TextSpan(
                          text: "ward finder",
                          style: const TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(context, '/find-my-ward');
                            }),
                      const TextSpan(text: "."),
                    ]),
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    '\$1.5 Million/year in spending',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 20, 30, 20),
                  child: Text.rich(
                    TextSpan(children: [
                      const TextSpan(
                          text:
                              'Each year Chicago provides aldermen with \$1.5 million to spend on infrustructure improvements in their ward. The money must be spent on specific improvements approved by the city, known as menu items. Menu items include things like street resurfacing, bike lines, and street lights. Learn more about menu items '),
                      TextSpan(
                          text: 'here',
                          style: const TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(context, '/menu-items');
                            }),
                      const TextSpan(text: '.'),
                    ]),
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 0, 30, 0),
                  child: Text(
                    'What is Ward Wise?',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 20, 50, 20),
                  child: Text.rich(
                    TextSpan(children: [
                      const TextSpan(
                          text:
                              "Ward Wise is a group of civic technologists who want to keep aldermen accountable and educate Chicago residents on how money is spent in their ward. We've collected more than 10 years of ward spending. On this site you can find a break down of "),
                      TextSpan(
                          text: 'spending in your ward',
                          style: const TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(context, '/ward-spending');
                            }),
                      const TextSpan(text: ", a summary of "),
                      TextSpan(
                          text: 'spending across the city',
                          style: const TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const ChoroplethMapPage(),
                              ));
                            }),
                      const TextSpan(text: ", and a detailed "),
                      TextSpan(
                          text: 'map',
                          style: const TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ItemSpendingiFrame(),
                              ));
                            }),
                      const TextSpan(
                          text:
                              " of each spending item's location and cost. Want to learn more? Check out our "),
                      TextSpan(
                          text: 'FAQ',
                          style: const TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(context, '/faqs');
                            }),
                      const TextSpan(text: ".")
                    ]),
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ],
            )
          : Column(
              children: [
                Flex(direction: Axis.horizontal, children: [
                  Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          'What is a ward?',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      )),
                  Expanded(
                    flex: 1,
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 50, 10),
                        child: Text.rich(
                          TextSpan(children: [
                            const TextSpan(
                                text:
                                    "Chicago is divided fifty legislative districts called \"wards\". Each ward contains roughly 50,000 redidents and elects an alderman to represent their interests on the city council. Don't know which ward you live in? Check out our "),
                            TextSpan(
                                text: "ward finder",
                                style: const TextStyle(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushNamed(
                                        context, '/find-my-ward');
                                  }),
                            const TextSpan(text: "."),
                          ]),
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.bodyLarge,
                        )),
                  ),
                ]),
                Flex(direction: Axis.horizontal, children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(50, 10, 30, 10),
                        child: Text.rich(
                          TextSpan(children: [
                            const TextSpan(
                                text:
                                    'Each year Chicago provides aldermen with \$1.5 million to spend on infrustructure improvements in their ward. The money must be spent on specific improvements approved by the city, known as menu items. Menu items include things like street resurfacing, bike lines, and street lights. Learn more about menu items '),
                            TextSpan(
                                text: 'here',
                                style: const TextStyle(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushNamed(context, '/menu-items');
                                  }),
                            const TextSpan(text: '.'),
                          ]),
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.bodyLarge,
                        )),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          '\$1.5 Million/year in spending',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineSmall,
                        )),
                  ),
                ]),
                Flex(direction: Axis.horizontal, children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(50, 0, 30, 0),
                        child: Text(
                          'What is Ward Wise?',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineSmall,
                        )),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 50, 20),
                        child: Text.rich(
                          TextSpan(children: [
                            const TextSpan(
                                text:
                                    "Ward Wise is a group of civic technologists who want to keep aldermen accountable and educate Chicago residents on how money is spent in their wards. We've collected more than 10 years of ward spending. On this site you can find a break down of "),
                            TextSpan(
                                text: 'spending in your ward',
                                style: const TextStyle(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushNamed(
                                        context, '/ward-spending');
                                  }),
                            const TextSpan(text: ", a summary of "),
                            TextSpan(
                                text: 'spending across the city',
                                style: const TextStyle(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) =>
                                          const ChoroplethMapPage(),
                                    ));
                                  }),
                            const TextSpan(text: ", and a detailed "),
                            TextSpan(
                                text: 'map',
                                style: const TextStyle(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) =>
                                          ItemSpendingiFrame(),
                                    ));
                                  }),
                            const TextSpan(
                                text:
                                    " of each spending item's location and cost. Want to learn more? Check out our "),
                            TextSpan(
                                text: 'FAQ',
                                style: const TextStyle(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushNamed(context, '/faqs');
                                  }),
                            const TextSpan(text: "."),
                          ]),
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.bodyLarge,
                        )),
                  ),
                ]),
              ],
            ));
}

Widget bottomBar(context) {
  return Container(
    height: 50,
    color: Colors.grey[300],
    child: Row(
      children: [
        Flexible(
          child: Center(
            child: Text.rich(
              TextSpan(
                  text: 'Chi Hack Night',
                  style: const TextStyle(
                    color: Colors.black,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async {
                      if (await canLaunchUrl(
                          Uri.parse('https://chihacknight.org/'))) {
                        await launchUrl(Uri.parse('https://chihacknight.org/'));
                      } else {
                        throw 'Could load Chi Hack Night';
                      }
                    }),
            ),
          ),
        ),
        Flexible(
          child: Center(
            child: Text.rich(
              TextSpan(
                  text: 'Github',
                  style: const TextStyle(
                    color: Colors.black,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async {
                      if (await canLaunchUrl(Uri.parse(
                          'https://github.com/chihacknight/breakout-groups/issues/224'))) {
                        await launchUrl(Uri.parse(
                            'https://github.com/chihacknight/breakout-groups/issues/224'));
                      } else {
                        throw 'Could not load github';
                      }
                    }),
            ),
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
