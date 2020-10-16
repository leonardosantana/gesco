import 'dart:collection';

import 'package:flutter/material.dart';

enum OrderStatusEnum {
  CRIANDO,
  APROVACAO_PENDENTE,
  AGUARDANDO_COMPRA,
  AGUARDANDO_ENTREGA,
  ENTREGUE,
  CONCLUIDO
}

class OrderStatus {
  static getStatusFromEnum(OrderStatusEnum status) {
    Map<OrderStatusEnum, String> statusString = Map();

    statusString[OrderStatusEnum.CRIANDO] = 'criando';
    statusString[OrderStatusEnum.APROVACAO_PENDENTE] = 'aprovação pendente';
    statusString[OrderStatusEnum.AGUARDANDO_COMPRA] = 'aguardando compra';
    statusString[OrderStatusEnum.AGUARDANDO_ENTREGA] = 'aguardando entrega';
    statusString[OrderStatusEnum.ENTREGUE] = 'entregue';
    statusString[OrderStatusEnum.CONCLUIDO] = 'concluído';

    return statusString[status];
  }

  static getColorFromStatus(OrderStatusEnum status) {
    Map<OrderStatusEnum, Color> categoryAsset = HashMap();

    categoryAsset[OrderStatusEnum.APROVACAO_PENDENTE] = Colors.yellow;
    categoryAsset[OrderStatusEnum.AGUARDANDO_COMPRA] = Colors.orangeAccent;
    categoryAsset[OrderStatusEnum.AGUARDANDO_ENTREGA] = Colors.blue;
    categoryAsset[OrderStatusEnum.CRIANDO] = Colors.cyanAccent;
    categoryAsset[OrderStatusEnum.ENTREGUE] = Colors.green;
    categoryAsset[OrderStatusEnum.CONCLUIDO] = Colors.grey;

    return categoryAsset[status];
  }
}
