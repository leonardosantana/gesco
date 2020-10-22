import 'package:flutter/material.dart';
import 'package:gesco/app/build/build_repository.dart';
import 'package:gesco/app/product/category_repository.dart';
import 'package:gesco/app/product/product_repository.dart';
import 'package:gesco/getx_app/order/order_status_enum.dart';
import 'package:gesco/models/item.dart';
import 'package:gesco/models/order.dart';
import 'package:gesco/models/product.dart';
import 'package:gesco/ui/application_page.dart';
import 'package:get/get.dart';

class DeliveredOrderController extends GetxController {

  Rx<Order> order = Order().obs;
  RxBool isLoading = false.obs;
  Rx<TextEditingController> deliveredController = TextEditingController().obs;
  List<Item> deliveredItems = List<Item>().obs;
  List<Item> items = List<Item>().obs;

  var productRepository = ProductRepository();

  String orderPath;

  DeliveredOrderController(Order order, this.orderPath) {
    this.order.value = order;
    this.items.addAll(order.items);
  }

  void addDeliveredItem(Item itemDelivered) {
    itemDelivered.delivered = int.parse(deliveredController.value.text);

    deliveredItems.add(itemDelivered);
  }

  void deliveredOrder()  {
    isLoading.value = true;

    var orderPathIds = orderPath.split('/');

    String buildId = orderPathIds[2];
    String orderId = orderPathIds[4];


    var repository = BuildRepository();


    deliveredItems.forEach((item) async {
      await repository.updateItem(buildId, orderId, item.getId(), item);
    });

    order.value.status = OrderStatusEnum.ENTREGUE.index;

    repository.updateOrderStatus(buildId, order.value);

    isLoading.value = false;

    Get.to(ApplicationPage());

  }

}
