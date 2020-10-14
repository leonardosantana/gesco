import 'dart:core';

import 'package:gesco/app/build/build_repository.dart';
import 'package:gesco/models/order.dart';
import 'package:get/get.dart';

import '../build/build_model.dart';

class HomePageController extends GetxController {
  List<Build> builds = List<Build>().obs;
  List<Order> orders = List<Order>().obs;

  @override
  Future<void> onInit() async {

    var repository = BuildRepository();

    builds.addAll(await repository.builds.first);

    builds.forEach((element) async {

      var iterableOrders = await repository.getOrders(element.documentId()).first;
      iterableOrders.forEach((order) {order.buildName = element.name;});
      orders.addAll(iterableOrders);

    });

  }
}
