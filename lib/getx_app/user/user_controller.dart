import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gesco/app/user/user_repository.dart';
import 'package:gesco/controller/user_controller.dart';
import 'package:gesco/getx_app/user/user_model.dart';
import 'package:get/get.dart';

class UserController extends GetxController {

  var users = new List<UserModel>().obs;

  @override
  Future<void> onInit() async {
    UserRepository repository = UserRepository();

    users.addAll(await repository.getUsers());
  }

  @override
  Future<void> onReady() async {
    this.update();
  }

  addUser() {}

}
