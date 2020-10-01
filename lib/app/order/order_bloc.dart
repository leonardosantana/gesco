import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:gesco/app/build/build_model.dart';
import 'package:gesco/app/build/build_repository.dart';
import 'package:gesco/models/item.dart';
import 'package:gesco/models/order.dart';

class OrderBloc extends BlocBase {
  @override
  void dispose() {
    _blocController.close();
    super.dispose();
  }

  List<Order> _orders = List<Order>();

  List<Order> get orders => _orders;

  final _blocController = StreamController<List<Order>>();

  Stream<List<Order>> get ordersStream => _blocController.stream;

  BuildRepository _buildRepository = BuildRepository();

  Future<Order> getOrder(String documentPath) {
    return _buildRepository.getOrder(documentPath);
  }

  Future<Build> getBuildbyOrderPath(String orderPath) {
    return _buildRepository.getBuildbyOrderPath(orderPath);
  }

  Future<List<Item>> getItems(String orderPath) {
    return _buildRepository.getItemsByPath(orderPath);
  }

  void getOrders() async {
    var buildRepository = new BuildRepository();

    _orders = List<Order>();

    List<Build> builds = await buildRepository.builds.first;
    List<Order> orders;

    builds.forEach((element) async {

      orders = await buildRepository.getOrders(element.documentId()).first;
      _orders.addAll(orders);

      _blocController.sink.add(_orders);
    });



  }
}
