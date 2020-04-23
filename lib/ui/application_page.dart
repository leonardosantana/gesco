
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gesco/ui/my_home_page.dart';

import 'menu_page.dart';

class ApplicationPage extends StatefulWidget {
  @override
  _ApplicationPageState createState() => _ApplicationPageState();
}

class _ApplicationPageState extends State<ApplicationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: <Widget>[
          MenuPage(),
          MyHomePage(),
        ],
      ),
    );
  }
}

