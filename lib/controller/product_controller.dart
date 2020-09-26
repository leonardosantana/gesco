
import 'package:gesco/app/product/product_repository.dart';
import 'package:gesco/controller/category_controller.dart';
import 'package:gesco/models/category.dart';
import 'package:gesco/models/product.dart';

class ProductController{

  static List<Category> categories = CategoryController.getCategories();


  Future<List<Product>> getProducts() async{
    var productRepository = new ProductRepository();

    return await productRepository.products.first;
  }

  Future<List<Product>> getFilteredProducts(String productName) async{
    var productRepository = new ProductRepository();

    return await productRepository.filteredProducts(productName).first;
  }


}