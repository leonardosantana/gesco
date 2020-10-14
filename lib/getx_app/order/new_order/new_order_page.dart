import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gesco/controller/order_controller.dart';
import 'package:gesco/getx_app/build/build_model.dart';
import 'package:gesco/getx_app/order/new_order/new_order_controller.dart';
import 'package:gesco/getx_app/order/order_status_enum.dart';
import 'package:gesco/models/category.dart';
import 'package:gesco/models/item.dart';
import 'package:gesco/models/product.dart';
import 'package:gesco/ui/app_header.dart';
import 'package:gesco/utils/common_validator.dart';
import 'package:get/get.dart';

class NewOrderPage extends GetView<NewOrderController> {
  var dropdownValue = 'teste';

  Build buildObj;
  NewOrderController controller;

  NewOrderPage({@required this.buildObj}) {
    controller = Get.put(NewOrderController(buildObj));
    controller.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Obx(() {
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
                              Get.back();
                              Get.reset();
                            },
                            child: AppHeader(isMainPage: false),
                          ),
                        ],
                      ),
                      buildDetailsCard(),
                      chooseProductsCard(),
                      orderResumeCard()
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Card chooseProductsCard() {
    return Card(
      elevation: 5.0,
      margin: EdgeInsets.all(2),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            chooseCategory(),
            showButton(),
          ],
        ),
      ),
    );
  }

  Widget chooseCategory() {
    return Obx(() {
      return DropdownButton<String>(
        value: controller.category.value.name,
        iconSize: 24,
        elevation: 16,
        style: TextStyle(color: Colors.deepPurple),
        underline: Container(
          height: 2,
          color: Colors.deepPurpleAccent,
        ),
        onChanged: (value) => controller.changeSelectedCategory(value),
        items: controller.categories
            .map<DropdownMenuItem<String>>((Category value) {
          return DropdownMenuItem<String>(
            value: value.name,
            child: Text(value.name),
          );
        }).toList(),
      );
    });
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          Text(
                            buildObj.name,
                            style: TextStyle(
                                fontSize: 24.0, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            '\tsolicitação nº${controller.order.value.orderNumber.toString()}',
                            style: TextStyle(
                                fontSize: 24.0, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(buildObj.phase == null ? '' : buildObj.phase),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              //width: 100.0,
              //height: 100.0,
              child: Row(
                children: <Widget>[
                  Container(
                      decoration: BoxDecoration(
                        color: OrderStatus.getColorFromStatus(
                            OrderStatusEnum.values[controller.order.value.status]),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 2.0, horizontal: 5),
                        child: Text(OrderStatus.getStatusFromEnum(
                            OrderStatusEnum.values[controller.order.value.status])),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget productsDialog() {
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(10),
        child: chooseProducts(),
      ),
    );
  }

  Widget chooseProducts() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Obx(() {
          return TextFormField(
            controller: controller.searchController.value,
            maxLength: 25,
            onChanged: (value) => controller.getFilteredProducts(value),
            style: TextStyle(color: Colors.deepPurple),
            decoration: const InputDecoration(
              icon: Icon(Icons.search),
            ),
          );
        }),
        SizedBox(
          height: 10,
        ),
        Obx(() {
          return DropdownButton<String>(
            value: controller.product.value.name,
            iconSize: 24,
            elevation: 16,
            style: TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (value) => controller.selectProduct(value),
            items: controller.filteredProducts
                .map<DropdownMenuItem<String>>((Product value) {
              return DropdownMenuItem<String>(
                value: value.name,
                child: Text(value.name),
              );
            }).toList(),
          );
        }),
        Column(
          children: [
            Form(
              key: controller.formKey.value,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Obx(() => TextFormField(
                      maxLength: 12,
                      keyboardType: TextInputType.number,
                      controller: controller.quantityController.value,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.add),
                        hintText: 'Quantidade',
                        labelText: 'Quantidade',
                      ),
                      validator: (value) =>
                          CommonValidator.validateEmptyString(value)
                              ? 'Informe quantidade válida'
                              : null)),
                  FlatButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    padding: EdgeInsets.all(10.0),
                    splashColor: Colors.blueAccent,
                    onPressed: () => controller.addItem(),
                    child: Text(
                      'Incluir Item',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  showButton() {
    if (controller.products.length == 0 ||
        controller.category.value.name == controller.emptyCategory)
      return Container();
    return FlatButton(
      color: Colors.blue,
      textColor: Colors.white,
      padding: EdgeInsets.all(10.0),
      splashColor: Colors.blueAccent,
      onPressed: () => Get.dialog(productsDialog()),
      child: Text(
        'Incluir Item',
        style: TextStyle(fontSize: 20.0),
      ),
    );
  }

  orderResumeCard() {
    if (controller.items.length == 0) return SizedBox();
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(width: Get.mediaQuery.size.width * .60, child: Text('Item')),
                Container(width: Get.mediaQuery.size.width * .10, child: Text('Qtd')),
                Container(width: Get.mediaQuery.size.width * .10, child: Icon(Icons.delete, color: Colors.grey)),
              ],
            ),
            SizedBox(height: 20,),
            Obx(() {
              return ListView.builder(
                itemCount: controller.items.length,
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[itemTile(controller.items[index], index),SizedBox(height: 10,)],
                  );
                },
              );
            }),
            FlatButton(
              color: Colors.blue,
              textColor: Colors.white,
              padding: EdgeInsets.all(10.0),
              splashColor: Colors.blueAccent,
              onPressed: () => controller.saveOrder(),
              child: Text('Solicitar Items'),
            )
          ],
        ),
      ),
    );
  }

  itemTile(Item item, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(width: Get.mediaQuery.size.width * .60 ,child: Text(item.product.name)),
        Container(width: Get.mediaQuery.size.width * .10, child: Text(item.quantity.toString())),
        Container(width: Get.mediaQuery.size.width * .10, child: IconButton(icon: Icon(Icons.delete), onPressed: () => controller.removeItem(index))),
      ],
    );
  }
}
