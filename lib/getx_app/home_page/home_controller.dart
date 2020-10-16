import 'dart:core';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:gesco/app/build/build_repository.dart';
import 'package:gesco/models/order.dart';
import 'package:get/get.dart';

import '../build/build_model.dart';

class HomePageController extends GetxController {
  List<Build> builds = List<Build>().obs;
  List<Order> orders = List<Order>().obs;
  RxBool hideMenu = true.obs;

  @override
  Future<void> onInit() async {
    var repository = BuildRepository();
    var user = FirebaseAuth.instance.currentUser.email;

    List<Build> allBuilds = List();

    allBuilds.addAll(await repository.builds.first);

    builds.addAll(allBuilds.where((element) =>
        element.builder == user ||
        element.owner == user ||
        element.engineer == user));

    builds.forEach((element) async {
      var iterableOrders = await repository.getOrders(element.documentId).first;
      iterableOrders.forEach((order) {
        order.buildName = element.name;
      });
      orders.addAll(iterableOrders);
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
