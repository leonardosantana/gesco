import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gesco/models/build.dart';
import 'package:rxdart/rxdart.dart';

class BuildRepository extends Disposable {

  CollectionReference _collection = FirebaseFirestore.instance.collection('build');

  void add(Build build) => _collection.add(build.toMap());

  void update(String documentId, Build build) =>
      _collection.doc(documentId).update(build.toMap());

  void delete(String documentId) => _collection.doc(documentId).delete();

  Stream<List<Build>> get builds =>
      _collection.snapshots().map((query) => query.docs
          .map<Build>((document) => Build.fromMap(document))
          .toList()).asBroadcastStream();

  @override
  void dispose() {}
}
