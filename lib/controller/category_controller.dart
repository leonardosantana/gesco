import 'package:flutter/cupertino.dart';
import 'package:gesco/models/category.dart';
import 'package:gesco/models/product.dart';

class CategoryController {

  static List<Category> _categories = [
    Category(name: 'hidraulico', products: [
      Product(name: 'Cano 50mm Barra 6m'),
      Product(name: 'Cano 20mm Barra 6m'),
      Product(name: 'Cano 10mm Barra 6m')
    ]),
    Category(name: 'eletrico', products: [
      Product(name: 'fio 10mm rolo 50m'),
      Product(name: 'mangueira eletrica rolo 50m'),
      Product(name: 'fio 5mm rolo 100m')
    ])
  ];

  static List<Category> getCategories(){
    return _categories;
  }

}
