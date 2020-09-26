import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gesco/models/category.dart';

class Product {

  String _documentId;
  String name;


  Product({@required this.name});

  Product.fromMap(DocumentSnapshot document){
    _documentId = document.id;



  }
}