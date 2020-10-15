import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:gesco/models/product.dart';
import 'package:gesco/shared/base_model.dart';

class Subcategory extends BaseModel{

  String name;

  Product products;


  Subcategory({ @required this.name, this.products});

  @override
  toMap() {
    // TODO: implement toMap
    throw UnimplementedError();
  }

  @override
  Subcategory.fromMap(DocumentSnapshot document){

    documentId = document.id;
    name = document.data()['name'];

  }

}