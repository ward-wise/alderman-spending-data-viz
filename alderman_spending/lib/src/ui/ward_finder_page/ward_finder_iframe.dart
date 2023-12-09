import 'dart:html';
import 'dart:ui_web' as uiWeb;
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/material.dart';
import 'package:alderman_spending/src/ui/navigation/navigation_drawer.dart';

class WardFinderiFrame extends StatefulWidget {

  @override
  State<WardFinderiFrame> createState() => _WardFinderiFrameState();
}

class _WardFinderiFrameState extends State<WardFinderiFrame> {
  final IFrameElement _iFrameElement = IFrameElement();

  @override
  void initState() {
    _iFrameElement.style.height = '100%';
    _iFrameElement.style.width = '100%';
    _iFrameElement.src = 'https://gisapps.chicago.gov/WardGeocode/';
    _iFrameElement.style.border = 'none';

    uiWeb.platformViewRegistry.registerViewFactory(
      'iframeElement', 
      (int viewID) => _iFrameElement,
    );
    
    super.initState();
  }
  
  final Widget _iFrameWidget = HtmlElementView(
    viewType: 'iframeElement', 
    key: UniqueKey(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyNavigationDrawer(),
      appBar: AppBar(title: const Text('Ward Finder'),),
      body: Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                'Find your ward number and alderman information',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 600,
              width: 500,
              child: _iFrameWidget,
            ),
            Text.rich(
              TextSpan(
                text: 'Source: ',
                children: [
                  TextSpan(
                    text: 'https://gisapps.chicago.gov/WardGeocode/',
                    style: TextStyle(color: Colors.blue),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        if (await canLaunchUrl(Uri.parse('https://gisapps.chicago.gov/WardGeocode/'))) {
                          await launchUrl(Uri.parse('https://gisapps.chicago.gov/WardGeocode/'));
                        } else {
                          throw 'Could not launch https://gisapps.chicago.gov/WardGeocode/';
                        }
                      }
                  ),
    ]
  ) 
)
          ],),
      )
    );
  }
}