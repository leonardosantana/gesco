import 'package:flutter/material.dart';
import 'package:gesco/app/build/build_repository.dart';
import 'package:gesco/app/product/category_repository.dart';
import 'package:gesco/getx_app/build/build_model.dart';
import 'package:gesco/getx_app/build/detailed_build/detailed_build_controller.dart';
import 'package:gesco/getx_app/home_page/home_page.dart';
import 'package:gesco/getx_app/order/order_status_enum.dart';
import 'package:gesco/models/category.dart';
import 'package:gesco/models/item.dart';
import 'package:gesco/models/order.dart';
import 'package:gesco/models/product.dart';
import 'package:gesco/ui/application_page.dart';
import 'package:get/get.dart';

class NewOrderController extends GetxController {
  Build _build;

  List<Item> items = List<Item>().obs;
  List<Category> categories = List<Category>().obs;
  List<Product> products = List<Product>().obs;
  List<Product> filteredProducts = List<Product>().obs;
  Rx<Category> category = Category().obs;
  Rx<TextEditingController> searchController = TextEditingController().obs;
  Rx<TextEditingController> quantityController = TextEditingController().obs;
  var notFoundProduct = 'Nenhum Produto encontrado';
  var emptyCategory = 'Selecione uma Categoria';
  var emptyProduct = Product(name: 'Selecione um Produto');
  Rx<Product> product = Product().obs;

  Rx<GlobalKey<FormState>> formKey = GlobalKey<FormState>().obs;

  var _buildRepository = BuildRepository();
  var _categoryRepository = CategoryRepository();

  Rx<Order> order = Order().obs;

  NewOrderController(this._build) {
    order.value = newOrder();
    product.value = emptyProduct;
    categories.add(Category(name: emptyCategory));
    initializeCategories().then((value) => categories.addAll(value));
  }

  Order newOrder() {
    return Order(
        color: Colors.blueAccent,
        category: '',
        cust: 0.00,
        quantity: 0,
        status: OrderStatusEnum.CRIANDO.index,
        items: items,
        orderNumber: _build.ordersNumber == null ? 1 : _build.ordersNumber + 1);
  }

  addItem() {
    if (product.value.name.isNull || product.value == emptyProduct)
      Get.snackbar('Erro', 'selecione um produto valido');
    else if (formKey.value.currentState.validate()) {
      Item item = Item(
          quantity: int.parse(this.quantityController.value.text.toString()),
          product: product.value);
      items.add(item);
      resetProduct();
      Get.back();
    }
  }

  saveOrder() {
    print('saving order in ${_build.documentId}');
    order.value.quantity = items.length;
    _build.ordersNumber++;
    order.value.status = OrderStatusEnum.APROVACAO_PENDENTE.index;

    _buildRepository.addOrder(_build.documentId, order.value).then((value) {
      print('order added with id ${value}');
      _buildRepository.update(_build.documentId, _build).then((value) {
        DetailedBuildController buildController =
            Get.put(DetailedBuildController(build: _build), tag: _build.documentId);
        buildController.orders.add(order.value);
        buildController.build = _build;

        Get.close(1);
        Get.to(ApplicationPage());
        Get.reset();
      });
    });
  }

  Future<List<Category>> initializeCategories() async =>
      await _categoryRepository.categories.first;

  changeSelectedCategory(String value) async {
    if (items.length > 0) {
      Get.snackbar(
          'Erro', 'Só é possivel adicionar items de uma mesma categoria');
      return;
    }
    products.clear();
    products.add(emptyProduct);
    filteredProducts.clear();
    searchController.value.clear();

    if (value == categories[0].name) {
      category.value = categories[0];
    } else {
      category.value =
          categories.firstWhere((element) => element.name == value);
      products.addAll(
          await _categoryRepository.products(category.value.documentId).first);
      filteredProducts.addAll(products);
    }
  }

  void reset() {
    category.value = categories[0];
  }

  void resetProduct() {
    quantityController.value.text = '';
    product.value = emptyProduct;
  }

  getFilteredProducts(String value) async {
    filteredProducts.clear();
    filteredProducts
        .addAll(products.where((element) => element.name.contains(value)));
    if (filteredProducts.length == 0)
      filteredProducts.add(Product(name: notFoundProduct));
  }

  selectProduct(String value) {
    //if(value != emptyProduct)
    product.value =
        filteredProducts.firstWhere((element) => element.name == value);
  }

  removeItem(int index) {
    items.removeAt(index);
  }
}
