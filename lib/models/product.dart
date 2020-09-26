import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gesco/models/category.dart';

class Product {

  String documentId;
  String name;


  Product({@required this.name});

  Product.fromMap(DocumentSnapshot document){
    documentId = document.id;
    name = document.data()['name'];

  }


}