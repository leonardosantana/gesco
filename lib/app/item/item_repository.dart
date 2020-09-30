import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gesco/models/item.dart';

class ItemRepository extends Disposable {
  @override
  void dispose() {
    // TODO: implement dispose
  }

  Future<Item> getItem(String buildId,String orderId,String itemId) async =>
      Item.fromMap(await FirebaseFirestore.instance.doc('build/${buildId}/orders/${orderId}/items/${itemId}').get());
}
