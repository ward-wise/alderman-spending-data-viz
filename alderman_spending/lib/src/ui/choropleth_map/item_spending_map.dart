import 'dart:html';
import 'dart:ui_web' as uiWeb;
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/material.dart';
import 'package:alderman_spending/src/ui/navigation/navigation_drawer.dart';

class ItemSpendingiFrame extends StatefulWidget {

  @override
  State<ItemSpendingiFrame> createState() => _WardFinderiFrameState();
}

class _WardFinderiFrameState extends State<ItemSpendingiFrame> {
  final IFrameElement _iFrameElementmap = IFrameElement();

  @override
  void initState() {
    _iFrameElementmap.style.height = '100%';
    _iFrameElementmap.style.width = '100%';
    _iFrameElementmap.src = 'https://clairehemmerly.maps.arcgis.com/apps/mapviewer/index.html?webmap=ea6ad41bea3c48588ee25200a9c995f3';
    _iFrameElementmap.style.border = 'none';

    uiWeb.platformViewRegistry.registerViewFactory(
      'iframeElementmap', 
      (int viewIDmap) => _iFrameElementmap,
    );
    
    super.initState();
  }
  
  final Widget _iFrameWidgetmap = HtmlElementView(
    viewType: 'iframeElementmap', 
    key: UniqueKey(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyNavigationDrawer(),
      appBar: AppBar(title: const Text('Item Spending'),),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 700,
              width: 1000,
              child: _iFrameWidgetmap,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Go to full page view',
                      style: TextStyle(color: Colors.blue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          if (await canLaunchUrl(Uri.parse('https://clairehemmerly.maps.arcgis.com/apps/mapviewer/index.html?webmap=ea6ad41bea3c48588ee25200a9c995f3'))) {
                            await launchUrl(Uri.parse('https://clairehemmerly.maps.arcgis.com/apps/mapviewer/index.html?webmap=ea6ad41bea3c48588ee25200a9c995f3'));
                          } else {
                            throw 'Could not launch full page view';
                          }
                        }
                    ),
                ]
              ) 
            ),
            )
          ],),
      )
    );
  }
}