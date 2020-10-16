import 'package:flutter/material.dart';
import 'package:gesco/app/build/build_repository.dart';
import 'package:gesco/app/product/product_repository.dart';
import 'package:gesco/getx_app/order/order_status_enum.dart';
import 'package:gesco/models/category.dart';
import 'package:gesco/models/item.dart';
import 'package:gesco/models/order.dart';
import 'package:gesco/models/product.dart';
import 'package:get/get.dart';

class DetailedOrderController extends GetxController {
  String orderPath;
  Rx<Order> order = Order().obs;
  List<Item> items = List<Item>().obs;

  Rx<Category> category = Category().obs;

  DetailedOrderController(this.orderPath) {
    initializeOrder().then(
        (value) => initializeItems().then((value) => initializeProducts()).then((value) => initilizeCategory()));
  }

  Future initializeOrder() async {
    order.value = await BuildRepository().getOrder(orderPath);
  }

  Color getColorFromStatus(Item item, OrderStatusEnum status) {
    if (status == OrderStatusEnum.ENTREGUE) {
      return item.quantity == item.delivered ? Colors.green : Colors.red;
    }
    return Colors.black;
  }

  String getTextFromStatus(OrderStatusEnum status) {
    return status == OrderStatusEnum.ENTREGUE
        ? 'Quantidade\npedida/entregue'
        : 'Quantidade';
  }

  Widget actionFromStatus(OrderStatusEnum status) {
    switch (status) {
      case OrderStatusEnum.APROVACAO_PENDENTE:
      case OrderStatusEnum.AGUARDANDO_COMPRA:
        return getButtonModifyOrder(order.value);
      case OrderStatusEnum.AGUARDANDO_ENTREGA:
        return getButtonCheckDelivery(order.value);
      case OrderStatusEnum.ENTREGUE:
        return getButtonNewOrderFromAbsents(order.value);
    }
  }

  Widget getButtonModifyOrder(Order order) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.blueAccent,
          ),
          child: FlatButton(
            onPressed: () {},
            child: Text(
              'Modificar pedido',
              style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.blueAccent,
          ),
          child: FlatButton(
            onPressed: () {},
            child: Text(
              'Aprovar pedido',
              style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  Container getButtonCheckDelivery(Order order) {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
      ),
      child: FlatButton(
        onPressed: () {},
        child: Text(
          'Conferir entrega',
          style: TextStyle(
              fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Container getButtonNewOrderFromAbsents(Order order) {
    bool deliveryEqualsFromOrder =
        order.items.where((item) => item.delivered != item.quantity).isEmpty;

    return deliveryEqualsFromOrder
        ? getButtonToCloseOrder(order)
        : getButtonsToChoiseCloseOrderOrOpenNemOrderWithAbsent(order);
  }

  Container getButtonToCloseOrder(Order order) {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
      ),
      child: FlatButton(
        onPressed: () {},
        child: Text(
          'Finalizar',
          style: TextStyle(
              fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Container getButtonsToChoiseCloseOrderOrOpenNemOrderWithAbsent(Order order) {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        getButtonToCloseOrder(order),
        Container(
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.blueAccent,
          ),
          child: FlatButton(
            child: Text(
              'Nova com itens Faltantes',
              style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    ));
  }

  Widget getButtonAddItensOrFinalize(Order order) {
    return Column(
      children: <Widget>[
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                ),
                child: FlatButton(
                  onPressed: () {},
                  child: Text(
                    'Adicionar Item',
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                ),
                child: FlatButton(
                  onPressed: () {},
                  child: Text(
                    'Fazer Solicitação',
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }


  Future initializeItems() async {
    items.clear();
    items.addAll(await BuildRepository().getItemsByPath(orderPath));
  }

  initializeProducts() {
    items.forEach((element) async {
      element.product =
          (await ProductRepository().getProduct(order.value.category, element.productId));
    });
  }

  Future initilizeCategory() async {
    category.value = await ProductRepository().getCategory(order.value.category);
  }
}
