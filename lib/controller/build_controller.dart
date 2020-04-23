
import 'package:flutter/material.dart';
import 'package:gesco/models/build.dart';

class BuildController{

  static List<Build> _buildings = [
    Build(
        name: 'Obra 1',
        buildImage:
        'https://www.conjur.com.br/img/b/pedreiro-ajudante-obra.png',
        cust: 166000.00,
        progress: 0.0,
        phase: 'Fundação',
        color: Colors.red),
    Build(
        name: 'Obra 1',
        buildImage:
        'https://s3-us-west-2.amazonaws.com/tribunademinas/wp-content/uploads/2018/07/18174422/Solar.jpg',
        cust: 166000.00,
        progress: 0.0,
        phase: 'Fundação',
        color: Colors.orange),
    Build(
        name: 'Obra 1',
        buildImage:
        'https://www.diariodoscampos.com.br/fl/344x258/1557943762-5cdc5713a4f0a_ec_arq_obras_construcao_civil__13.jpg',
        cust: 166000.00,
        progress: 0.0,
        phase: 'Fundação',
        color: Colors.blue)
  ];

  static List<Build> getBuilding() => _buildings;


}

