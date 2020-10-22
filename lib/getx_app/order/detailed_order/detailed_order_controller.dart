import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gesco/app/build/build_repository.dart';
import 'package:gesco/app/product/product_repository.dart';
import 'package:gesco/getx_app/build/build_model.dart';
import 'package:gesco/getx_app/order/delivered_order/delivered_order_page.dart';
import 'package:gesco/getx_app/order/new_order/new_order_page.dart';
import 'package:gesco/getx_app/order/order_status_enum.dart';
import 'package:gesco/models/category.dart';
import 'package:gesco/models/item.dart';
import 'package:gesco/models/order.dart';
import 'package:gesco/models/product.dart';
import 'package:gesco/ui/application_page.dart';
import 'package:get/get.dart';

class DetailedOrderController extends GetxController {
  String orderPath;
  Rx<Order> order = Order().obs;
  Build build;
  List<Item> items = List<Item>().obs;
  List<Product> products = List<Product>().obs;
  String user = FirebaseAuth.instance.currentUser.email;

  Rx<Category> category = Category().obs;

  DetailedOrderController(this.orderPath) {
    initializeOrder().then((value) => initializeItems()
        .then((value) => initializeProducts())
        .then((value) => initilizeCategory()));
  }

  String get buildId => orderPath.substring(
      orderPath.indexOf('build/') + 6, orderPath.indexOf('/orders'));

  Future initializeOrder() async {
    build = await BuildRepository().getBuild(buildId);
    order.value = await BuildRepository().getOrder(orderPath);
  }

  Color getColorFromStatus(Item item, OrderStatusEnum status) {
    if (isDeliveredOrClosedStatus(status)) {
      return item.quantity == item.delivered ? Colors.green : Colors.red;
    }
    return Colors.black;
  }

  bool isDeliveredOrClosedStatus(OrderStatusEnum status) =>
      status == OrderStatusEnum.ENTREGUE || status == OrderStatusEnum.CONCLUIDO;

  String getTextFromStatus() {
    return isDeliveredOrClosedStatus(OrderStatusEnum.values[order.value.status])
        ? 'Pedida/Entregue'
        : 'Quantidade';
  }

  String getTextQuantityFromStatus(Item item) {
    return isDeliveredOrClosedStatus(OrderStatusEnum.values[order.value.status])
        ? '${item.quantity}/${item.delivered}'
        : '${item.quantity}';
  }

  Widget actionFromStatus(OrderStatusEnum status) {
    switch (status) {
      case OrderStatusEnum.APROVACAO_PENDENTE:
        return getButtonModifyOrder(order.value);
      case OrderStatusEnum.AGUARDANDO_COMPRA:
        return getButtonBuyedOrder(order.value);
      case OrderStatusEnum.AGUARDANDO_ENTREGA:
        return getButtonCheckDelivery(order.value);
      case OrderStatusEnum.ENTREGUE:
        return getButtonNewOrderFromAbsents(order.value);
      default:
        return Container();
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
            onPressed: () {
              order.status = OrderStatusEnum.AGUARDANDO_COMPRA.index;
              updateOrderAndGoToHome(order);
            },
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
        onPressed: () {
          order.items = items;
          Get.to(DeliveredOrderPage(order, orderPath));
        },
        child: Text(
          'Conferir entrega',
          style: TextStyle(
              fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget getButtonNewOrderFromAbsents(Order order) {
    return Obx(() {
      return items == null
          ? Center(
              child: Row(
              children: [CircularProgressIndicator(), Text('Salvando')],
            ))
          : items.where((item) => item.delivered != item.quantity).isEmpty
              ? getButtonToCloseOrder(order)
              : getButtonsToChoiseCloseOrderOrOpenNemOrderWithAbsent(order);
    });
  }

  Container getButtonToCloseOrder(Order order) {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
      ),
      child: FlatButton(
        onPressed: () {
          order.status = OrderStatusEnum.CONCLUIDO.index;
          updateOrderAndGoToHome(order);
        },
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
            onPressed: () => newOrderWithAbsentItems(),
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
      var value = await ProductRepository()
          .getProduct(order.value.category, element.productId);
      element.product = value;
      products.add(value);
    });
  }

  Future initilizeCategory() async {
    category.value =
        await ProductRepository().getCategory(order.value.category);
  }

  getProduct(String productId) =>
      products.firstWhere((element) => element.documentId == productId);

  Widget getButtonBuyedOrder(Order order) {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
      ),
      child: FlatButton(
        onPressed: () {
          order.status = OrderStatusEnum.AGUARDANDO_ENTREGA.index;
          updateOrderAndGoToHome(order);
        },
        child: Text(
          'Compra efetuada',
          style: TextStyle(
              fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  void updateOrderAndGoToHome(Order order) {
    BuildRepository().updateOrderStatus(buildId, order);
    Get.to(ApplicationPage());
  }

  newOrderWithAbsentItems() async {
    List<Item> absentItems = items
        .where((element) => element.delivered != element.quantity)
        .map((e) {
          e.quantity = e.quantity - e.delivered;
          return e;
        })
        .toList();

    order.value.status = OrderStatusEnum.CONCLUIDO.index;
    BuildRepository().updateOrderStatus(buildId, order.value);

    Get.to(NewOrderPage(buildObj: build, items: absentItems, categoryId: order.value.category));
  }
}
