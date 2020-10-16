import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gesco/shared/base_model.dart';

import 'category.dart';
import 'item.dart';

class Order extends BaseModel {

  Color color;
  String category;
  Category categoryObj;
  int status;
  String buildName;
  int quantity;
  double cust;
  bool modified;
  int orderNumber;
  List<Item> items;

  Order(
      {@required this.color,
      @required this.category,
      @required this.status,
      @required this.quantity,
      @required this.cust,
      @required this.items,
      this.orderNumber}) {
    this.modified = false;
  }

  @override
  toMap() {
    var map = new Map<String, dynamic>();

    map['category'] = this.category;
    map['status'] = this.status;
    map['quantity'] = this.quantity;
    map['cust'] = this.cust;
    map['modified'] = this.modified;
    map['orderNumber'] = this.orderNumber;

    return map;
  }


  @override
  Order.fromMap(DocumentSnapshot document) {
    documentId = document.id;

    var dataMap = document.data();

    this.cust = dataMap["cust"];
    this.category = dataMap["category"];
    this.color = Colors.red; //document.data()["color"];
    this.status = dataMap["status"];
    this.quantity = dataMap["quantity"];
    this.cust = dataMap["cust"];
    this.modified = dataMap["modified"];
    this.items = dataMap["items"];
    this.orderNumber = dataMap["orderNumber"];
  }
}
