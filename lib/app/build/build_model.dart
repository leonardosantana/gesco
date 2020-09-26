import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gesco/models/order.dart';
import 'package:gesco/shared/base_model.dart';

class Build extends BaseModel{

  String _documentId;

  String owner;
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
  bool orderNeedsAproval;
  List<Order> orders;
  String buildImage;

  Build();

  @override
  String documentId() => _documentId;

  Build.fromMap(DocumentSnapshot document) {
    _documentId = document.id;

    this.owner = document.data()["owner"];
    this.name = document.data()["name"];
    this.builder = document.data()["builder"];
    this.engineer = document.data()["engineer"];
    this.address = document.data()["address"];
    this.zipCode = document.data()["zipCode"];
    this.buildSize = document.data()["buildSize"];
    this.buildImage = document.data()["buildImage"];
    this.cust = document.data()["cust"];
    this.progress = document.data()["progress"];
    this.phase = document.data()["phase"];
    this.orderNeedsAproval = document.data()["orderNeedsAproval"];
    this.color = Colors.red; //document.data()["color"];
  }

  @override
  toMap() {

    var map = new Map<String, dynamic>();

    map['owner'] = this.owner;
    map['buildImage'] = this.buildImage;
    map['name'] = this.name;
    map['builder'] = this.builder;
    map['engineer'] = this.engineer;
    map['address'] = this.address;
    map['zipCode'] = this.zipCode;
    map['buildSize'] = this.buildSize;
    map['cust'] = this.cust;
    map['progress'] = this.progress;
    map['phase'] = this.phase;
    map['orderNeedsAproval'] = this.orderNeedsAproval;
    map['orders'] = this.orders;

    return map;

  }
}