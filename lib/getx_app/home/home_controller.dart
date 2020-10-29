import 'dart:core';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:gesco/app/build/build_repository.dart';
import 'package:gesco/models/order.dart';
import 'package:get/get.dart';

import '../build/build_model.dart';

class HomePageController extends GetxController {
  List<Rx<Build>> builds = List<Rx<Build>>().obs;
  List<Order> orders = List<Order>().obs;
  RxBool hideMenu = true.obs;

  @override
  Future<void> onInit() async {
    var repository = BuildRepository();
    var user = FirebaseAuth.instance.currentUser.email;

    List<Build> allBuilds = List();
    List<Build> filteredBuilds = List();

    allBuilds.addAll(await repository.builds.first);

    filteredBuilds.addAll(allBuilds.where((element) =>
        element.builder == user ||
        element.owner == user ||
        element.engineer == user));

    loadOrders(filteredBuilds, repository);
  }

  loadOrders(List<Build> filteredBuilds, BuildRepository repository) {
    filteredBuilds.forEach((element)  {
      var iterableOrders = repository.getOrders(element.documentId).first;
      iterableOrders.then((value) {
        value.forEach((order) {
          order.buildName = element.name;
        });
        element.cust = value.map((a) => a.cust).reduce((a, b) => a + b);
        builds.add(element.obs);
        orders.addAll(value);
        orders.sort((a, b) => -a.date.compareTo(b.date));
      });
    });
  }

  changeSelectedMenu() {
    hideMenu.value = !hideMenu.value;
  }

  String getUserBuildRole(Build build) {
    var currentUserEmail = FirebaseAuth.instance.currentUser.email;
    if (currentUserEmail == build.owner) return 'Proprietário';
    if (currentUserEmail == build.engineer) return 'Engenheiro';
    if (currentUserEmail == build.builder) return 'Construtor';
    return 'ERRO';
  }
}
