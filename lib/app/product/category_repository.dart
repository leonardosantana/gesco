import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gesco/models/category.dart';
import 'package:gesco/models/product.dart';

class CategoryRepository extends Disposable {
  CollectionReference _collection =
      FirebaseFirestore.instance.collection('product_category');

  @override
  void dispose() {}

  get categories => _collection.snapshots().map((query) => query.docs
      .map<Category>((document) => (Category.fromMap(document)))
      .toList());

  products(String categoryId) => _collection
      .doc(categoryId)
      .collection('products')
      .snapshots()
      .map((query) => query.docs
          .map<Product>((document) => (Product.fromMap(document)))
          .toList());

  Future<Product> getProduct(String category, String productId) async =>
      Product.fromMap(await _collection
          .doc(category)
          .collection('products')
          .doc(productId)
          .get());
}
