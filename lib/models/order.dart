import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'item.dart';

class Order {
  String _documentId;

  Color color;
  String category;
  String status;
  int quantity;
  double cust;
  bool modified;
  List<Item> items;

  Order(
      {@required this.color,
      @required this.category,
      @required this.status,
      @required this.quantity,
      @required this.cust,
      @required this.items}) {
    this.modified = false;
  }

  toMap() {
    var map = new Map<String, dynamic>();

    map['category'] = this.category;
    map['status'] = this.status;
    map['quantity'] = this.quantity;
    map['cust'] = this.cust;
    map['modified'] = this.modified;

    return map;
  }

  Order.fromMap(DocumentSnapshot document) {
    _documentId = document.id;

    this.cust = document.data()["cust"];
    this.color = Colors.red; //document.data()["color"];
    this.status = document.data()["status"];
    this.quantity = document.data()["quantity"];
    this.cust = document.data()["cust"];
    this.modified = document.data()["modified"];
    this.items = document.data()["items"];
  }
}
