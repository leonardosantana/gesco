import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'build_model.dart';

class BuildRepository extends Disposable {

  User _user = FirebaseAuth.instance.currentUser;


  CollectionReference _collection = FirebaseFirestore.instance.collection(
      'build');

  Future add(Build build) {
    _collection.add(build.toMap()).then((value) {
      print("User Added");
    }).catchError((error) {
      print("Failed to add user: $error");
    });
  }

  void update(String documentId, Build build) =>
      _collection.doc(documentId).update(build.toMap());

  void delete(String documentId) => _collection.doc(documentId).delete();

  Stream<List<Build>> get builds =>
      _collection.where('owner', isEqualTo: _user.email)
          .snapshots().map((query) => query.docs
          .map<Build>((document) => Build.fromMap(document))
          .toList());

  @override
  void dispose() {}
}
