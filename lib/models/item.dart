import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'product.dart';

class Item {
  String _documentId;

  Product product;
  int quantity;
  int delivered;
  double price;

  Item({@required this.product, @required this.quantity, this.price, this.delivered});

  toMap() {

    var map = new Map<String, dynamic>();

    map['product'] = this.product.documentId;
    map['quantity'] = this.quantity;
    map['delivered'] = this.delivered;
    map['price'] = this.price;

    return map;

  }

  Item.fromMap(DocumentSnapshot document) {
    _documentId = document.id;

    //this.product = document.data()["product"];
    this.quantity = document.data()["quantity"];
    this.delivered = document.data()["delivered"];
    this.price = document.data()["price"];

  }

}

