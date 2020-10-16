import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gesco/app/build/build_bloc.dart';
import 'file:///C:/Users/Leonardo%20Santana/IdeaProjects/gesco/lib/getx_app/build/build_model.dart';
import 'package:gesco/app/order/new_order/new_order_page.dart';
import 'package:gesco/app/order/order_bloc.dart';
import 'package:gesco/controller/order_controller.dart';
import 'package:gesco/models/item.dart';
import 'package:gesco/models/order.dart';
import 'package:gesco/ui/detailed_build.dart';

import 'app_header.dart';
import 'check_items.dart';
import 'common_styles.dart';
import 'item_tile.dart';

class DetailedOrder extends StatefulWidget {
  Future<Order> _order;
  Order newOrder;

  Build build;
  String orderPath;

  OrderBloc orderBloc;

  DetailedOrder({this.orderPath, this.newOrder, @required this.build, @required this.orderBloc }) {
    if (orderPath != null) {
      _order = orderBloc.getOrder(orderPath);
    }
  }

  @override
  _DetailedOrderState createState() => _DetailedOrderState();
}

class _DetailedOrderState extends State<DetailedOrder> {
  double screenWidth;
  double screenHeight;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    if (widget.newOrder != null) {
      return buildOrderContainer(context, widget.newOrder);
    }

    return FutureBuilder(
      future: widget._order,
      builder: (context, orderSnap) {
        if (orderSnap.connectionState != ConnectionState.done) {
          return SizedBox();
        }
        Order order = orderSnap.data;
        if(order.items == null){
          return FutureBuilder(
            future: widget.orderBloc.getItems(widget.orderPath),
            builder: (context, itemsSnap){
              if(itemsSnap.connectionState != ConnectionState.done)
                return SizedBox();
              order.items = itemsSnap.data;
              return buildOrderContainer(context, order);
            },
          );
        }
        return buildOrderContainer(context, order);
      },
    );
  }

  Container buildOrderContainer(BuildContext context, Order order) {
    return Container(
      child: Material(
        elevation: 8,
        child: SafeArea(
            child: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              Row(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: AppHeader(isMainPage: false),
                  ),
                ],
              ),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.all(5),
                  scrollDirection: Axis.vertical,
                  children: <Widget>[
                    SizedBox(
                      height: 20.0,
                    ),
                    Card(
                      elevation: 5.0,
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          //crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Container(
                              //width: 100.0,
                              //height: 100.0,
                              child: Row(
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Ordem Nº${order.orderNumber}',
                                        style: TextStyle(
                                            fontSize: 24.0,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 2.0, horizontal: 5),
                                            child: Text(''),
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'Itens\nSolicitados',
                      style: CommonStyles.SectionTextStyle(),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Card(
                      elevation: 5.0,
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('Item'),
                                Text(''),
                              ],
                            ),
                            buildItems(order),
                          ],
                        ),
                      ),
                    ),
                    actionFromStatus(order),
                  ],
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }

  Widget buildItems(Order order) {
    if (widget.newOrder != null) {
      return listItems(widget.newOrder.items, order);
    }

    return FutureBuilder(
      future: widget.orderBloc.getItems(widget.orderPath),
      builder: (context, itemsSnapshot) {
        if (itemsSnapshot.connectionState != ConnectionState.done) {
          return SizedBox();
        }

        List<Item> items = itemsSnapshot.data;
        return listItems(items, order);
      },
    );
  }

  Widget listItems(List<Item> items, Order order) {
    if (items == null) return SizedBox();
    return ListView.builder(
      itemCount: items.length,
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return Container();//itemTile(items[index]);
      },
    );
  }

  Widget actionFromStatus(Order order) {
    /*switch (order.status) {
      case 'aguardando entrega':
        return getButtonCheckDelivery(order);
      case 'aprovação pendente':
        return getButtonModifyOrder(order);
      case 'entregue':
        return getButtonNewOrderFromAbsents(order);
      case 'aberta':
        return getButtonAddItensOrFinalize(order);
      case 'aguardando compra':
        return getButtonToCheckBuyedItems(order);
    }*/
    return Text('-');
  }

  Widget getButtonModifyOrder(Order order) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.blueAccent,
          ),
          child: FlatButton(
            onPressed: () {
              setState(() {
                //order.status = 'aberta';
                order.modified = true;
              });
            },
            child: Text(
              'Modificar pedido',
              style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.blueAccent,
          ),
          child: FlatButton(
            onPressed: () {
              setState(() {

              });
            },
            child: Text(
              'Aprovar pedido',
              style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  Container getButtonCheckDelivery(Order order) {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
      ),
      child: FlatButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CheckItems(order: order)));
        },
        child: Text(
          'Conferir entrega',
          style: TextStyle(
              fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  String getTextFromStatus(String status) {
    return status == 'entregue' ? 'Quantidade\npedida/entregue' : 'Quantidade';
  }

  Container getButtonNewOrderFromAbsents(Order order) {
    bool deliveryEqualsFromOrder =
        order.items.where((item) => item.delivered != item.quantity).isEmpty;

    return deliveryEqualsFromOrder
        ? getButtonToCloseOrder(order)
        : getButtonsToChoiseCloseOrderOrOpenNemOrderWithAbsent(order);
  }

  Container getButtonToCloseOrder(Order order) {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
      ),
      child: FlatButton(
        onPressed: () {
          setState(() {
          });
        },
        child: Text(
          'Finalizar',
          style: TextStyle(
              fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Container getButtonsToChoiseCloseOrderOrOpenNemOrderWithAbsent(Order order) {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        getButtonToCloseOrder(order),
        Container(
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.blueAccent,
          ),
          child: FlatButton(
            child: Text(
              'Nova com itens Faltantes',
              style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    ));
  }

  Widget getButtonAddItensOrFinalize(Order order) {
    return Column(
      children: <Widget>[
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                ),
                child: FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NewOrderPage(
                                build: widget.build, order: order)));
                  },
                  child: Text(
                    'Adicionar Item',
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                ),
                child: FlatButton(
                  onPressed: () {
                    setState(() {
                      order.modified
                          ? updateOrderInBuild(widget.build, order)
                          : addOrderInBuild(widget.build, order);
                      widget.orderBloc.addOrderOnBuild(order);

                      Navigator.pushReplacement(context,MaterialPageRoute(
                          builder: (context) => DetailedBuild(
                              build: widget.build)));
                    });
                  },
                  child: Text(
                    'Fazer Solicitação',
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void addOrderInBuild(Build build, Order order) {
    BuildBloc _bloc = new BuildBloc();

    _bloc.addOrder(build, order);
  }

  void updateOrderInBuild(Build build, Order order) {
    BuildBloc _bloc = new BuildBloc();

    _bloc.updateOrder(build, order);
  }

  Widget getButtonToCheckBuyedItems(Order order) {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
      ),
      child: FlatButton(
        onPressed: () {
          setState(() {
          });
        },
        child: Text(
          'Itens Comprados',
          style: TextStyle(
              fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }



  }

