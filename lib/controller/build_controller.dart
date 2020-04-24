
import 'package:flutter/material.dart';
import 'package:gesco/controller/user_controller.dart';
import 'package:gesco/models/build.dart';
import 'package:gesco/models/order.dart';

class BuildController{

  static List<Build> _buildings = [
    Build(
        name: 'Obra 1',
        buildImage:
        'https://www.conjur.com.br/img/b/pedreiro-ajudante-obra.png',
        cust: 166000.00,
        progress: 0.0,
        phase: 'Fundação',
        color: Colors.red,
        owner: UserController.userOwner,
        engineer: UserController.engineers,
        buyer: UserController.buyers,
        orders: List<Order>()
    ),
    Build(
        name: 'Obra 2',
        buildImage:
        'https://s3-us-west-2.amazonaws.com/tribunademinas/wp-content/uploads/2018/07/18174422/Solar.jpg',
        cust: 166000.00,
        progress: 0.0,
        phase: 'Fundação',
        color: Colors.orange,
        orders: List<Order>()
    ),
    Build(
        name: 'Obra 3',
        buildImage:
        'https://www.diariodoscampos.com.br/fl/344x258/1557943762-5cdc5713a4f0a_ec_arq_obras_construcao_civil__13.jpg',
        cust: 166000.00,
        progress: 0.0,
        phase: 'Fundação',
        color: Colors.blue,
        orders: List<Order>()
    )
  ];

  static List<Build> getBuilding() => _buildings;


}

