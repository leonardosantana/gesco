import 'package:flutter/material.dart';

import 'item.dart';

class Order {
  int id;
  Color color;
  String category;
  String buildName;
  String status;
  int quantity;
  double cust;
  bool modified;
  List<Item> items;

  Order(
      {@required this.id,
      @required this.color,
      @required this.category,
      @required this.buildName,
      @required this.status,
      @required this.quantity,
      @required this.cust,
      @required this.items}){
    this.modified = false;
  }
}
