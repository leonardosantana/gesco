import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gesco/controller/ticket_controller.dart';
import 'package:gesco/models/ticket.dart';

import 'detailed_ticket.dart';

class TicketTile extends StatefulWidget {

  Ticket ticket;

  TicketTile(
      {@required this.ticket});

  @override
  _TicketTileState createState() => _TicketTileState();
}

class _TicketTileState extends State<TicketTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailedTicket(ticket: widget.ticket)));
      },
      child: Card(
        elevation: 5.0,
        color: Colors.white,
        child: Container(
          padding: EdgeInsets.all(5.0),
          height: 60.0,
          //color: getColorFromCategory(widget.category).withOpacity(0.5),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    /*Container(
                      width: 50.0,
                      height: 50.0,
                      //color: Colors.white,
                      child: Image.asset(getImageFromCategory(widget.category)),
                    ),
                    SizedBox(
                      width: 2,
                    ),*/
                    Container(
                      //width: 120.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.ticket.buildName,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w800),
                          ),
                          Container(
                              decoration: BoxDecoration(
                                color: TicketController.getColorFromStatus(widget.ticket.status),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 2.0, horizontal: 5),
                                child: Text(widget.ticket.status),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text('Itens: ${widget.ticket.quantity}'),
                      //Text('R\$: ${widget.ticket.cust}'),
                    ],
                  ),
                )
              ]),
        ),
      ),
    );
  }

  String getImageFromCategory(String category) {
    Map<String, String> categoryAsset = HashMap();

    categoryAsset['eletric'] = 'images/plugue.png';
    categoryAsset['hydraulic'] = 'images/encanamento.png';

    return categoryAsset[category];
  }

  Color getColorFromCategory(String category) {
    Map<String, Color> categoryAsset = HashMap();

    categoryAsset['eletric'] = Colors.yellow;
    categoryAsset['hydraulic'] = Colors.blue;

    return categoryAsset[category];
  }


}
