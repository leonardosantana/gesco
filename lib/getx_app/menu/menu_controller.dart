import 'package:gesco/app/user/user_repository.dart';
import 'package:get/get.dart';

class MenuController extends GetxController{

  RxBool isAdmin = false.obs;

  MenuController(){
    initialize();
  }

  Future initialize() async {
    this.isAdmin.value = await UserRepository().isadmin;
  }
}