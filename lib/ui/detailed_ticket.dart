import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gesco/controller/ticket_controller.dart';
import 'package:gesco/models/item.dart';
import 'package:gesco/models/ticket.dart';

import 'app_header.dart';
import 'check_items.dart';
import 'item_tile.dart';

class DetailedTicket extends StatefulWidget {
  Ticket ticket;

  DetailedTicket({@required this.ticket});

  @override
  _DetailedTicketState createState() => _DetailedTicketState();
}

class _DetailedTicketState extends State<DetailedTicket> {
  double screenWidth;
  double screenHeight;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
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
                                            widget.ticket.category,
                                            style: TextStyle(
                                                fontSize: 24.0,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          //Text(widget.ticket.cust.toString()),
                                          Container(
                                              decoration: BoxDecoration(
                                                color: TicketController
                                                    .getColorFromStatus(
                                                    widget.ticket.status),
                                                borderRadius:
                                                BorderRadius.circular(15),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets
                                                    .symmetric(
                                                    vertical: 2.0,
                                                    horizontal: 5),
                                                child: Text(
                                                    widget.ticket.status),
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
                          style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
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
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: <Widget>[
                                    Text('Item'),
                                    Text(getTextFromStatus(
                                        widget.ticket.status)),
                                  ],
                                ),
                                ListView.builder(
                                  itemCount: widget.ticket.itens.length,
                                  shrinkWrap: true,
                                  physics: ClampingScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    return ItemTile(
                                      item: widget.ticket.itens[index],
                                      status: widget.ticket.status,
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
    switch (widget.ticket.status) {
      case 'aguardando entrega':
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
                      builder: (context) =>
                          CheckItems(items: widget.ticket.itens)));
            },
            child: Text(
            'Conferir entrega',
            style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ),
    );
    case 'aprovação pendente':
    return Container(
    margin: EdgeInsets.all(5),
    decoration: BoxDecoration(
    color: Colors.blueAccent,
    ),
    child: FlatButton(
    child: Text(
    'Modificar pedido',
    style: TextStyle(
    fontSize: 20.0,
    color: Colors.white,
    fontWeight: FontWeight.bold),
    ),
    ),
    );
    }
    return Text('-');
    }

  String getTextFromStatus(String status) {
    return status == 'entregue' ? 'Quantidade\npedida/entregue' : 'Quantidade';
  }
}



