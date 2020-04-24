import 'package:flutter/material.dart';
import 'package:gesco/models/order.dart';
import 'package:gesco/models/user.dart';

class Build {
  String name;
  double cust;
  double progress;
  String phase;
  String buildImage;
  Color color;
  User constructor;
  User owner;
  List<User> buyer;
  List<User> engineer;
  List<Order> orders;

  Build(
      {@required this.name,
        @required this.cust,
        @required this.progress,
        @required this.phase,
        @required this.buildImage,
        @required this.color,
        @required this.owner,
        @required this.buyer,
        @required this.engineer,
        @required this.constructor,
        this.orders
      });
}