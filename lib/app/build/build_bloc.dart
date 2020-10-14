import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Users/Leonardo%20Santana/IdeaProjects/gesco/lib/getx_app/build/build_model.dart';
import 'package:gesco/app/build/build_repository.dart';
import 'package:gesco/models/order.dart';
import 'package:gesco/utils/common_validator.dart';

class BuildBloc extends BlocBase {
  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    _blocController.close();
    super.dispose();
  }

  List<Build> _builds;
  List<Build> get builds => _builds;

  final _blocController = StreamController<List<Build>>();

  Stream<List<Build>> get buildsStream => _blocController.stream;

  User _user;

  BuildBloc() {
    _user = initUser();

  }

  BuildRepository _repository = new BuildRepository();

  User initUser() {
    return FirebaseAuth.instance.currentUser;
  }

  bool formValidate(GlobalKey<FormState> formKey) {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();

      return true;
    }

    return false;
  }

  validateIsNull(String value, String message) {
    if (CommonValidator.validateEmptyString(value)) {
      return message;
    }

    return null;
  }

  String getUserId(String value) {
    return "";
  }

  String validateUser(String value, String message) {
    if (!CommonValidator.validateEmail(value)) {
      return message;
    }

    return null;
  }

  saveBuild(
      String name,
      String address,
      double buildSize,
      String zipCode,
      String builder,
      String engineer,
      bool engineerSwitch,
      String phase,
      BuildContext context) {
    Build newBuild = Build();

    newBuild.name = name;
    newBuild.address = address;
    newBuild.buildSize = buildSize;
    newBuild.zipCode = zipCode;
    newBuild.builder = builder;
    newBuild.engineer = engineer;
    newBuild.buildImage =
        'https://www.conjur.com.br/img/b/pedreiro-ajudante-obra.png';
    newBuild.color = Colors.red;
    newBuild.cust = 0.0;
    newBuild.progress = 0.0;
    newBuild.owner = _user.email;
    newBuild.phase = phase;
    newBuild.orderNeedsAproval = engineerSwitch;
    newBuild.orders = new List<Order>();
    newBuild.ordersNumber = 0;

    //_repository.add(newBuild);

    _builds.add(newBuild);
    _blocController.sink.add(builds);

    Navigator.pop(context);
  }

  getBuilding() async{
    var buildRepository = new BuildRepository();

    _builds = null;//await buildRepository.builds.first;
    _blocController.sink.add(builds);
  }

  void addOrder(Build build, Order order) {
    if (build.orders == null) {
      build.orders = new List<Order>();
    }

    order.quantity = order.items.length;

    if(order.orderNumber == null) {
      order.orderNumber = ++build.ordersNumber;
    }

    build.orders.add(order);


    //_repository.update(build.documentId(), build);
    _repository.addOrder(build.documentId(), order);
  }

  void updateOrder(Build build, Order order) {

    order.quantity = order.items.length;
    _repository.updateOrder(build.documentId(), order);

  }
}
