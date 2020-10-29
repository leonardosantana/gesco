import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gesco/shared/base_model.dart';

class UserModel extends BaseModel {
  String login;
  bool isAdmin;

  UserModel({this.login, this.isAdmin});

  UserModel.fromMap(DocumentSnapshot document) {
    documentId = document.id;

    this.login = document.data()["login"];
    this.isAdmin = document.data()["isAdmin"];
  }

  @override
  toMap() {
    var map = new Map<String, dynamic>();

    map['login'] = this.login;
    map['isAdmin'] = this.isAdmin;

    return map;
  }
}
