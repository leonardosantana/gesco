import 'package:flutter/material.dart';

class Build {
  String name;
  double cust;
  double progress;
  String phase;
  String buildImage;
  Color color;

  Build(
      {@required this.name,
        @required this.cust,
        @required this.progress,
        @required this.phase,
        @required this.buildImage,
        @required this.color});
}