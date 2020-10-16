

import 'package:flutter/cupertino.dart';
import 'package:gesco/app/build/build_repository.dart';
import 'package:gesco/getx_app/order/detailed_order/detailed_order_page.dart';
import 'package:gesco/getx_app/order/new_order/new_order_page.dart';
import 'package:gesco/models/order.dart';
import 'package:get/get.dart';

import '../build_model.dart';

class DetailedBuildController extends GetxController{

  List<Order> orders = List<Order>().obs;
  Build build;

  DetailedBuildController({@required this.build});

  @override
  Future<void> onInit() async {

    var repository = BuildRepository();

    orders.addAll(await repository.getOrders(build.documentId).first);

  }

  void newOrder() {
    Get.to(NewOrderPage(buildObj: build));
  }

  void goToDetailedOrder(Order order) {
    Get.to(DetailedOrderPage(orderPath: order.path));
  }



}