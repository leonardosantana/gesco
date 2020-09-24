import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gesco/utils/common_validator.dart';

class NewBuildBloc extends BlocBase {
  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    super.dispose();
  }

  Future<FirebaseUser> _user;

  NewBuildBloc(){
    _user = initUser();
  }

  Future <FirebaseUser> initUser() async {
    return await FirebaseAuth.instance.currentUser;
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

  saveBuild(String name, String address, double buildSize, String zipCode, String builder, String engineer, bool engineerSwitch) {

  }

}

