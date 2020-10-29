import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gesco/getx_app/build/detailed_build/detailed_build_controller.dart';
import 'package:gesco/getx_app/home/application_page.dart';
import 'package:gesco/getx_app/order/order_status_enum.dart';
import 'package:gesco/models/order.dart';
import 'package:gesco/ui/app_header.dart';
import 'package:gesco/ui/common_styles.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../build_model.dart';

class DetailedBuildPage extends StatelessWidget {
  Build buildObj;
  double screenWidth;
  double screenHeight;

  DetailedBuildController controller;


  DetailedBuildPage({this.buildObj}) {
    if (buildObj != null) {
      controller = Get.put(DetailedBuildController(build: buildObj),
          tag: buildObj.documentId);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return Container(
      child: Material(
        elevation: 8,
        child: SafeArea(
            child: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              Row(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Get.to(ApplicationPage());
                    },
                    child: AppHeader(isMainPage: false),
                  ),
                ],
              ),
              Expanded(
                child: ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.all(5),
                    scrollDirection: Axis.vertical,
                    children: <Widget>[
                      buildDetailsCard(),
                      newOrderButton(),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        'Últimas\nSolicitações',
                        style: CommonStyles.SectionTextStyle(),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      ordersTiles(),
                    ]),
              ),
            ],
          ),
        )),
      ),
    );
  }

  Obx ordersTiles() {
    return Obx(() => ListView.builder(
          itemCount: controller.orders.length,
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[buildOrderTile(controller.orders[index])],
            );
          },
        ));
  }

  Container newOrderButton() {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
      ),
      child: FlatButton(
        onPressed: () {
          controller.newOrder();
        },
        child: Text(
          'Nova solicitação',
          style: TextStyle(
              fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Card buildDetailsCard() {
    return Card(
      elevation: 5.0,
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              //width: 100.0,
              //height: 100.0,
              child: Row(
                children: <Widget>[
                  Container(
                    width: 100.0,
                    height: 100.0,
                    child: Stack(children: <Widget>[
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Icon(
                          Icons.camera_alt,
                          size: 20,
                        ),
                      ),
                      InkWell(
                        onTap: (() => Get.dialog(showChooseImageDialog())),
                        child: Container(
                          width: 95.0,
                          height: 95.0,
                          child: getImage(),
                        ),
                      ),
                    ]),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        buildObj.name,
                        style: TextStyle(
                            fontSize: 24.0, fontWeight: FontWeight.w600),
                      ),
                      Text(buildObj.cust.toString()),
                      Text(buildObj.progress.toString()),
                      Text(buildObj.phase == null ? '' : buildObj.phase),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getImage() {
    return Obx((){

      var backgroundImage = controller.imagePath.value == ''? NetworkImage(buildObj.buildImage) : NetworkImage(controller.imagePath.value);
      return CircleAvatar(
          backgroundImage: backgroundImage
      );
    });

  }

  Widget buildOrderTile(Order order) {
    return InkWell(
      onTap: () {
        controller.goToDetailedOrder(order);
      },
      child: Card(
        elevation: 5.0,
        color: Colors.white,
        child: Container(
          padding: EdgeInsets.all(5.0),
          height: 60.0,
          //color: getColorFromCategory(widget.category).withOpacity(0.5),
          child: buildOrder(order),
        ),
      ),
    );
  }

  Widget buildOrder(Order order) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              /*Container(
                      width: 50.0,
                      height: 50.0,
                      //color: Colors.white,
                      child: Image.asset(getImageFromCategory(widget.category)),
                    ),
                    SizedBox(
                      width: 2,
                    ),*/
              Container(
                //width: 120.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      order.orderNumber != null
                          ? '#${order.orderNumber}'
                          : 'nova ordem',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w800),
                    ),
                    Container(
                        decoration: BoxDecoration(
                          color: OrderStatus.getColorFromStatus(
                              OrderStatusEnum.values[order.status]),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 2.0, horizontal: 5),
                          child: Text(OrderStatus.getStatusFromEnum(
                              OrderStatusEnum.values[order.status])),
                        )),
                  ],
                ),
              ),
            ],
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text('Itens: ${order.quantity}'),
                Text('${DateFormat('d/M/y').format(DateTime.fromMillisecondsSinceEpoch(order.date.millisecondsSinceEpoch))}')
              ],
            ),
          )
        ]);
  }

  Widget showChooseImageDialog() {
    return AlertDialog(
        title: Text("De onde quer pegar a imagem?"),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              GestureDetector(
                child: Text("Galeria"),
                onTap: () {
                  _openGallery();
                },
              ),
              Padding(padding: EdgeInsets.all(8.0)),
              GestureDetector(
                child: Text("Camera"),
                onTap: () {
                  _openCamera();
                },
              )
            ],
          ),
        ));
  }

  void _openGallery() async {
    var image = await ImagePicker().getImage(source: ImageSource.gallery);
    controller.updateImage(image);
    Get.back();
  }

  void _openCamera() async {
    var image = await ImagePicker().getImage(source: ImageSource.camera);
    controller.updateImage(image);
    Get.back();
  }
}
