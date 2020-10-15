import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:gesco/app/product/product_repository.dart';
import 'package:gesco/models/product.dart';

class NewOrderBloc extends BlocBase {
  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    super.dispose();
  }

  List<Product> getProducts() {
    ProductRepository productRepository = new ProductRepository();
  }
}
