import 'package:flutter/material.dart';
import 'package:gesco/app/item/item_bloc.dart';
import 'package:gesco/app/product/product_bloc.dart';
import 'package:gesco/models/item.dart';
import 'package:gesco/models/product.dart';

class ItemTile extends StatefulWidget {
  String itemId;
  String status;
  Future<Item> awaitItem;
  Item item;

  ItemBloc _itemBloc = ItemBloc();
  ProductBloc _productBloc = ProductBloc();

  String buildId;
  String orderId;

  ItemTile({ this.itemId, this.item, @required this.buildId, @required this.orderId, @required this.status}){

      var docId = itemId != null? itemId: this.item.getId();

      if(docId != null) {
        awaitItem = _itemBloc.getItem(buildId, orderId, docId);
      }

  }

  @override
  _ItemTileState createState() => _ItemTileState();
}

class _ItemTileState extends State<ItemTile> {
  @override
  Widget build(BuildContext context) {
    if(widget.item != null){
      return buildItemTile(widget.item);
    }
    return FutureBuilder(
      future: widget.awaitItem,
      builder: (context, itemSnap) {

        if(itemSnap.connectionState != ConnectionState.done)
          return SizedBox(); //Todo loading

        Item item = itemSnap.data;

        return buildItemTile(item);
      },
    );
  }

  Container buildItemTile(Item item) {
    return Container(
        padding: EdgeInsets.all(5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: <Widget>[
                buildProductName(item),
              ],
            ),
            Column(
                children: <Widget>[
                  Text(
                    getTextFromStatus(item, widget.status),
                    style: TextStyle(
                      color: getColorFromStatus(item, widget.status),),
                  ),
                ]
            ),
          ],
        ),
      );
  }

  Widget buildProductName(Item item){

    Future<Product> awaitProduct = widget._productBloc.getProduct(buildProductId(item));

    return FutureBuilder(
      future: awaitProduct,
      builder: (context, productSnap){
        if(productSnap.connectionState != ConnectionState.done)
          return SizedBox();//todo loading Page

        Product product = productSnap.data;
        return Text(product.name);
      },
    );

  }

  String buildProductId(Item item) => item.productId == null ? item.product.documentId : item.productId;

  String getTextFromStatus(Item item, String status) {
    return status == 'entregue' ?
    '${item.quantity.toString()}/${item.delivered.toString()}' :
    '${item.quantity.toString()}';
  }

  Color getColorFromStatus(Item item, String status) {
    if (status == 'entregue') {
      return item.quantity == item.delivered
          ? Colors.green
          : Colors.red;
    }
    return Colors.black;
  }
}
