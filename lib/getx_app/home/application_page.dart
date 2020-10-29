
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gesco/getx_app/home/home_page.dart';
import 'package:gesco/ui/my_home_page.dart';

import '../menu/menu_page.dart';

class ApplicationPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: <Widget>[
          MenuPage(),
          HomePage(),
        ],
      ),
    );
  }
}

