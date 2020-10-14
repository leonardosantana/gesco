import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gesco/models/item.dart';
import 'package:gesco/models/order.dart';

import '../../getx_app/build/build_model.dart';

class BuildRepository extends Disposable {
  User _user = FirebaseAuth.instance.currentUser;
  String _buildId;

  CollectionReference _collection =
      FirebaseFirestore.instance.collection('build');

  Future add(Build build) {
    _collection.add(build.toMap()).then((value) {
      print("User Added");
    }).catchError((error) {
      print("Failed to add user: $error");
    });
  }

  void update(String documentId, Build build) =>
      _collection.doc(documentId).update(build.toMap());

  void updateOrder(String buildId, Order order) {
    _collection.doc(buildId).collection('orders').doc(order.documentId()).update(order.toMap());

    order.items.where((element) => element.getId() == null).forEach((element) {
      _collection.doc(buildId).collection('orders').doc(order.documentId()).collection('items').add(element.toMap());
    });


  }

  Future addOrder(String documentId, Order order) => _collection
          .doc(documentId)
          .collection('orders')
          .add(order.toMap())
          .then((value) {
        order.items.forEach((element) {
          value
              .collection('items')
              .add(element.toMap())
              .then((value) => print('sucess'))
              .catchError((error) {
            print("Failed to add item: $error");
          });
        });
      }).catchError((error) {
        print("Failed to add order: $error");
      });

  void delete(String documentId) => _collection.doc(documentId).delete();

  Stream<List<Build>> get builds => _collection
      .where('owner', isEqualTo: _user.email)
      .snapshots()
      .map((query) => query.docs.map<Build>((document) {
            Build build = Build.fromMap(document);
            getOrders(document.id).listen((event) => build.orders = event);
            return build;
          }).toList());

  @override
  void dispose() {}

  Stream<List<Order>> getOrders(String id) {
    this._buildId = id;
    return _collection
        .doc(id)
        .collection('orders')
        .snapshots()
        .map((query) => query.docs.map<Order>((document) {
              Order order = Order.fromMap(document);
              getItems(document)
                  .listen((eventResult) => order.items = eventResult);
              return order;
            }).toList());
  }

  Stream<List<Item>> getItems(QueryDocumentSnapshot document) => _collection
      .doc(_buildId)
      .collection('orders')
      .doc(document.id)
      .collection('items')
      .snapshots()
      .map((event) => event.docs.map<Item>((e) => Item.fromMap(e)).toList());

  Future<Order> getOrder(String documentPath) async {

    DocumentSnapshot document = await FirebaseFirestore.instance.doc(documentPath).get();

    return Order.fromMap(document);

  }


  Future<Build> getBuildbyOrderPath(String orderPath) async {

    String documentPath = orderPath.substring(0, orderPath.indexOf('/orders'));

    DocumentSnapshot document = await FirebaseFirestore.instance.doc(documentPath).get();

    return Build.fromMap(document);

  }

  Future<List<Item>> getItemsByPath(String  orderPath) => FirebaseFirestore.instance.doc(orderPath)
    .collection('items')
      .snapshots()
      .map((event) => event.docs.map<Item>((e) => Item.fromMap(e)).toList()).first;


  }
