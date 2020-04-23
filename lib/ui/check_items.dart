import 'package:flutter/material.dart';
import 'package:gesco/models/item.dart';

import 'app_header.dart';

class CheckItems extends StatefulWidget {
  List<Item> items;

  List<Item> itemsToCheck;

  CheckItems({this.items});

  @override
  _CheckItemsState createState() => _CheckItemsState();
}

class _CheckItemsState extends State<CheckItems> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    print(
        'A checar ${widget.items.where((item) => item.delivered == null).length}');
    print(
        'Checados ${widget.items.where((item) => item.delivered != null).length}');

    widget.items.forEach((item) => print(
        '${item.product.name} com ${item.delivered} para entregar ${item.quantity}'));

    widget.items.where((item) => item.delivered == null).forEach((item) => print(
        '----filtrado ${item.product.name} com ${item.delivered} para entregar ${item.quantity}'));

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

                      if(widget.items.where((item) => item.delivered == null).length > 0)
                        Text(
                        'A checar',
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.w800),
                      ),
                      ListView.builder(
                        itemCount: widget.items
                            .where((item) => item.delivered == null)
                            .length,
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 5.0,
                            child: Container(
                              height: 60.0,
                              child: FlatButton(
                                onPressed: () {
                                  return showDialog(
                                      context: context,
                                      builder: (_) =>
                                          buildAlertDialog(_formKey, index));
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      widget.items
                                          .where(
                                              (item) => item.delivered == null)
                                          .toList()[index]
                                          .product
                                          .name,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w800),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      Text(
                        'Checados',
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.w800),
                      ),
                      ListView.builder(
                        itemCount: widget.items
                            .where((item) => item.delivered != null)
                            .length,
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 5.0,
                            child: Container(
                              color: widget.items
                                          .where(
                                              (item) => item.delivered != null)
                                          .toList()[index]
                                          .quantity ==
                                      widget.items
                                          .where(
                                              (item) => item.delivered != null)
                                          .toList()[index]
                                          .delivered
                                  ? Colors.green
                                  : Colors.red,
                              height: 60.0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    widget.items
                                        .where((item) => item.delivered != null)
                                        .toList()[index]
                                        .product
                                        .name,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  Text(
                                      'Pedido: ${widget.items.where((item) => item.delivered != null).toList()[index].quantity} entregue: ${widget.items.where((item) => item.delivered != null).toList()[index].delivered}')
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      if(widget.items.where((item) => item.delivered == null).length == 0)
                        Container(
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.red,
                          ),
                          child: FlatButton(
                            child: Text(
                              'Finalizar Entrega',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                    ]),
              ),
            ],
          ),
        )),
      ),
    );
  }

  AlertDialog buildAlertDialog(GlobalKey<FormState> _formKey, int index) {
    final TextEditingController myController = TextEditingController();
    return AlertDialog(
      content: Container(
          child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: myController,
              decoration: const InputDecoration(
                hintText: 'Quantidade recebida',
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Entre um valor válido';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: RaisedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    setState(() {
                      widget.items
                          .where((item) => item.delivered == null)
                          .toList()[index]
                          .delivered = int.parse(myController.text);
                      Navigator.pop(context, true);
                    });
                  }
                },
                child: Text('Confirmar'),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
