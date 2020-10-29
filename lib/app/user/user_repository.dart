import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gesco/getx_app/user/user_model.dart';

class UserRepository {
  static var usersCollectionPath = 'user';

  CollectionReference _collection =
      FirebaseFirestore.instance.collection(usersCollectionPath);

  Future<bool> get isadmin async {
    bool result = false;
    String login = FirebaseAuth.instance.currentUser.email;
    QuerySnapshot snapshot =
        await _collection.where('login', isEqualTo: login).get();
    snapshot.docs.forEach((element) {
      result = UserModel.fromMap(element).isAdmin;
    });
    return result;
  }

  Future clearPersistence() async {
    await FirebaseFirestore.instance.clearPersistence();
  }

  Future<List<UserModel>> getUsers() async {

    List<UserModel> list = List();

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("user")
        .get();
    querySnapshot.docs.forEach((element) => list.add(UserModel.fromMap(element)) );

    return list;

  }

  @override
  void dispose() {
    // TODO: implement dispose
  }

  void addUser(UserModel user) {
    _collection.add(user.toMap());
  }
}
