import 'package:cloud_firestore/cloud_firestore.dart';

abstract class BaseModel {

  String _documentId;
  String _path;

  BaseModel();

  BaseModel.fromMap(DocumentSnapshot document);
  toMap();


  String get documentId  => _documentId;
  set documentId(String value) => _documentId = value;

  String get path  => _path;
  set path(String value) => _path = value;
}