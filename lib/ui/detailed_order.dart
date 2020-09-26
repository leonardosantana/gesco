import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gesco/app/build/build_model.dart';
import 'package:gesco/app/build/new_build/new_build_bloc.dart';
import 'package:gesco/controller/order_controller.dart';
import 'package:gesco/models/order.dart';
import 'package:gesco/models/user.dart';
import 'package:gesco/ui/new_order.dart';

import 'app_header.dart';
import 'check_items.dart';
import 'common_styles.dart';
import 'item_tile.dart';

class DetailedOrder extends StatefulWidget {
  Order order;
  Build build;
  User user;

  DetailedOrder({@required this.order, @required this.user, this.build});

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
                                        'Ordem Nº',
                                        style: TextStyle(
                                            fontSize: 24.0,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Container(
                                          decoration: BoxDecoration(
                                            color: OrderController
                                                .getColorFromStatus(
                                                    widget.order.status),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 2.0, horizontal: 5),
                                            child: Text(widget.order.status),
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
                                Text(getTextFromStatus(widget.order.status)),
                              ],
                            ),
                            ListView.builder(
                              itemCount: widget.order.items.length,
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                return ItemTile(
                                  item: widget.order.items[index],
                                  status: widget.order.status,
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    actionFromStatus(),
                  ],
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }

  Widget actionFromStatus() {
    switch (widget.order.status) {
      case 'aguardando entrega':
        return getButtonCheckDelivery();
      case 'aprovação pendente':
        return getButtonModifyOrder();
      case 'entregue':
        return getButtonNewOrderFromAbsents();
      case 'aberta':
        return getButtonAddItensOrFinalize();
      case 'aguardando compra':
        return getButtonToCheckBuyedItems();
    }
    return Text('-');
  }

  Widget getButtonModifyOrder() {
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
                widget.order.status = 'aberta';
                widget.order.modified = true;
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
                widget.order.status = 'aguardando compra';
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

  Container getButtonCheckDelivery() {
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
                  builder: (context) => CheckItems(order: widget.order)));
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

  Container getButtonNewOrderFromAbsents() {
    bool deliveryEqualsFromOrder = widget.order.items
        .where((item) => item.delivered != item.quantity)
        .isEmpty;

    return deliveryEqualsFromOrder
        ? getButtonToCloseOrder()
        : getButtonsToChoiseCloseOrderOrOpenNemOrderWithAbsent();
  }

  Container getButtonToCloseOrder() {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
      ),
      child: FlatButton(
        onPressed: () {
          setState(() {
            widget.order.status = 'concluído';
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

  Container getButtonsToChoiseCloseOrderOrOpenNemOrderWithAbsent() {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        getButtonToCloseOrder(),
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

  Widget getButtonAddItensOrFinalize() {
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
                            builder: (context) => NewOrder(
                                build: widget.build, order: widget.order)));
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
                      widget.order.status = 'aprovação pendente';
                      widget.order.modified
                          ? widget.order.modified = false
                          : addOrderInBuild(widget.build, widget.order);

                      Navigator.pop(context);
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

    NewBuildBloc _bloc = new NewBuildBloc();

    if(build.orders == null){
      build.orders = new List<Order>();
    }

    build.orders.add(order);

    _bloc.addOrder(build.documentId(), order);
  }

  Widget getButtonToCheckBuyedItems() {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
      ),
      child: FlatButton(
        onPressed: () {
          setState(() {
            widget.order.status = 'aguardando entrega';
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
