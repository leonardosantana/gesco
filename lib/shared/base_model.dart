import 'package:cloud_firestore/cloud_firestore.dart';

abstract class BaseModel {

  String _documentId;

  BaseModel();

  BaseModel.fromMap(DocumentSnapshot document);
  toMap();


  String get documentId  => _documentId;
  set documentId(String value) => _documentId = value;
}