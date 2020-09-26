import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gesco/models/product.dart';

class ProductRepository extends Disposable{

  CollectionReference _collection = FirebaseFirestore.instance.collection('products');

  @override
  void dispose() {}

  Stream<List<Product>> get products => _collection
      .snapshots().map((query) => query.docs
      .map<Product>((document) => Product.fromMap(document))
      .toList());


}