import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:gesco/models/item.dart';

import 'item_repository.dart';

class ItemBloc extends BlocBase {
  ItemRepository _repository = ItemRepository();

  Future<Item> getItem(String buildId, String orderId, String docId) =>
      _repository.getItem(buildId, orderId, docId);
}
