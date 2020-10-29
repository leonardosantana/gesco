import 'package:flutter/material.dart';
import 'package:gesco/getx_app/home/application_page.dart';
import 'package:gesco/getx_app/order/detailed_order/detailed_order_controller.dart';
import 'package:gesco/ui/app_header.dart';
import 'package:gesco/ui/common_styles.dart';
import 'package:get/get.dart';

import '../order_status_enum.dart';

class DetailedOrderPage extends StatelessWidget {
  String orderPath;
  DetailedOrderController controller;

  DetailedOrderPage({this.orderPath}) {
    controller = Get.put(DetailedOrderController(orderPath), tag: orderPath);
  }

  @override
  Widget build(BuildContext context) {
    return buildOrderContainer();
  }

  Widget buildOrderContainer() {
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
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.all(5),
                  scrollDirection: Axis.vertical,
                  children: <Widget>[
                    SizedBox(
                      height: 20.0,
                    ),
                    Card(
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
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Obx(() => Text(
                                            'Ordem Nº${controller.order.value.orderNumber}',
                                            style: TextStyle(
                                                fontSize: 24.0,
                                                fontWeight: FontWeight.w600),
                                          )),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 2.0, horizontal: 5),
                                            child: buildCategoryName()),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'Itens\nSolicitados',
                      style: CommonStyles.SectionTextStyle(),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Card(
                      elevation: 5.0,
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('Item'),
                                Obx(() => controller.order.value.status == null
                                    ? Text('')
                                    : Text(controller.getTextFromStatus())),
                              ],
                            ),
                            buildItems(),
                          ],
                        ),
                      ),
                    ),
                    Obx(() {
                      if (controller.order.value == null ||
                          controller.order.value.status == null)
                        return Container();
                      return controller.actionFromStatus(OrderStatusEnum
                          .values[controller.order.value.status]);
                    }),
                  ],
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }

  Widget buildCategoryName() => Obx(() {
        if (controller.category.value.name == null)
          return CircularProgressIndicator();
        return Text(controller.category.value.name);
      });

  Widget buildItems() {
    return Obx(() {
      if (controller.items == null || controller.items.length == 0)
        return SizedBox();
      return ListView.builder(
        itemCount: controller.items.length,
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return itemTile(index);
        },
      );
    });
  }

  Widget buildProductName(int item) {
    return Obx(() {
      return controller.products.length == 0
          ? CircularProgressIndicator()
          : Text(controller.getProduct(controller.items[item].productId).name);
    });
  }

  Widget itemTile(int index) {
    return Container(
      padding: EdgeInsets.all(5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              buildProductName(index),
            ],
          ),
          Column(children: <Widget>[
            Text(
              controller.getTextQuantityFromStatus(controller.items[index]),
              style: TextStyle(
                color: controller.getColorFromStatus(controller.items[index],
                    OrderStatusEnum.values[controller.order.value.status]),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
