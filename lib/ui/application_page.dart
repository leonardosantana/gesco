
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gesco/getx_app/home_page/home_page.dart';
import 'package:gesco/ui/my_home_page.dart';

import 'menu_page.dart';

class ApplicationPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: HomePage()/*Stack(
        children: <Widget>[
          MenuPage(),
          MyHomePage(),
        ],
      ),*/
    );
  }
}

