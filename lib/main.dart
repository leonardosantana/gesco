import 'package:flutter/material.dart';
import 'package:gesco/app/build/new_build/new_build_page.dart';
import 'package:gesco/ui/application_page.dart';
import 'package:gesco/ui/login_page.dart';
import 'ui/my_home_page.dart';

void main() => runApp(Gesco());

class Gesco extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gesco',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NewBuildPage(),
    );
  }
}