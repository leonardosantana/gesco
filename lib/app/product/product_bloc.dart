import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:gesco/app/product/product_repository.dart';
import 'package:gesco/models/product.dart';

class ProductBloc extends BlocBase {
  ProductRepository _repository = ProductRepository();

  Future<Product> getProduct(String productId) =>
      _repository.getProduct(productId);
}
