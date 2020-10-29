import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gesco/getx_app/home/application_page.dart';
import 'package:gesco/models/item.dart';
import 'package:gesco/models/order.dart';
import 'package:gesco/ui/app_header.dart';
import 'package:gesco/ui/common_styles.dart';
import 'package:get/get.dart';

import 'delivered_order_controller.dart';

class DeliveredOrderPage extends StatelessWidget {
  DeliveredOrderController controller;

  var deliveredSize = 0.05;
  var requestedSize = 0.35;
  var itemSize = 0.45;

  DeliveredOrderPage(Order order, String buildPath) {
    controller = DeliveredOrderController(order, buildPath);
  }

  @override
  Widget build(BuildContext context) {
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
                      Get.close(1);
                      Get.reset();
                      Get.to(ApplicationPage());
                    },
                    child: AppHeader(isMainPage: false),
                  ),
                ],
              ),
              Obx(() {
                if (controller.deliveredItems.length == 0) return Container();
                return Text(
                  'Checados',
                  style: CommonStyles.SectionTextStyle(),
                );
              }),
              SizedBox(
                height: 10.0,
              ),
              Obx(() {
                if (controller.deliveredItems.length == 0) return Container();
                return Card(
                  elevation: 5.0,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                width: Get.mediaQuery.size.width * itemSize,
                                child: Text('Item')),
                            Container(
                                width:
                                    Get.mediaQuery.size.width * requestedSize,
                                child: Text(
                                  'Pedido/Entregue',
                                )),
                            Container(
                              width: Get.mediaQuery.size.width * deliveredSize,
                              child: Icon(
                                Icons.delete,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount: controller.deliveredItems.length,
                            itemBuilder: (context, index) {
                              return itemTileDelivered(index);
                            }),
                      ],
                    ),
                  ),
                );
              }),
              SizedBox(
                height: 20.0,
              ),
              Obx(() {
                if (controller.items.length == 0) return Container();
                return Text(
                  'A checar',
                  style: CommonStyles.SectionTextStyle(),
                );
              }),
              SizedBox(
                height: 10.0,
              ),
              Expanded(
                child: buildDeliveredItems(),
              ),
              Obx(() {
                if (controller.items.length > 0) return Container();
                return Container(
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                  ),
                  child: buildFlatButton(),
                );
              }),
            ],
          ),
        )),
      ),
    );
  }

  Widget buildFlatButton() {
    return Obx(() => controller.isLoading == true
        ? Center(
            child: Row(
            children: [CircularProgressIndicator(), Text('Salvando')],
          ))
        : FlatButton(
            onPressed: () {
              controller.deliveredOrder();
            },
            child: Text(
              'Concluir',
              style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ));
  }

  buildDeliveredItems() {
    return Obx(() {
      if (controller.items.length == 0) return Container();
      return ListView.builder(
          itemCount: controller.items.length,
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return itemTile(controller.items[index], index);
          });
    });
  }

  Widget itemTile(Item item, int index) {
    return Card(
      elevation: 5.0,
      child: Dismissible(
        background: Container(
          padding: EdgeInsets.all(10),
          color: Colors.yellow,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Quantidade difere'),
                ],
              ),
            ],
          ),
        ),
        secondaryBackground: Container(
          padding: EdgeInsets.all(10),
          color: Colors.green,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Entregue totalmente'),
                ],
              ),
            ],
          ),
        ),
        key: Key(Random.secure().nextInt(100000).toString()),
        onDismissed: (direction) {
          controller.items.removeAt(index);
          controller.deliveredController.value.text = item.quantity.toString();
          if (direction == DismissDirection.startToEnd) {
            Get.dialog(AlertDialog(
              title: Text("Quantidade entregue"),
              content: TextFormField(
                controller: controller.deliveredController.value,
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text("OK"),
                  onPressed: () {
                    Get.back();
                    controller.addDeliveredItem(item);
                  },
                )
              ],
            ));
          } else {
            controller.addDeliveredItem(item);
          }
        },
        child: Container(
          height: 60,
          color: Colors.lightBlueAccent,
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Column(
                      children: <Widget>[
                        Text(item.product.name),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(children: <Widget>[
                      Text('Qtd:${item.quantity.toString()}'),
                    ]),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget itemTileDelivered(int index) {
    return Container(
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              width: Get.mediaQuery.size.width * itemSize,
              child: Text(controller.deliveredItems[index].product.name)),
          Container(
            width: Get.mediaQuery.size.width * requestedSize,
            child: Text(
              '${controller.deliveredItems[index].quantity}/${controller.deliveredItems[index].delivered}',
              style: TextStyle(
                  color: controller.deliveredItems[index].quantity ==
                          controller.deliveredItems[index].delivered
                      ? Colors.green
                      : Colors.red),
            ),
          ),
          Container(
            width: Get.mediaQuery.size.width * deliveredSize,
            child: InkWell(
              onTap: (() {
                controller.items.add(controller.deliveredItems[index]);
                controller.deliveredItems.removeAt(index);
              }),
              child: Icon(
                Icons.delete,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
