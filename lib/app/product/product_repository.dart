import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gesco/models/product.dart';

class ProductRepository extends Disposable {
  CollectionReference _collection =
      FirebaseFirestore.instance.collection('product');

  @override
  void dispose() {}

  Stream<List<Product>> get products =>
      _collection.snapshots().map((query) => query.docs
          .map<Product>((document) => Product.fromMap(document))
          .toList());

  Stream<List<Product>> filteredProducts(String productName) =>
      _collection.snapshots().map((query) => query.docs
          .map<Product>((document) => Product.fromMap(document))
          .where((element) => element.name.contains(productName))
          .toList());

  Future<Product> getProduct(String productId) async =>
      Product.fromMap(await FirebaseFirestore.instance.doc('product/${productId}').get());
}
