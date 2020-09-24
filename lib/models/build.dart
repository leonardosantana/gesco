import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gesco/models/order.dart';
import 'package:gesco/models/user.dart';
import 'package:gesco/shared/base_model.dart';

class Build extends BaseModel{

  String _documentId;

  String name;
  String builder;
  String engineer;
  String address;
  String zipCode;
  double buildSize;
  Color color;
  double progress;
  double cust;
  String phase;
  List<Order> orders;
  String buildImage;

  Build();

  @override
  String documentId() => _documentId;

  Build.fromMap(DocumentSnapshot document){
    _documentId = document.id;

    this.name = document.data()["name"];
    this.builder = document.data()["builder"];
    this.engineer = document.data()["engineer"];
    this.address = document.data()["address"];
    this.zipCode = document.data()["zipCode"];
    this.buildSize = document.data()["buildSize"];

    }

  @override
  toMap() {

    var map = new Map<String, dynamic>();

    map['name'] = this.name;
    map['builder'] = this.builder;
    map['engineer'] = this.engineer;
    map['address'] = this.address;
    map['zipCode'] = this.zipCode;
    map['buildSize'] = this.buildSize;

    return map;

  }
}