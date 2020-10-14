
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gesco/models/Subcategory.dart';
import 'package:gesco/models/product.dart';
import 'package:gesco/shared/base_model.dart';

class Category extends BaseModel{
  String _documentId;

  String name;

  List<Product> _products;

  Category({@required this.name});

  @override
  String documentId() => _documentId;

  List<Product> get products => _products;
  set products(List<Product> products) => this.products = products;


  @override
  toMap() {
    // TODO: implement toMap
    throw UnimplementedError();
  }

  @override
  Category.fromMap(DocumentSnapshot document){
    _documentId = document.id;
    this.name = document['name'];

  }

}