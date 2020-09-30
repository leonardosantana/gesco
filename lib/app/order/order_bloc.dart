
import 'package:gesco/app/build/build_model.dart';
import 'package:gesco/app/build/build_repository.dart';
import 'package:gesco/models/item.dart';
import 'package:gesco/models/order.dart';

class OrderBloc{

  BuildRepository _buildRepository = BuildRepository();

  Future<Order> getOrder(String documentPath){

    return _buildRepository.getOrder(documentPath);

  }

  Future<Build> getBuildbyOrderPath(String orderPath) {

    return _buildRepository.getBuildbyOrderPath(orderPath);

  }

  Future<List<Item>>getItems(String orderPath) {
    return _buildRepository.getItemsByPath(orderPath);
  }
}