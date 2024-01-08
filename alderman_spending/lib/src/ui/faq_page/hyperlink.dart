import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HyperLink extends StatelessWidget {
  final String displayText;
  final String link;

  HyperLink({required this.displayText, required this.link});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          _launchURL(link);
        },
        child: Text(
          displayText,
          style: const TextStyle(
            color: Colors.blue,
            decoration: TextDecoration.underline,
            decorationColor: Colors.blue,
          ),
        ),
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    final Uri _url = Uri.parse(url);

    if (await canLaunchUrl(_url)) {
      await launchUrl(_url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
