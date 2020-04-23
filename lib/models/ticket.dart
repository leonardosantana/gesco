import 'package:flutter/material.dart';

import 'item.dart';

class Ticket {
  Color color;
  String category;
  String buildName;
  String status;
  int quantity;
  double cust;
  List<Item> itens;

  Ticket(
      {@required this.color,
      @required this.category,
      @required this.buildName,
      @required this.status,
      @required this.quantity,
      @required this.cust,
      @required this.itens});
}

