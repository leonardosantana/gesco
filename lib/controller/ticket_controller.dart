import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gesco/models/item.dart';
import 'package:gesco/models/product.dart';
import 'package:gesco/models/ticket.dart';

class TicketController {
  static List<Item> _itens = [
    Item(
        product: Product(name: 'Cano 20mm Barra 6m', category: 'hydraulic'),
        quantity: 2,
        price: 16.0),
    Item(
        product: Product(name: 'Cano 50mm Barra 6m', category: 'hydraulic'),
        quantity: 4,
        price: 18.0),
    Item(
        product: Product(name: 'Joelho 20mm peça', category: 'hydraulic'),
        quantity: 10,
        price: .50)
  ];

  static List<Item> _itensDelivered = [
    Item(
        product: Product(name: 'Cano 20mm Barra 6m', category: 'hydraulic'),
        quantity: 2,
        delivered: 2,
        price: 16.0),
    Item(
        product: Product(name: 'Cano 50mm Barra 6m', category: 'hydraulic'),
        quantity: 4,
        delivered: 4,
        price: 18.0),
    Item(
        product: Product(name: 'Joelho 20mm und', category: 'hydraulic'),
        quantity: 10,
        delivered: 8,
        price: .50)
  ];

  static List<Ticket> _tickets = [
    Ticket(
        color: Colors.blueAccent,
        category: 'hydraulic',
        cust: 10000.00,
        quantity: 10,
        buildName: 'Obra 1',
        status: 'aprovação pendente',
        itens: _itens),
    Ticket(
        color: Colors.blueAccent,
        category: 'eletric',
        cust: 10000.00,
        quantity: 11,
        buildName: 'Obra 1',
        status: 'aguardando compra',
        itens: _itens),
    Ticket(
        color: Colors.blueAccent,
        category: 'hydraulic',
        cust: 10000.00,
        quantity: 20,
        buildName: 'Obra 1',
        status: 'aguardando entrega',
        itens: _itens),
    Ticket(
        color: Colors.blueAccent,
        category: 'hydraulic',
        cust: 10000.00,
        quantity: 78,
        buildName: 'Obra 1',
        status: 'entregue',
        itens: _itensDelivered),
  ];

  static List<Ticket> getTickets() => _tickets;

  static getColorFromStatus(String status) {
    Map<String, Color> categoryAsset = HashMap();

    categoryAsset['aprovação pendente'] = Colors.yellow;
    categoryAsset['aguardando compra'] = Colors.orangeAccent;
    categoryAsset['aguardando entrega'] = Colors.blue;
    categoryAsset['entregue'] = Colors.green;

    return categoryAsset[status];
  }
}
