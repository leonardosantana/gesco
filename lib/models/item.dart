import 'package:flutter/material.dart';

import 'product.dart';

class Item {
  Product product;
  int quantity;
  int delivered;
  double price;

  Item({@required this.product, @required this.quantity, this.price, this.delivered});

}

