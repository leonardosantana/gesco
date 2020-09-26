import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gesco/controller/order_controller.dart';
import 'package:gesco/controller/user_controller.dart';
import 'package:gesco/models/order.dart';

import 'detailed_order.dart';

class OrderTile extends StatefulWidget {

  Order order;

  bool buildPage;

  OrderTile(
      {@required this.order, @required this.buildPage});

  @override
  _OrderTileState createState() => _OrderTileState();
}

class _OrderTileState extends State<OrderTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailedOrder(order: widget.order,user: UserController.user)));
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
                            'ordem nº',//${widget.order.id}*/',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w800),
                          ),
                          Container(
                              decoration: BoxDecoration(
                                color: OrderController.getColorFromStatus(widget.order.status),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 2.0, horizontal: 5),
                                child: Text(widget.order.status),
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
                      Text('Itens: ${widget.order.items.length}'),
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
