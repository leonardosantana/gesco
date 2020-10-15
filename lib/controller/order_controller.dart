import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gesco/getx_app/order/order_status_enum.dart';
import 'package:gesco/models/item.dart';
import 'package:gesco/models/product.dart';
import 'package:gesco/models/order.dart';

class OrderController {
  static List<Item> _itens = [
    Item(
        product: Product(name: 'Cano 20mm Barra 6m'),
        quantity: 2,
        price: 16.0),
    Item(
        product: Product(name: 'Cano 50mm Barra 6m'),
        quantity: 4,
        price: 18.0),
    Item(
        product: Product(name: 'Joelho 20mm peça'),
        quantity: 10,
        price: .50)
  ];

  static List<Item> _itensDelivered = [
    Item(
        product: Product(name: 'Cano 20mm Barra 6m'),
        quantity: 2,
        delivered: 2,
        price: 16.0),
    Item(
        product: Product(name: 'Cano 50mm Barra 6m'),
        quantity: 4,
        delivered: 4,
        price: 18.0),
    Item(
        product: Product(name: 'Joelho 20mm und'),
        quantity: 10,
        delivered: 8,
        price: .50)
  ];

  static List<Order> _orders = [
  ];

  static List<Order> getOrders() => _orders;


}
