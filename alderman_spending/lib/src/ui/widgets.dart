import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({super.key});

  @override
  FloatingActionButton build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Scaffold.of(context).openDrawer();
      },
      shape: const ContinuousRectangleBorder(),
      elevation: 0,
      focusElevation: 0,
      highlightElevation: 0,
      hoverElevation: 0,
      foregroundColor: Colors.black,
      backgroundColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: const Icon(Icons.menu),
    );
  }
}
