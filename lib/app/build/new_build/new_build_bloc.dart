import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gesco/app/build/build_repository.dart';
import 'package:gesco/models/build.dart';
import 'package:gesco/models/order.dart';
import 'package:gesco/utils/common_validator.dart';

class NewBuildBloc extends BlocBase {
  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    super.dispose();
  }

  User _user;

  NewBuildBloc(){
    _user = initUser();
  }

  BuildRepository _repository = new BuildRepository();

  User initUser() {
    return FirebaseAuth.instance.currentUser;
  }

  bool formValidate(GlobalKey<FormState> formKey) {

    if(formKey.currentState.validate()) {

      formKey.currentState.save();

      return true;
    }

    return false;

  }

  validateIsNull(String value, String message) {

    if(CommonValidator.validateEmptyString(value)){
      return message;
    }

    return null;
  }

  String getUserId(String value) {
    return "";
  }

  String validateUser(String value, String message) {

    if(!CommonValidator.validateEmail(value)){
      return message;
    }

    return null;
  }

  saveBuild(String name, String address, double buildSize, String zipCode, String builder, String engineer, bool engineerSwitch, BuildContext context) {
    Build newBuild = Build();

    newBuild.name = name;
    newBuild.address = address;
    newBuild.buildSize = buildSize;
    newBuild.zipCode = zipCode;
    newBuild.builder = builder;
    newBuild.engineer = engineer;
    newBuild.buildImage = 'https://www.conjur.com.br/img/b/pedreiro-ajudante-obra.png';
    newBuild.color = Colors.red;
    newBuild.owner = _user.email;
    newBuild.orders= List<Order>();

    _repository.add(newBuild);

    Navigator.pop(context);
  }

}

