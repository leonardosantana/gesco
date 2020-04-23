import 'package:flutter/material.dart';
import 'package:gesco/models/item.dart';

class ItemTile extends StatefulWidget {
  Item item;
  String status;

  ItemTile({@required this.item, @required this.status});

  @override
  _ItemTileState createState() => _ItemTileState();
}

class _ItemTileState extends State<ItemTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(

            children: <Widget>[
              Text(widget.item.product.name),
            ],
          ),
          Column(
              children: <Widget>[
                Text(
                  getTextFromStatus(widget.status),
                  style: TextStyle(
                    color: getColorFromStatus(widget.status),),
                ),
              ]
          ),
        ],
      ),
    );
  }

  String getTextFromStatus(String status) {
    return status == 'entregue' ?
    '${widget.item.quantity.toString()}/${widget.item.delivered.toString()}' :
    '${widget.item.quantity.toString()}';
  }

  Color getColorFromStatus(String status) {
    if (status == 'entregue') {
      return widget.item.quantity == widget.item.delivered
          ? Colors.green
          : Colors.red;
    }
    return Colors.black;
  }
}
