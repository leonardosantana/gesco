
import 'package:gesco/controller/category_controller.dart';
import 'package:gesco/models/category.dart';
import 'package:gesco/models/product.dart';

class ProductController{

  static List<Category> categories = CategoryController.getCategories();

  static List<Product> getProducts(){

    List<Product> products = [];

    categories.forEach( (item) => products.addAll(item.products));

    return products;
  }
}