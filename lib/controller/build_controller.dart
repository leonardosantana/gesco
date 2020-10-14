import 'package:flutter/material.dart';
import 'file:///C:/Users/Leonardo%20Santana/IdeaProjects/gesco/lib/getx_app/build/build_model.dart';
import 'package:gesco/app/build/build_repository.dart';
import 'package:gesco/controller/user_controller.dart';
import 'package:gesco/models/order.dart';
import 'package:gesco/models/user.dart';

class BuildController {
  static List<Build> _buildings;

  Future<List<Build>> getBuilding() async{
    var buildRepository = new BuildRepository();

    return null;//await buildRepository.builds.first;
  }

  static Build saveBuild(String name, String address, String cep, String size, String builder,
      String engineer, bool enginnerIsAprrover) {

    List<User> engineers = [UserController.findUserByLogin(engineer)];
    List<User> constructors = [UserController.findUserByLogin(engineer)];

    /*Build newBuild = Build(
        name: name,
        buildImage:'https://cdn11.bigcommerce.com/s-67d81/images/stencil/2048x2048/products/2356/5606/57146_3__96383.1500463213.jpg',
        cust: 0.0,
        progress: 0.0,
        phase: 'Fundação',
        color: Colors.blue,
        constructor: UserController.findUserByLogin(builder),
        engineer: engineers,
        buyer: constructors,
        orders: List<Order>());

    _buildings.add(newBuild);*/
  }
}
