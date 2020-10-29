

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:gesco/app/build/build_repository.dart';
import 'package:gesco/getx_app/order/detailed_order/detailed_order_page.dart';
import 'package:gesco/getx_app/order/new_order/new_order_page.dart';
import 'package:gesco/models/order.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../build_model.dart';

class DetailedBuildController extends GetxController{

  List<Order> orders = List<Order>().obs;
  Rx<PickedFile> picture = null.obs;
  RxString imagePath = ''.obs;
  Build build;

  DetailedBuildController({@required this.build});

  @override
  Future<void> onInit() async {

    var repository = BuildRepository();

    orders.addAll(await repository.getOrders(build.documentId).first);

  }

  void newOrder() {
    Get.to(NewOrderPage(buildObj: build));
  }

  void goToDetailedOrder(Order order) {
    Get.to(DetailedOrderPage(orderPath: order.path));
  }

  void updateImage(PickedFile image) async {
    StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(image.path);
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(File(image.path));
    StorageTaskSnapshot taskSnapshot= await uploadTask.onComplete;

    imagePath.value = await taskSnapshot.ref.getDownloadURL();

    build.buildImage = imagePath.value;
    BuildRepository().update(build.documentId, build);

  }



}